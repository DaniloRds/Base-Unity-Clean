-- client.lua

local Tunnel = module("vrp", "lib/Tunnel")
local unity_core = Tunnel.getInterface("unity_core")

-- Tabela que armazenará os vRP IDs (chave: server id, valor: vRP id)
local players = {}

-- Variável de controle para ativar/desativar a exibição (wall)
local wallEnabled = false

-- Comando /wall para alternar a exibição dos IDs e das linhas
RegisterCommand("wall", function(source, args, rawCommand)
	if unity_core.getPermissao() then
		wallEnabled = not wallEnabled
	end
end, false)

-- Evento para atualizar a tabela de players enviada pelo servidor
RegisterNetEvent("unity_core:updatePlayers")
AddEventHandler("unity_core:updatePlayers", function(ids)
    players = ids
end)

-- Função para desenhar texto 3D na tela
function DrawText3D(x, y, z, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        -- Tamanho do fundo baseado no tamanho do texto
        local textLength = string.len(text) * 0.005
        local rectHeight = 0.08  -- Altura do fundo
        local rectWidth = 0.15  -- Largura do fundo com uma margem

        -- Desenha o fundo preto atrás do texto
        DrawRect(_x, _y + 0.03, rectWidth, rectHeight, 0, 0, 0, 150)  -- Preto com 150 de transparência

        -- Configuração do texto
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.3)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 255, 255, 255, 150)  -- Borda branca
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function GetWeaponNameFromHash(hash)
    local weapons = {
        [GetHashKey("WEAPON_UNARMED")] = "Sem Arma",
        [GetHashKey("WEAPON_PISTOL")] = "Pistola",
        [GetHashKey("WEAPON_COMBATPISTOL")] = "Pistola de Combate",
        [GetHashKey("WEAPON_APPISTOL")] = "Pistola Automática",
        [GetHashKey("WEAPON_SMG")] = "SMG",
        [GetHashKey("WEAPON_MICROSMG")] = "Micro SMG",
        [GetHashKey("WEAPON_ASSAULTSMG")] = "SMG de Assalto",
        [GetHashKey("WEAPON_ASSAULTRIFLE")] = "Rifle de Assalto",
        [GetHashKey("WEAPON_CARBINERIFLE")] = "Carabina",
        [GetHashKey("WEAPON_ADVANCEDRIFLE")] = "Rifle Avançado",
        [GetHashKey("WEAPON_MG")] = "Metralhadora",
        [GetHashKey("WEAPON_COMBATMG")] = "Metralhadora de Combate",
        [GetHashKey("WEAPON_SNIPERRIFLE")] = "Rifle Sniper",
        [GetHashKey("WEAPON_HEAVYSNIPER")] = "Sniper Pesado",
        [GetHashKey("WEAPON_PUMPSHOTGUN")] = "Escopeta",
        [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "Escopeta Serrada",
        [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = "Escopeta Bullpup",
        [GetHashKey("WEAPON_STUNGUN")] = "Taser",
        [GetHashKey("WEAPON_GRENADE")] = "Granada",
        [GetHashKey("WEAPON_STICKYBOMB")] = "C4",
        [GetHashKey("WEAPON_MOLOTOV")] = "Molotov",
        [GetHashKey("WEAPON_FIREEXTINGUISHER")] = "Extintor",
        [GetHashKey("WEAPON_PETROLCAN")] = "Galão de Gasolina",
    }

    return weapons[hash] or "Arma Desconhecida"
end

Citizen.CreateThread(function()
    while true do
        if wallEnabled then
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            for _, id in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(id)
                if DoesEntityExist(ped) then
                    local x, y, z = table.unpack(GetEntityCoords(ped))
                    local distance = #(vector3(x, y, z) - myCoords)

                    if distance <= 250 then
                        local serverId = tostring(GetPlayerServerId(id))
                        local userData = players or { userId = "Desconhecido", steam = "Steam não encontrada" }

                        -- Vida do jogador (normalizando entre 0 e 100)
                        local health = GetEntityHealth(ped) - 100
                        if health < 0 then health = 0 end

                        -- Verifica invisibilidade pelo alpha
                        local isInvisible = IsEntityVisible(ped) and "Não" or "Sim"

                        -- Pega o nome da arma do jogador
                        local weaponHash = GetSelectedPedWeapon(ped)
                        local weaponName = GetWeaponNameFromHash(weaponHash) -- Agora garantido que funciona

                        -- Monta o texto
                        local infoText = ("[ %s | %s ]\n Vida: %d | Invisível: %s \n Arma: %s"):format(
                            userData.playerIDs, userData.steam, health, isInvisible, weaponName
                        )

                        -- Desenha o texto e a linha
                        DrawText3D(x, y, z + 1.1, infoText, 255, 255, 255)
                        DrawLine(myCoords.x, myCoords.y, myCoords.z, x, y, z, 255, 255, 255, 255)
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

