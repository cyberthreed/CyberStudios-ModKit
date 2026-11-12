require("Objects.B2Entity")
require("Components.B2BuffComponent")
require("Components.B2CrimeComponent")

local D = {}
D.pending = "TipsyZois_DUICrashPending"
D.cooldown = "TipsyZois_DUIIncidentCooldown"
D.stages = {
    {id="TipsyZois_Blackout_Stage", chance=20},
    {id="TipsyZois_Wasted_Stage", chance=10},
    {id="TipsyZois_Drunk", chance=5},
}

---@param buffs FB2BuffComponent
function D.stage(buffs)
    for _, stage in ipairs(D.stages) do
        if inzoi.FB2BuffComponent.HasBuff(buffs, stage.id) then return stage end
    end
end

---@param buffs FB2BuffComponent
function D.blocked(buffs)
    for _, id in ipairs({D.pending, D.cooldown, "TipsyZois_DUICustody"}) do
        if inzoi.FB2BuffComponent.HasBuff(buffs, id) then return true end
    end
    return false
end

-- Native buffs provide per-character save/load deduplication. No MCP, external
-- process, provider or CyberCore installation is required by this standalone mod.
---@param char FB2Character
---@param source string
function D.begin(char, source)
    local buffs = inzoi.FB2Entity.GetComponent(char, inzoi.EB2ComponentType.Buff)
    if not buffs then return false, "buff_component_unavailable" end
    local stage = D.stage(buffs)
    if not stage then return false, "not_intoxicated" end
    if D.blocked(buffs) then return false, "incident_already_recorded" end
    local crime = inzoi.FB2Entity.GetComponent(char, inzoi.EB2ComponentType.Crime)
    if crime and inzoi.FB2CrimeComponent.HasPendingImprisonment(crime) then
        return false, "native_custody_already_pending"
    end
    local active = inzoi.FB2BuffComponent.GetBuff(buffs, stage.id)
    if not active then return false, "stage_observation_missing" end
    inzoi.FB2BuffComponent.AddBuffImmediately(buffs, D.pending, active.Detail, "None")
    if not inzoi.FB2BuffComponent.HasBuff(buffs, D.pending) then
        return false, "incident_marker_not_applied"
    end
    inzoi.FB2BuffComponent.AddBuffImmediately(buffs, D.cooldown, active.Detail, "None")
    print("[TipsyZois DUI v3] Incident recorded: driver=" .. tostring(char.EntityId.Value)
        .. " stage=" .. stage.id .. " source=" .. source)
    return true
end

return D
