require("Objects.B2Entity")
require("Objects.B2Character")
require("Components.B2BuffComponent")
require("Components.B2LifeComponent")
require("Components.B2InteractionComponent")
require("Components.B2DreamComponent")
require("Systems.B2TimeManager")
-- TipsyZois: use the native walking action only during Blackout's first 90 game minutes.
local M = {}
local STAGE = "TipsyZois_Blackout_Stage"
local WINDOW = "TipsyZois_SleepwalkingWindow"
local POISON = "TipsyZois_AlcoholPoisoning_Active"
local DEATH_PENDING = "TipsyZois_AlcoholPoisoning_DeathPending"
local DEATH_TRIGGER = "TipsyZois_AlcoholPoisoning_Death"
local DEATH_BAG = "TipsyZois_AlcoholPoisoning_DeathBag"
local TREATED = "TipsyZois_AlcoholPoisoning_Treated"
local CURED = "TipsyZois_AlcoholPoisoningCured"
local POSE = "TipsyZois_SleepwalkingPose"
local BAG = "TipsyZois_IB_BlackoutWalk"
local POOL = "TipsyZois_BlackoutDreamPool"
local MINUTE = 600000000

local STATUS_PREFIX = "TipsyZois_SW_"
local STATUS_STEPS = {"Checking", "Intro", "WaitingForAction", "InVehicle",
    "Queued", "Walking", "RequestFailed", "PoseFailed"}
---@param self table
---@param char FB2Character
---@param step string|nil
local function status(self, char, step)
    local tag = step and (STATUS_PREFIX .. step) or nil
    if self.lastStatus == step
        and (not tag or inzoi.FB2Entity.HasTag(char, tag)) then return end
    for _, name in ipairs(STATUS_STEPS) do
        inzoi.FB2Entity.RemoveTag_WithLock(char, STATUS_PREFIX .. name)
    end
    if tag then inzoi.FB2Entity.AddTag(char, tag, 5) end
    self.lastStatus = step
end

---@param char FB2Character
---@param kind EB2ComponentType
local function component(char, kind)
    return inzoi.FB2Entity.GetComponent(char, kind)
end

---@param self table
---@param char FB2Character
local function stop(self, char)
    local dream = component(char, inzoi.EB2ComponentType.Dream)
    local interaction = component(char, inzoi.EB2ComponentType.Interaction)
    local buffs = component(char, inzoi.EB2ComponentType.Buff)
    if dream then
        inzoi.FB2DreamComponent.RequestEndSleepwalking(dream)
        if dream.CurrentPoolId == POOL then
            inzoi.FB2DreamComponent.RequestEndDream(dream)
        end
    end
    if interaction then
        inzoi.FB2InteractionComponent.TryCancelInteractionByBagId(
            interaction, BAG, inzoi.EB1InteractionCancelReason.Clear, "TipsyZois sleepwalking window ended")
    end
    if buffs then
        inzoi.FB2BuffComponent.RemoveBuff(buffs, POSE, true)
    end
    if dream then
        inzoi.FB2DreamComponent.ResetCheatData(dream)
        dream.SleepwalkingBuffId = self.originalSleepBuff or "Sleep"
    end
    self.owned = false
    self.episode = nil
    self.lastRequest = nil
    self.nextCancelReal = nil
    self.nativeRequested = false
    status(self, char, nil)
end

---@param self table
---@param char FB2Character
---@param dt number
function M.on_tick(self, char, dt)
    local clock = inzoi.getB2Manager("FB2TimeManager")
    if not clock or inzoi.FB2TimeManager.IsPaused(clock) then return end
    local realNow = inzoi.FB2TimeManager.GetAccRealTime(clock)
    if self.lastRealClock and realNow < self.lastRealClock then
        self.nextCheckReal = nil
        self.nextCancelReal = nil
    end
    self.lastRealClock = realNow
    if self.nextCheckReal and realNow < self.nextCheckReal then return end
    self.nextCheckReal = realNow + 0.2
    local buffs = component(char, inzoi.EB2ComponentType.Buff)
    if not buffs or inzoi.FB2Character.IsDeath(char) then return end
    local life = component(char, inzoi.EB2ComponentType.Life)
    -- A completed, confirmed non-ghost poisoning death must reach the native
    -- character death request. Do not replay its animation or touch a cure,
    -- an active episode, immortality, another death cause, or the ghost route.
    if life and tostring(life.ConfirmedDeathTriggerId) == DEATH_TRIGGER
        and not inzoi.FB2LifeComponent.IsTriggeredLifeTrigger(life)
        and not life.bCanGhost
        and not inzoi.FB2BuffComponent.HasBuff(buffs, POISON)
        and not inzoi.FB2BuffComponent.HasBuff(buffs, CURED)
        and not inzoi.FB2Entity.HasTag(char, TREATED) then
        local deathInteraction = component(char, inzoi.EB2ComponentType.Interaction)
        local current = deathInteraction
            and tostring(inzoi.FB2InteractionComponent.GetCurrentInteractionBagId(deathInteraction)) or "None"
        if current ~= DEATH_BAG and current ~= "DeathByPoison" and current ~= "DeathInVehicle" then
            if not life.bInvincible and not self.deathFinalizeRequested then
                self.deathFinalizeRequested = true
                inzoi.FB2Character.RequestDie(char)
            end
        end
        return
    end
    local deathPending = inzoi.FB2BuffComponent.HasBuff(buffs, DEATH_PENDING)
    if deathPending and (inzoi.FB2Entity.HasTag(char, TREATED)
        or inzoi.FB2BuffComponent.HasBuff(buffs, CURED)) then
        inzoi.FB2BuffComponent.RemoveBuff(buffs, DEATH_PENDING, true)
        deathPending = false
    end
    -- Native life events own their interaction queue through the death popup
    -- and final registration. The poisoning lock must not cancel that work.
    if life and inzoi.FB2LifeComponent.IsTriggeredLifeTrigger(life) then return end
    if deathPending then
        -- Buff finish scripts can run while the expiring buff is still in the
        -- map. Hand off on a later tick, after its interaction whitelist clears.
        -- The hidden marker persists through save/load and is consumed once.
        if not inzoi.FB2BuffComponent.HasBuff(buffs, POISON) and life then
            local dream = component(char, inzoi.EB2ComponentType.Dream)
            if self.owned or (dream and dream.CurrentSleepwalkInteractionBagId == BAG) then
                stop(self, char)
            end
            inzoi.FB2LifeComponent.AddLifeTrigger(life, DEATH_TRIGGER)
            inzoi.FB2BuffComponent.RemoveBuff(buffs, DEATH_PENDING, true)
        end
        return
    end
    -- The whitelist blocks unrelated interactions. Cancel a pre-existing
    -- active action without discarding a cure waiting in the queue.
    if inzoi.FB2BuffComponent.HasBuff(buffs, POISON) then
        local poison = inzoi.FB2BuffComponent.GetBuff(buffs, POISON)
        if poison and poison.Duration < 0 then
            -- Older saves used an infinite poisoning buff. Start the newly
            -- introduced treatment window on migration, not retroactively.
            local timer = inzoi.getB2Manager("FB2TimeManager")
            if timer then
                poison.StartTime = inzoi.FB2TimeManager.GetCurrentTicks(timer)
                poison.Duration = 120 * MINUTE
                poison.EmotionValue = 60
                inzoi.FB2BuffComponent.Send_S_UpdateBuffMap(buffs)
            end
        end
        local interaction = component(char, inzoi.EB2ComponentType.Interaction)
        if interaction then
            local current = tostring(inzoi.FB2InteractionComponent.GetCurrentInteractionBagId(interaction))
            if current ~= "TipsyZois_CureAlcoholPoisoning" and current ~= "None" and current ~= "" then
                inzoi.FB2InteractionComponent.TryCancelCurrentInteraction(
                    interaction, inzoi.EB1InteractionCancelReason.Clear)
            end
        end
        local dream = component(char, inzoi.EB2ComponentType.Dream)
        if self.owned or (dream and dream.CurrentSleepwalkInteractionBagId == BAG) then
            stop(self, char)
        end
        return
    end
    local hasStage = inzoi.FB2BuffComponent.HasBuff(buffs, STAGE)
    local dream = component(char, inzoi.EB2ComponentType.Dream)
    local ownsDream = dream and (tostring(dream.CurrentSleepwalkInteractionBagId) == BAG
        or tostring(dream.CurrentPoolId) == POOL)
    local hasPose = inzoi.FB2BuffComponent.HasBuff(buffs, POSE)
    if not hasStage and not self.owned and not ownsDream and not hasPose then
        status(self, char, nil)
        return
    end
    local stage = hasStage and inzoi.FB2BuffComponent.GetBuff(buffs, STAGE) or nil
    local time = inzoi.getB2Manager("FB2TimeManager")
    if not time then return end
    local now = inzoi.FB2TimeManager.GetCurrentTicks(time)
    local active = stage
        and inzoi.FB2BuffComponent.HasBuff(buffs, WINDOW)
        and not inzoi.FB2BuffComponent.HasBuff(buffs, POISON)
        and now >= stage.StartTime
        and now < stage.StartTime + 90 * MINUTE
    if not active then
        if self.owned or ownsDream or hasPose then stop(self, char) end
        status(self, char, nil)
        return
    end
    local interaction = component(char, inzoi.EB2ComponentType.Interaction)
    if not dream or not interaction then return end
    local context = char.VehicleContext
    local riding = context and context.RidingVehicleEntityId
    local ridingId = riding and tonumber(tostring(riding.Value)) or -1
    if ridingId >= 0 then
        if self.owned or ownsDream or hasPose then stop(self, char) end
        status(self, char, "InVehicle")
        return
    end
    if not self.owned then
        self.originalSleepBuff = dream.SleepwalkingBuffId
        if not self.originalSleepBuff or self.originalSleepBuff == POSE then self.originalSleepBuff = "Sleep" end
        self.owned = true
        self.episode = stage.StartTime
    end
    -- Blackout stays the visible mood. The private hidden marker carries no
    -- Sleep emotion, and native Sleep/Drowsiness buffs are not part of it.
    if inzoi.FB2BuffComponent.HasBuff(buffs, "Sleep") then
        inzoi.FB2BuffComponent.RemoveBuff(buffs, "Sleep", true)
    end
    if inzoi.FB2BuffComponent.HasBuff(buffs, "TipsyZois_BlackoutDrowsiness") then
        inzoi.FB2BuffComponent.RemoveBuff(buffs, "TipsyZois_BlackoutDrowsiness", true)
    end
    local current = tostring(inzoi.FB2InteractionComponent.GetCurrentInteractionBagId(interaction))
    local queued = inzoi.FB2InteractionComponent.IsInQueue_InteractionBagId(interaction, BAG)
    if current == BAG then status(self, char, "Walking"); return end
    if queued then status(self, char, "Queued"); return end
    if inzoi.FB2DreamComponent.IsSleepwalking(dream) or dream.bDreaming then return end
    -- Enter through the native Dream controller once. It selects the private
    -- native walk sequence and sends the real sleepwalking start notification.
    -- No CLI re-enqueue loop and no repeated cancellation of other actions.
    if self.nativeRequested then return end
    self.nativeRequested = true
    if not inzoi.FB2BuffComponent.HasBuff(buffs, POSE) then
        inzoi.FB2BuffComponent.AddBuffImmediately(buffs, POSE, stage.Detail, "None")
    end
    local pose = inzoi.FB2BuffComponent.GetBuff(buffs, POSE)
    if not pose then status(self, char, "PoseFailed"); return end
    pose.StartTime = now
    pose.Duration = stage.StartTime + 90 * MINUTE - now
    pose.EmotionValue = 0
    inzoi.FB2BuffComponent.Send_S_UpdateBuffMap(buffs)
    dream.SleepwalkingBuffId = POSE
    inzoi.FB2DreamComponent.ForceDreamPoolId(dream, POOL)
    inzoi.FB2DreamComponent.ForceSleepwalkingInteractionBagId(dream, BAG)
    inzoi.FB2DreamComponent.ForceDream(dream, true)
    inzoi.FB2DreamComponent.RequestStartDream(dream)
    status(self, char, "Queued")
end

---@param self table
---@param char FB2Character
function M.on_end(self, char)
    local dream = component(char, inzoi.EB2ComponentType.Dream)
    local buffs = component(char, inzoi.EB2ComponentType.Buff)
    if self.owned or (dream and tostring(dream.CurrentSleepwalkInteractionBagId) == BAG)
        or (buffs and inzoi.FB2BuffComponent.HasBuff(buffs, POSE)) then
        stop(self, char)
    end
    status(self, char, nil)
end

return M
