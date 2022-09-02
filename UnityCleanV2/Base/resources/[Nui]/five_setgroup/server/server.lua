local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "five_setgroup")

local cfg = module("vrp", "cfg/groups")
local groups = cfg.groups

RegisterNetEvent('five_setgroup:buscarGrupos')
AddEventHandler('five_setgroup:buscarGrupos',function(id)
    local user_id = vRP.getUserId(source)
    local playerId = tonumber(id)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local ssgrupo = {}
        local ppgrupo = {}
        for s_grupos, k in pairs(groups) do
            if s_grupos ~= "user" then table.insert(ssgrupo, s_grupos) end
        end

        p_grupos = vRP.getUserGroups(playerId)
        for x, y in pairs(p_grupos) do
            if x ~= "user" then table.insert(ppgrupo, x) end
        end

        table.sort(ppgrupo)
        table.sort(ssgrupo)

        TriggerClientEvent("five_setgroup:abrirAdminG", source, ssgrupo, ppgrupo, playerId)
    end
end)

RegisterNetEvent('five_setgroup:aceito')
AddEventHandler('five_setgroup:aceito',function(grupos, playerId)
    local player = tonumber(playerId)

    p_grupos = vRP.getUserGroups(player)
    for x, y in pairs(p_grupos) do
            if x ~= "user" then
                if x == "Ultimate" or x == "Elite" or x == "Premium" or x == "Standard" then
                    if not vRP.getVipActive(player) then
                        vRP.deleteVip(parseInt(player))
                    end
                end
                vRP.removeUserGroup(player, x)
            end
        --print(x)
    end

    for a,b in pairs(grupos) do
        if b == "Ultimate" or b == "Elite" or b == "Premium" or b == "Standard" then
            if not vRP.getVipActive(player) then
                vRP.insertNewVip(parseInt(player),tostring(b))
            end
        end
        vRP.addUserGroup(player,b)
    end
end)

RegisterCommand("limpar", function(source, args)
    TriggerClientEvent('vrp_escconcessionaria:limpar',-1)
end)
