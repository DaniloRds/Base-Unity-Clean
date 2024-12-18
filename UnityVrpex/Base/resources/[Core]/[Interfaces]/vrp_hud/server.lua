local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_hud",src)

function src.getStats()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.getThirst(user_id),vRP.getHunger(user_id)
end

local vhunger = 0
local vthirst = 0

---------------------------------------------------------
-- /EAT
---------------------------------------------------------
RegisterCommand("eat",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,config_permstaff) then
        vRP.varyThirst(user_id, -100)
        vRP.varyHunger(user_id, -100)
    end
end)