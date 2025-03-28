-- server.lua

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
arc = {}
Tunnel.bindInterface("unity_core", arc)
Proxy.addInterface("unity_core", arc)
vRP = Proxy.getInterface("vRP")
Config = module("unity_core", "config_wall")
-- NÃO sobrescreva o Config!

-- Função simplificada para retornar o vRP ID do jogador
function arc.getId(sourceplayer)
    return vRP.getUserId(sourceplayer)
end

-- Função de permissão
function arc.getPermissao()
    local source = source
    local user_id = arc.getId(source)
    if vRP.hasPermission(user_id,Config.permwall) then
        return true
    end
end

function GetPlayerIdentifiers(player)
    local numIds = GetNumPlayerIdentifiers(player)
    local t = {}

    for i = 0, numIds - 1 do
        table.insert(t, GetPlayerIdentifier(player, i))
    end

    return t
end

function getSteam(source)
	local identifiers = GetPlayerIdentifiers(source)
	for k, v in ipairs(identifiers) do
		if string.sub(v, 1, 5) == 'steam' then
			return v
		end
	end
end

Citizen.CreateThread(function()
    while true do
        local playerIDs = {}
        local steamIdentifier = "Não encontrado"
    
        for _, playerId in ipairs(GetPlayers()) do
            local sId = tonumber(playerId)
            local user_id = vRP.getUserId(sId)
            local id_source = vRP.getUserSource(user_id)
            if user_id then
                playerIDs = user_id
                steamIdentifier = getSteam(id_source)
            end
        end

        local players = {
            playerIDs = playerIDs,
            steam = steamIdentifier
        }

        TriggerClientEvent("unity_core:updatePlayers", -1, players)
        Citizen.Wait(2000)
    end
end)

local players = {}

RegisterNetEvent("fivem:updatePlayers")
AddEventHandler("fivem:updatePlayers", function()
    local src = source
    local identifiers = GetPlayerIdentifiers(src)
    local steamIdentifier = "Não encontrado"

    for _, v in ipairs(identifiers) do
        if string.find(v, "steam:") then
            steamIdentifier = v
            break
        end
    end

    players[tostring(src)] = {
        steam = steamIdentifier,
        userId = tostring(src) 
    }

    print(players)
    TriggerClientEvent("fivem:syncPlayers", -1, players) 
end)

AddEventHandler("playerDropped", function()
    local src = source
    players[tostring(src)] = nil
    TriggerClientEvent("fivem:syncPlayers", -1, players)
end)