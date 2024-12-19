--------------------------------
-- [ CONEXAO ] --
--------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_concessionaria", src)
vSERVER = Tunnel.getInterface("vrp_concessionaria")

local ConceNumber = 0
local CarroSelect = "null"
local myveh = {}
local inTeste = false

Citizen.CreateThread(function()
    for k, v in pairs(Config.Conce) do
        TriggerEvent("hoverfy:insertTable",{{ v.blip['x'],v.blip['y'],v.blip['z'], 1.5, "E","Concessionária","Pressione para abrir/fechar o menu" }})
    end
end)

Citizen.CreateThread(function()
    while true do
        local t = 1000
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))
        for k, v in pairs(Config.Conce) do
            if Vdist(x, y, z, v.blip['x'], v.blip['y'], v.blip['z']) <= 5.5 then
                t = 2
                    DrawMarker(30,v.blip['x'], v.blip['y'], v.blip['z']-0.1,0,0,0,0.0,0,0,0.5,0.5,0.5,
                    13, 127, 233,
                    196,0,0,0,10)
                    -- DrawMarker(27,v.blip['x'], v.blip['y'], v.blip['z']-0.9,0,0,0,0.0,0,0,1.0,1.0,1.0, 0,0,0, 196,0,0,0,10)
                if IsControlJustPressed(0, 38) then
                    -- if vRP.getNearestPlayer(3) == nil then
                        if Vdist(x, y, z, v.blip['x'], v.blip['y'], v.blip['z']) <= 1.5 then
                            TriggerEvent('vRP:abrirConce')
                        end
                    -- else
                        -- TriggerEvent("Notify", "negado",
                            -- "Você está muito próximo de alguém! Afaste-se para abrir o baú!")
                    -- end
                end
            end
        end

        Citizen.Wait(t)
    end
end)

RegisterNetEvent('vRP:abrirConce')
AddEventHandler('vRP:abrirConce', function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    for k, v in pairs(Config.Conce) do
        if Vdist(x, y, z, v.blip['x'], v.blip['y'], v.blip['z']) <= 5.5 then
            local nome_player, imagem_player, ok = vSERVER.return_nome()
            CarroSelect = "null"
            ConceNumber = k
            SetNuiFocus(true, true)
            SetCursorLocation(0.5, 0.5)
            StartScreenEffect("MenuMGSelectionIn", 0, true)
            TriggerEvent('hudOff',true)
            SendNUIMessage({
                action = "showMenu",
                nome_player = nome_player:upper(),
                imagem_player = imagem_player,
                ok = ok
            })
        end
    end
end)

RegisterNetEvent('vRP:fecharConce')
AddEventHandler('vRP:fecharConce', function()
    SetNuiFocus(false, false)
    TriggerEvent('hudOff',false)
    SendNUIMessage({
        action = "hideMenu"
    })
    StopScreenEffect("MenuMGSelectionIn")
    nui_open = false
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
    TriggerEvent('hudOff',false)
    SendNUIMessage({
        action = "hideMenu"
    })
    StopScreenEffect("MenuMGSelectionIn")
    nui_open = false
end)

RegisterNUICallback("consultCarrosList", function(data, cb, imgperfil)
    vSERVER.consultCarros(ConceNumber, data.lista)
    local consultCarros = vSERVER.consultCarrosList()
    if consultCarros then
        cb({
            consultCarros = consultCarros
        })
    end
end)

RegisterNUICallback("verCarros", function(data, cb, imgperfil)
    CarroSelect = data.carro
    local x, y, z = table.unpack(GetEntityCoords(ped, false))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x, y, z))
    cb({
        retorno = 'done',
        street = street
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName, vehPlate)
    local mHash = GetHashKey(vehName)

    RequestModel(mHash)
    while not HasModelLoaded(mHash) do
        Citizen.Wait(1)
    end

    if HasModelLoaded(mHash) then
        vehDrive = CreateVehicle(mHash, -53.9, -1110.5, 26.34, 68.04, false, false)

        SetEntityInvincible(vehDrive, true)
        SetVehicleNumberPlateText(vehDrive, vehPlate)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("testeDrive", function(data, cb)
    local driveIn, vehPlate = vSERVER.startDrive()
    if vSERVER.checkEstoqueVehicle(CarroSelect) then
        if driveIn and inTeste == false then
            SetNuiFocus(false, false)
            SetCursorLocation(0.5, 0.5)
            SendNUIMessage({
                action = "closeSystem"
            })
            TriggerEvent("races:insertList", true)
            LocalPlayer["state"]["Commands"] = true
            TriggerEvent("Notify", "sucesso", "Teste iniciado, para finalizar espere o tempo de 30 segundos acabar.",
                5000)
            src.TesteDrive()
        end
    else
        TriggerEvent("Notify", "aviso", "Não temos o veículo no estoque para realizar seu teste drive, seu dinheiro foi reembolsado.", 8000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD ANTI BUGS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 999
        if benDrive then
            timeDistance = 1
            DisableControlAction(1, 69, false)
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped) then
                Citizen.Wait(1000)
                inTeste = false
                vSERVER.removeDrive()
                TriggerEvent("races:insertList", false)
                LocalPlayer["state"]["Commands"] = false
                SetEntityCoords(ped, benCoords[1], benCoords[2], benCoords[3], 1, 0, 0, 0)
                DeleteEntity(vehDrive)
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
--
function split(s, delimiter)
    result = {};
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match);
    end
    return result;
end
--
RegisterNUICallback("comprarCarro", function(data, cb)
    SetNuiFocus(false, false)
    TriggerEvent('hudOff',false)
    SendNUIMessage({
        action = "hideMenu"
    })
    StopScreenEffect("MenuMGSelectionIn")
    nui_open = false
    vSERVER.comprarCarro(CarroSelect, data.red, data.green, data.blue)
end)

-- RegisterNUICallback("alugarcarro",function(data,cb)
-- 	SetNuiFocus(false,false)
-- 	SendNUIMessage({ action = "hideMenu" })
-- 	StopScreenEffect("MenuMGSelectionIn")
-- 	nui_open = false
-- 	vSERVER.comprarCarro(CarroSelect,data.red,data.green,data.blue)
-- end)

-- RegisterNUICallback("comprarCarro2",function(data,cb)
-- 	SetNuiFocus(false,false)
-- 	SendNUIMessage({ action = "hideMenu" })
-- 	StopScreenEffect("MenuMGSelectionIn")
-- 	nui_open = false
-- 	vSERVER.comprarCarroVip(CarroSelect,data.red,data.green,data.blue)
-- end)

RegisterNUICallback("venderCarro", function(data, cb)
    SetNuiFocus(false, false)
    TriggerEvent('hudOff',false)
    SendNUIMessage({
        action = "hideMenu"
    })
    StopScreenEffect("MenuMGSelectionIn")
    nui_open = false
    vSERVER.venderCarro(data.carro)
end)

src.TesteDrive = function()
    local bhash = CarroSelect

    local playerPed = PlayerPedId()
    local playerpos = GetEntityCoords(playerPed)
    if not inTeste then
        while not HasModelLoaded(bhash) do
            RequestModel(bhash)
            Citizen.Wait(10)
        end
        local ped = PlayerPedId()
        local x, y, z = vRP.getPosition()
        TriggerEvent('hudOff',false)
        vSERVER.AlterarMundo()
        Wait(1000)
        veh = CreateVehicle(bhash, Config.Teste_Drive + 0.2, 0.83, true, false) -- LOCALIDADE TEST DRIVE
        SetPedIntoVehicle(playerPed, veh, -1)
        inTeste = true
        SetVehicleIsStolen(veh, false)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh, false)
        SetVehicleDoorsLocked(veh, 4)
        SetVehicleDoorsLockedForAllPlayers(veh, 4)
        SetVehicleNumberPlateText(veh, "TEST DRIVE") -- PLACA DO VEÍCUILO
        Citizen.InvokeNative(0xAD738C3085FE7E11, veh, true, true)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehRadioStation(veh, "OFF")
        SetVehicleEngineOn(GetVehiclePedIsIn(ped, false), true)
        SetModelAsNoLongerNeeded(bhash)
        Wait(Config.Segundos * 1000)
        if inTeste then
            inTeste = false
            vSERVER.removeDrive()
            TriggerEvent("Notify", "aviso", "O tempo de seu teste drive acabou!", 8000)
            DeleteVehicle(veh)
            testedrive = false
            SetEntityCoords(playerPed, playerpos, false, false, false, false)
        end
    end

end
