require("Objects.B2Entity")
require("Objects.B2Character")
require("Objects.B2Vehicle")
require("Components.B2BuffComponent")
require("Systems.B2EntityManager")
require("Systems.B2TimeManager")
-- DUI hearings use the next calendar day, 14:00-17:00.
-- Native CreateSiteEvent uses DaysFromNow=1 and hour=14.
local DUI_TRIAL_DAY_OFFSET = 1
local DUI_TRIAL_START_HOUR = 14
local DUI_RELEASE_LEAD_MINUTES = 10
local GAME_MINUTE_TICKS = 600000000
local GAME_DAY_TICKS = 1440 * GAME_MINUTE_TICKS
local DUI_CUSTODY = "TipsyZois_DUICustody"
---@param char FB2Character
local function syncDuiCustody(char)
    local buffs = char:GetComponent(inzoi.EB2ComponentType.Buff)
    if not buffs or not inzoi.FB2BuffComponent.HasBuff(buffs, DUI_CUSTODY)
        or not inzoi.FB2BuffComponent.HasBuff(buffs, "TipsyZois_DUICrashPending")
        or not inzoi.FB2BuffComponent.HasBuff(buffs, "Crime_Sentence_Day1") then return end
    local custody = inzoi.FB2BuffComponent.GetBuff(buffs, DUI_CUSTODY)
    local sentence = inzoi.FB2BuffComponent.GetBuff(buffs, "Crime_Sentence_Day1")
    -- Only adjust the sentence created with this DUI arrest.
    if math.abs(sentence.StartTime - custody.StartTime) > 5 * GAME_MINUTE_TICKS then return end
    local arrestDay = math.floor(custody.StartTime / GAME_DAY_TICKS) * GAME_DAY_TICKS
    local releaseTicks = arrestDay + DUI_TRIAL_DAY_OFFSET * GAME_DAY_TICKS
        + (DUI_TRIAL_START_HOUR * 60 - DUI_RELEASE_LEAD_MINUTES) * GAME_MINUTE_TICKS
    local duration = releaseTicks - sentence.StartTime
    if duration > 0 and sentence.Duration ~= duration then
        sentence.Duration = duration
        inzoi.FB2BuffComponent.Send_S_UpdateBuffMap(buffs)
    end
end

-- Vehicle timers are bound directly to Car entities. This Zoi module
-- retains only the existing next-day custody synchronization.
local M = {}
---@param self table
---@param char FB2Character
---@param dt number
function M.on_tick(self, char, dt)
    syncDuiCustody(char)
end
return M
