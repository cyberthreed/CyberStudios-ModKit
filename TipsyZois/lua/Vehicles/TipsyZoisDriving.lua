require("Objects.B2Entity")
require("Objects.B2Actor")
require("Objects.B2Vehicle")
require("Components.B2BuffComponent")
require("Systems.B2EntityManager")
require("Systems.B2TimeManager")

-- One risk check per seven real seconds of movement, for the actual driver.
local M = {}
local CHECK_SECONDS = 7
local STAGES = {
    { id="TipsyZois_Blackout_Stage", chance=20 },
    { id="TipsyZois_Wasted_Stage", chance=10 },
    { id="TipsyZois_Drunk", chance=5 },
}
local PENDING = "TipsyZois_DUICrashPending"

local function numberId(id)
    return id and tonumber(tostring(id.Value)) or -1
end

---@param self table
local function reset(self)
    self.controllerVersion = 2
    self.driverId = nil
    self.stageId = nil
    self.elapsed = 0
    self.lastTime = nil
    self.lastX = nil
    self.lastY = nil
    self.lastZ = nil
    self.wasPaused = false
    self.fired = false
    self.pendingTrigger = false
    self.nextAttemptTime = nil
    self.lastError = nil
    self.rollCount = 0
    self.lastRoll = nil
end

---@param self table
---@param driverId number
---@param now number
local function requestCrash(self, driverId, now)
    if now < (self.nextAttemptTime or 0) then return end
    local idText = string.format("%.0f", driverId)
    local ok, message = inzoi.cli.execute("buff.add entity_id=" .. idText
        .. " buff_id=" .. PENDING)
    if ok then
        self.fired = true
        self.pendingTrigger = false
        self.lastError = nil
        print("[TipsyZois DUI] Crash trigger accepted for driver " .. idText)
    else
        self.nextAttemptTime = now + 1
        if self.lastError ~= message then
            self.lastError = message
            print("[TipsyZois DUI] Crash trigger failed for driver " .. idText
                .. ": " .. tostring(message))
        end
    end
end

---@param self table
---@param vehicle FB2Vehicle
---@param dt number
function M.on_tick(self, vehicle, dt)
    -- Discard timer state from the earlier guaranteed-trigger controller.
    if self.controllerVersion ~= 2 then reset(self) end
    local driver = inzoi.FB2Vehicle.GetDriverId(vehicle)
    if numberId(driver) < 0 then driver = inzoi.FB2Vehicle.GetSimulationDriverId(vehicle) end
    local driverId = numberId(driver)
    if driverId < 0 then reset(self); return end
    local manager = inzoi.getB2Manager("FB2EntityManager")
    local char = manager and inzoi.FB2EntityManager.FindCharacter(manager, driver)
    if not char then reset(self); return end
    local buffs = inzoi.FB2Entity.GetComponent(char, inzoi.EB2ComponentType.Buff)
    if not buffs then reset(self); return end
    local stage = nil
    for _, entry in ipairs(STAGES) do
        if inzoi.FB2BuffComponent.HasBuff(buffs, entry.id) then stage = entry; break end
    end
    -- Feelin' Good, Tipsy, and sober drivers never roll.
    if not stage then reset(self); return end
    if inzoi.FB2BuffComponent.HasBuff(buffs, PENDING) then return end
    local time = inzoi.getB2Manager("FB2TimeManager")
    if not time then return end
    local now = inzoi.FB2TimeManager.GetAccRealTime(time)
    local location = inzoi.FB2Actor.GetLocation(vehicle)
    if self.driverId ~= driverId or not self.lastTime then
        reset(self)
        self.driverId = driverId
        self.lastTime = now
        self.lastX, self.lastY, self.lastZ = location.X, location.Y, location.Z
        return
    end
    self.stageId = stage.id
    local delta = math.max(0, now - self.lastTime)
    self.lastTime = now
    local dx = location.X - self.lastX
    local dy = location.Y - self.lastY
    local dz = location.Z - self.lastZ
    self.lastX, self.lastY, self.lastZ = location.X, location.Y, location.Z
    if inzoi.FB2TimeManager.IsPaused(time) then
        self.wasPaused = true
        return
    end
    if self.wasPaused then
        self.wasPaused = false
        return
    end
    local velocity = inzoi.FB2Vehicle.GetVelocity(vehicle)
    local moving = inzoi.FB2Vehicle.GetSpeed(vehicle) > 1
        or velocity.X * velocity.X + velocity.Y * velocity.Y + velocity.Z * velocity.Z > 1
        or dx * dx + dy * dy + dz * dz > 0.01
    if not moving or self.fired then return end
    -- Retain a successful risk roll if the native request needs a retry.
    if self.pendingTrigger then requestCrash(self, driverId, now); return end
    self.elapsed = (self.elapsed or 0) + delta
    while self.elapsed + 0.000001 >= CHECK_SECONDS do
        self.elapsed = math.max(0, self.elapsed - CHECK_SECONDS)
        self.rollCount = (self.rollCount or 0) + 1
        local roll = math.random(1, 100)
        self.lastRoll = roll
        print("[TipsyZois DUI] Driver " .. string.format("%.0f", driverId)
            .. " stage=" .. stage.id .. " check=" .. tostring(self.rollCount)
            .. " roll=" .. tostring(roll) .. " chance=" .. tostring(stage.chance))
        if roll <= stage.chance then
            self.pendingTrigger = true
            requestCrash(self, driverId, now)
            return
        end
    end
end

return M
