require("Components.B2CrimeComponent")
require("Systems.B2EntityManager")
local DUI = require("TipsyZois.DUI")
local M = {}

-- Observe actual native accidents caused by this component's owner. Preserve
-- the native handler exactly once; never manufacture a collision or passenger fault.
---@param owner FB2CrimeComponent
---@param VehicleAccidentId string
---@param TargetEntityId FB1EntityId
function M.Override_OnVehicleAccidentCaused(owner, VehicleAccidentId, TargetEntityId)
    owner:OnVehicleAccidentCaused(VehicleAccidentId, TargetEntityId)
    local id = tostring(VehicleAccidentId)
    if id == "" or id == "None" then return end
    local ok, errorMessage = pcall(function()
        local manager = inzoi.getB2Manager("FB2EntityManager")
        local char = manager and inzoi.FB2EntityManager.FindCharacter(manager, owner:GetOwnerEntityId())
        if char then DUI.begin(char, "native_accident:" .. id) end
    end)
    if not ok then print("[TipsyZois DUI v3] Accident observation failed: " .. tostring(errorMessage)) end
end

return M
