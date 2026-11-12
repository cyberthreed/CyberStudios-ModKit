require("Objects.B2Entity")
require("Objects.B2Actor")
require("Objects.B2Vehicle")
require("Systems.B2EntityManager")
require("Systems.B2TimeManager")
local DUI = require("TipsyZois.DUI")
local M = {}
local CHECK_SECONDS = 7

local function numberId(id)
    return id and tonumber(tostring(id.Value)) or -1
end

---@param self table
local function reset(self)
    self.controllerVersion = 3
    self.driverId, self.stageId, self.lastTime = nil, nil, nil
    self.lastX, self.lastY, self.lastZ = nil, nil, nil
    self.elapsed, self.rollCount, self.attempts = 0, 0, 0
    self.pendingTrigger, self.wasPaused = false, false
    self.nextAttemptTime, self.lastError = nil, nil
end

---@param self table
---@param char FB2Character
---@param now number
local function requestIncident(self, char, now)
    if now < (self.nextAttemptTime or 0) then return end
    self.attempts = self.attempts + 1
    local ok, accepted, reason = pcall(DUI.begin, char, "driving_risk_roll")
    if ok and accepted then
        reset(self)
    elseif ok and (reason == "incident_already_recorded" or reason == "native_custody_already_pending") then
        reset(self)
    elseif self.attempts >= 3 then
        print("[TipsyZois DUI v3] Incident deferred after 3 failed marker attempts")
        self.pendingTrigger, self.attempts, self.elapsed = false, 0, 0
        self.nextAttemptTime = now + CHECK_SECONDS
    else
        self.nextAttemptTime = now + 1
        local message = tostring(ok and reason or accepted)
        if message ~= self.lastError then
            self.lastError = message
            print("[TipsyZois DUI v3] Incident marker failed: " .. message)
        end
    end
end

---@param self table
---@param vehicle FB2Vehicle
---@param dt number
function M.on_tick(self, vehicle, dt)
    if self.controllerVersion ~= 3 then reset(self) end
    local driver = inzoi.FB2Vehicle.GetDriverId(vehicle)
    if numberId(driver) < 0 then driver = inzoi.FB2Vehicle.GetSimulationDriverId(vehicle) end
    local driverId = numberId(driver)
    if driverId < 0 then reset(self); return end
    local manager = inzoi.getB2Manager("FB2EntityManager")
    local char = manager and inzoi.FB2EntityManager.FindCharacter(manager, driver)
    local buffs = char and inzoi.FB2Entity.GetComponent(char, inzoi.EB2ComponentType.Buff)
    local stage = buffs and DUI.stage(buffs)
    if not stage or DUI.blocked(buffs) then reset(self); return end
    local time = inzoi.getB2Manager("FB2TimeManager")
    if not time then return end
    local now = inzoi.FB2TimeManager.GetAccRealTime(time)
    local location = inzoi.FB2Actor.GetLocation(vehicle)
    if self.driverId ~= driverId or self.stageId ~= stage.id or not self.lastTime or now < self.lastTime then
        reset(self)
        self.driverId, self.stageId, self.lastTime = driverId, stage.id, now
        self.lastX, self.lastY, self.lastZ = location.X, location.Y, location.Z
        return
    end
    -- No burst of risk checks after reloads, time skips or a stalled frame.
    local delta = math.min(1, math.max(0, now - self.lastTime))
    self.lastTime = now
    local dx, dy, dz = location.X-self.lastX, location.Y-self.lastY, location.Z-self.lastZ
    self.lastX, self.lastY, self.lastZ = location.X, location.Y, location.Z
    if inzoi.FB2TimeManager.IsPaused(time) then self.wasPaused = true; return end
    if self.wasPaused then self.wasPaused = false; return end
    local velocity = inzoi.FB2Vehicle.GetVelocity(vehicle)
    local moving = math.abs(inzoi.FB2Vehicle.GetSpeed(vehicle)) > 1
        or velocity.X^2+velocity.Y^2+velocity.Z^2 > 1 or dx^2+dy^2+dz^2 > 0.01
    if not moving then return end
    if self.pendingTrigger then requestIncident(self, char, now); return end
    if now < (self.nextAttemptTime or 0) then return end
    self.elapsed = self.elapsed + delta
    if self.elapsed + 0.000001 < CHECK_SECONDS then return end
    self.elapsed = math.max(0, self.elapsed-CHECK_SECONDS)
    self.rollCount = self.rollCount + 1
    local roll = math.random(1,100)
    print("[TipsyZois DUI v3] Moving driver=" .. tostring(driverId) .. " stage=" .. stage.id
        .. " roll=" .. tostring(roll) .. " chance=" .. tostring(stage.chance))
    if roll <= stage.chance then self.pendingTrigger = true; requestIncident(self, char, now) end
end

return M
