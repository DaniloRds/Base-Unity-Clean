------------------SCRIPT CORRIGIDO POR ANDERSON FABRIS
------------------SUPORTE PELO DISCORD: AndiGame#5670
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("vrp_skinshop")

local lojaderoupa = {
    { name = "Loja de Roupas", id = 73, color = 13, x = 71.15, y = -1399.14, z = 29.38, provador = {x = 71.15, y = -1399.14, z = 29.38, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -710.018, y = -153.072, z = 37.415, provador = {x = -710.018, y = -153.072, z = 37.415, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -163.261, y = -302.830, z = 39.733, provador = {x = -163.261, y = -302.830, z = 39.733, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 425.51, y = -806.27, z = 29.49, provador = {x = 425.51, y = -806.27, z = 29.49, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -829.413, y = -1073.710, z = 11.500, provador = {x = -829.413, y = -1073.710, z = 11.500, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -1450.320, y = -237.514, z = 49.810, provador = {x = -1450.320, y = -237.514, z = 49.810, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 12.138, y = 6514.402, z = 31.877, provador = {x = 12.138, y = 6514.402, z = 31.877, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 125.112, y = -223.696, z = 54.557, provador = {x = 125.112, y = -223.696, z = 54.557, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 471.04, y = -988.26, z = 25.74, provador = {x = 471.04, y = -988.26, z = 25.74, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -822.34, y = -1073.49, z = 11.32, provador = {x = -822.34, y = -1073.49, z = 11.32, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -1193.81, y = -768.49, z = 17.31, provador = {x = -1193.81, y = -768.49, z = 17.31, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 4.90, y = 6512.47, z = 31.87, provador = {x = 4.90, y = 6512.47, z = 31.87, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 1693.95, y = 4822.67, z = 42.06, provador = {x = 1693.95, y = 4822.67, z = 42.06, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 614.26, y = 2761.91, z = 42.08, provador = {x = 614.26, y = 2761.91, z = 42.08, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 1196.74, y = 2710.21, z = 38.22, provador = {x = 1196.74, y = 2710.21, z = 38.22, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -3170.18, y = 1044.54, z = 20.86, provador = {x = -3170.18, y = 1044.54, z = 20.86, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -1101.46, y = 2710.57, z = 19.10, provador = {x = -1101.46, y = 2710.57, z = 19.10, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 986.79, y = -92.89, z = 74.85, provador = {x = 986.79, y = -92.89, z = 74.85, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 315.11, y = -603.75, z = 43.3, provador = {x = 315.11, y = -603.75, z = 43.3, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = 105.6, y = -1303.11, z = 28.8, provador = {x = 105.6, y = -1303.11, z = 28.8, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -311.16, y = -137.12, z = 39.01, provador = {x = -311.16, y = -137.12, z = 39.01, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -2675.62, y = 1326.18, z = 144.26, provador = {x = -2675.62, y = 1326.18, z = 144.26, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -1887.3, y = 2070.19, z = 145.58, provador = {x = -1887.3, y = 2070.19, z = 145.58, heading = 0.0}},
    { name = "Loja de Roupas", id = 73, color = 13, x = -2584.34, y = 1885.88, z = 140.87, provador = {x = -2584.34, y = 1885.88, z = 140.87, heading = 180.0}}
}

local parts = {
    mascara = 1,
    mao = 3,
    calca = 4,
    mochila = 5,
    sapato = 6,
    gravata = 7,
    camisa = 8,
    colete = 9,
    jaqueta = 11,
    bone = "p0",
    oculos = "p1",
    brinco = "p2",
    relogio = "p6",
    bracelete = "p7"
}

local carroCompras = {
    mascara = false,
    mao = false,
    calca = false,
    mochila = false,
    sapato = false,
    gravata = false,
    camisa = false,
    jaqueta = false,
    colete = false,
    bone = false,
    oculos = false,
    brinco = false,
    relogio = false,
    bracelete = false
}

local old_custom = {}

local valor = 0
local precoTotal = 0

local in_loja = false
local atLoja = false

-- Provador
local chegou = false
local noProvador = false

-- Cam controll
local pos = nil
local camPos = nil
local cam = -1
local dataPart = 1
local texturaSelected = 0
local handsup = false

function SetCameraCoords()
    local ped = PlayerPedId()
	RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
	if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
		SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
        SetCamCoord(cam, camPos.x, camPos.y, camPos.z+0.75)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.15)
    end

end

function DeleteCam()
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 0, true, true)
	cam = nil
end

RegisterNUICallback("changePart", function(data, cb)
    dataPart = parts[data.part]
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({ 
            changeCategory = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            changeCategory = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end
end)

---------------------------------------
-- BLIPS
---------------------------------------

-- Cria hoverfy
Citizen.CreateThread(function()
    for k,v in pairs(lojaderoupa) do
        TriggerEvent("hoverfy:insertTable",{{ lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, 1.5, "E",v.name,"Pressione para abrir/fechar o menu" }})
    end
end)

Citizen.CreateThread(function()
    while true do
        local tdg = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, true)
        for k, v in pairs(lojaderoupa) do
            local provador = lojaderoupa[k].provador
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 5 and not in_loja then
                tdg = 1
                DrawMarker(30,lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z-0.4,0,0,0,0.0,0,0,0.4,0.4,0.4,45,125,180,255,0,0,0,1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 4 then
                if IsControlJustPressed(0, 38) then
                    valor = 0
                    precoTotal = 0
                    noProvador = true
                    old_custom = vRP.getCustomization()
                    old = {}
                    cor = 0
		            dados, tipo = nil
                    TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
                    TriggerEvent('hudOff',true)
                    hiddenPlayers()
                    local animDic = "move_m@generic_idles@std"
    
                    RequestAnimDict(animDic)
                    while not HasAnimDictLoaded(animDic) do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(PlayerPedId(), animDic, "idle_a", 8.0, 8.0, -1, 50, 0, false, false, false)
                end
            end

            if noProvador then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) < 0.5 and not chegou then
                    chegou = true
                    valor = 0
                    precoTotal = 0
                    SetEntityHeading(PlayerPedId(), provador.heading)
                    -- FreezeEntityPosition(ped, true)
                    SetEntityInvincible(ped, false)
                    openGuiLojaRoupa()


                end
            end
        end
        Citizen.Wait(tdg)
    end
end)

-- OCULTAR/DESOCULTAR PLAYERS

local isHidingPlayers = false

function hiddenPlayers()
    local ped = PlayerPedId()
    local playerId = PlayerId()
    local coords = GetEntityCoords(ped)
    local radius = 50.0

    isHidingPlayers = not isHidingPlayers 

    if isHidingPlayers then
        for _, player in ipairs(GetActivePlayers()) do
            if player ~= playerId then 
                local otherPed = GetPlayerPed(player)
                local otherCoords = GetEntityCoords(otherPed)
                local distance = #(coords - otherCoords)

                if distance <= radius then
                    SetEntityVisible(otherPed, false, false)
                    SetLocalPlayerInvisibleLocally(player, true)
                    SetEntityAlpha(otherPed, 0, false)
                end
            end
        end
    else
        for _, player in ipairs(GetActivePlayers()) do
            if player ~= playerId then
                local otherPed = GetPlayerPed(player)
                SetEntityVisible(otherPed, true, false)
                SetLocalPlayerInvisibleLocally(player, false)
                ResetEntityAlpha(otherPed)
            end
        end
    end
end

-- FUNÇÕES DE NUI

function openGuiLojaRoupa()
    local ped = PlayerPedId()
    SetNuiFocus(true, true)
    SetCameraCoords()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end

    in_loja = true
end

RegisterNUICallback("leftHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading-tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

RegisterNUICallback("handsUp", function(data, cb)
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
    end
    
    if not handsup then
        TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNUICallback("rightHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading+tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

function updateCarroCompras()
    valor = 0
    for k, v in pairs(carroCompras) do
        if carroCompras[k] == true then
            valor = valor + 75
        end
    end
    precoTotal = valor
    return valor
end

RegisterNUICallback("changeColor", function(data, cb)
    if type(dados) == "number" then
        max = GetNumberOfPedTextureVariations(PlayerPedId(), dados, tipo)
    elseif type(dados) == "string" then
        max = GetNumberOfPedPropTextureVariations(PlayerPedId(), parse_part(dados), tipo)
    end

    if data.action == "menos" then
        if cor > 0 then cor = cor - 1 else cor = max end
    elseif data.action == "mais" then
        if cor < max then cor = cor + 1 else cor = 0 end
    end
    if dados and tipo then setRoupa(dados, tipo, cor) end
end)

function changeClothe(type, id)
    dados = type
    tipo = tonumber(parseInt(id))
	cor = 0
    setRoupa(dados, tipo, cor)
end

function setRoupa(dados, tipo, cor)
    local ped = PlayerPedId()

	if type(dados) == "number" then
		SetPedComponentVariation(ped, dados, tipo, cor, 1)
    elseif type(dados) == "string" then
        SetPedPropIndex(ped, parse_part(dados), tipo, cor, 1)
        dados = "p" .. (parse_part(dados))
	end
	  
  	custom = vRP.getCustomization()
  	custom.modelhash = nil

	aux = old_custom[dados]
	v = custom[dados]

    if v[1] ~= aux[1] and old[dados] ~= "custom" then
        carroCompras[dados] = true
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "add" })
    	old[dados] = "custom"
    end
    if v[1] == aux[1] and old[dados] == "custom" then
        carroCompras[dados] = false
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "remove" })
    	old[dados] = "0"
	end

	SendNUIMessage({ value = price })
end

RegisterNUICallback("changeCustom", function(data, cb)
    changeClothe(data.type, data.id)
end)

RegisterNUICallback("payament", function(data, cb)
    carroCompras = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        gravata = false,
        camisa = false,
        jaqueta = false,
        colete = false,
        bone = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false
    }
    TriggerServerEvent("LojaDeRoupas:Comprar", tonumber(data.price)) 
end)

RegisterNUICallback("reset", function(data, cb)
    vRP.setCustomization(old_custom)
    TriggerServerEvent('vrp_tattoo:setPedClient')
    TriggerServerEvent('vrp_barber:setPedClient')
    closeGuiLojaRoupa()
    ClearPedTasks(PlayerPedId())
end)

function closeGuiLojaRoupa()
    local ped = PlayerPedId()
    DeleteCam()
    SetNuiFocus(false, false)
    SendNUIMessage({ openLojaRoupa = false })
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    PlayerReturnInstancia()
    SendNUIMessage({ action = "setPrice", price = 0, typeaction = "remove" })
    
    in_loja = false
    noProvador = false
    chegou = false
    old_custom = {}
    TriggerEvent('hudOff',false)
    hiddenPlayers()
end

------------------------------------
-- UPDATEROUPAS
------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
    vRP.setCustomization(custom)
    TriggerServerEvent('vrp_tattoo:setPedClient')
    TriggerServerEvent('vrp_barber:setPedClient')
end)

RegisterNetEvent('LojaDeRoupas:ReceberCompra')
AddEventHandler('LojaDeRoupas:ReceberCompra', function(comprar)
    if comprar then
        in_loja = false
        closeGuiLojaRoupa()
    else
        in_loja = false
        vRP.setCustomization(old_custom)
        TriggerServerEvent('vrp_tattoo:setPedClient')
        TriggerServerEvent('vrp_barber:setPedClient')
        closeGuiLojaRoupa()
        TriggerEvent('hudOff',false)
        hiddenPlayers()
    end
end)
--
function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

function PlayerInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, true)
            SetEntityNoCollisionEntity(ped, otherPlayer, true)
        end
    end
end

function PlayerReturnInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, true)
            SetEntityCollision(ped, true)
        end
    end
end

function criarBlip()
    for _, item in pairs(lojaderoupa) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipColour(item.blip, item.color)
        SetBlipScale(item.blip, 0.4)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function drawText2D(text,font,x,y,scale,r,g,b,a)    
    SetTextFont(font)    
    SetTextScale(scale,scale)    
    SetTextColour(r,g,b,a)    
    SetTextOutline()    
    SetTextCentre(1)    
    SetTextEntry('STRING')    
    AddTextComponentString(text)    
    DrawText(x,y)
end

Citizen.CreateThread(function()
    while true do
        if noProvador then
            PlayerInstancia()
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 24, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 106, true)
            DisableControlAction(1, 37, true)
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        N_0xf4f2c0d4ee209e20()
        Citizen.Wait(1000)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeGuiLojaRoupa()
    end
end)