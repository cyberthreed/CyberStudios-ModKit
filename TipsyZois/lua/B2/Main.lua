-- Migrate saved DUI role data from builds that used unregistered text keys
-- and the native-only trial whitelist. Native non-DUI cases are untouched.
require("Objects.B2Entity")
require("Components.B2BuffComponent")
require("Systems.B2EntityManager")
require("Systems.B2SiteEventManager")
require("Systems.B2TimeManager")
local M = {}
local nextCheck = 0
local roles = {
 Trial_User=1, Trial_Host01=2, Trial_Host02=3, Trial_Host03=4,
 Trial_Host04=5, Trial_Police=6, Trial_Guest=7
}
local oldPrefix = "mod_SocialEventTemplate_SocialEvent_Trial_TipsyZois_DUI_RoleInfos_"
local function recoverSavedDuiRoles()
 local manager = inzoi.getB2Manager("FB2EntityManager")
 local events = inzoi.getB2Manager("FB2SiteEventManager")
 if not manager or not events then return end
 for _, event in ipairs(inzoi.FB2SiteEventManager.GetAllSiteEvents(events)) do
  if tostring(event.EventDtId) == "SocialEvent_Trial_TipsyZois_DUI" then
   for key, role in pairs(event.StageRoleDatas) do
    local index = roles[tostring(key)]
    if index then
     local info = role.StageRoleInfo
     local name = tostring(info.NameTextId)
     local desc = tostring(info.RoleDescTextId)
     if name:sub(1,#oldPrefix) == oldPrefix then
      info.NameTextId = "mod_Buff_TipsyZois_DUI_Trial_Role_" .. index .. "_Name"
     end
     if desc:sub(1,#oldPrefix) == oldPrefix then
      info.RoleDescTextId = "mod_Buff_TipsyZois_DUI_Trial_Role_" .. index .. "_Desc"
     end
     for _, field in ipairs({"StartScriptInfos","CancelScriptInfos","FinishScriptInfos"}) do
      for _, script in ipairs(info[field]) do
       if tostring(script.ScriptId) == "Script_Add_WhiteListBuff_Trial" then
        script.ScriptId = "TipsyZois_DUI_AddWhitelist"
       elseif tostring(script.ScriptId) == "Script_Remove_WhiteListBuff_Trial" then
        script.ScriptId = "TipsyZois_DUI_RemoveWhitelist"
       end
      end
     end
     role.StageRoleInfo = info
     for _, id in ipairs(role.MemberIds) do
      local char = inzoi.FB2EntityManager.FindCharacter(manager,id)
      if char then
       local buffs = char:GetComponent(inzoi.EB2ComponentType.Buff)
       if buffs and inzoi.FB2BuffComponent.HasBuff(buffs,"Whitelist_Trial") then
        if not inzoi.FB2BuffComponent.HasBuff(buffs,"TipsyZois_DUI_Whitelist_Trial") then
         local old = inzoi.FB2BuffComponent.GetBuff(buffs,"Whitelist_Trial")
         inzoi.FB2BuffComponent.AddBuffImmediately(buffs,"TipsyZois_DUI_Whitelist_Trial",old.Detail,"None")
        end
        inzoi.FB2BuffComponent.RemoveBuff(buffs,"Whitelist_Trial",true)
       end
      end
     end
    end
   end
  end
 end
end
function M.on_begin()
 nextCheck = 0
 recoverSavedDuiRoles()
end
function M.on_tick()
 local time = inzoi.getB2Manager("FB2TimeManager")
 if not time then return end
 local now = inzoi.FB2TimeManager.GetCurrentTicks(time)
 if now < nextCheck then return end
 nextCheck = now + 600000000
 recoverSavedDuiRoles()
end
return M
