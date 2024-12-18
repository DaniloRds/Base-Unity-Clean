local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP") 

dPN = {}
Tunnel.bindInterface("vrp_tattoo",dPN)
Proxy.addInterface("vrp_tattoo",dPN)
dPNserver = Tunnel.getInterface("vrp_tattoo")

atuaisTatoo = {}
local tatuagensjaaplicadas = {}
podemostrartexto = true
local deixarinvisivelplayer = false
local naroupas = false
Camera = {}
Camera.entity = nil
Camera.position = vector3(0.0, 0.0, 0.0)
Camera.currentView = 'corpo'
Camera.active = false
Camera.radius = 1.25
Camera.angleX = 30.0
Camera.angleY = 0.0
Camera.mouseX = 0
Camera.mouseY = 0

Camera.radiusMin = 1.0
Camera.radiusMax = 2.25
Camera.angleYMin = -30.0
Camera.angleYMax = 80.0
local carroCompras = {
    mascara = false,
    mao = false,
    calca = false,
    mochila = false,
    sapato = false,
    gravata = false,
    camisa = false,
    colete = false,
    jaqueta = false,
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

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    TransitionFromBlurred(1000)
    SetNuiFocus(false, false)
    FreezeEntityPosition(ped, false)
    criarBlip()
end)


function deixarInivisivel()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, false)
            SetEntityNoCollisionEntity(ped, otherPlayer, true)
        end
    end
end

function openTattoo()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "showMenu", url = Config_client['url'] })
    dPNserver.getAtuaistatto()
    old_custom = getCustomization()
    Camera.currentView = 'corpo'
    Activate(500)
    podemostrartexto = false
    naroupas = true
    deixarinvisivelplayer = true
    setInvisible()
    dPNserver.setFalse()
end

function oldCustomDefinied()
    old_custom = getCustomization()
end

function getCustomization()
    local ped = PlayerPedId()
    local custom = {}
    custom.modelhash = GetEntityModel(ped)
    for i = 0,11 do
        --print("Passou 2", i)
        --if i ~= 2 then 
            custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
       -- end
    end
 
    for i = 0, 10 do
        custom["p" .. i] = {GetPedPropIndex(ped, i), math.max(GetPedPropTextureIndex(ped, i), 0)}
    end
    return custom
end

function setInvisible()
    if deixarinvisivelplayer == true then
        Citizen.CreateThread(function()
            if Config_client['invisivel'] == true then
                while naroupas do
                    deixarInivisivel()
                    DisableControlAction(1, 1, true)
                    DisableControlAction(1, 2, true)
                    DisableControlAction(1, 24, true)
                    DisablePlayerFiring(PlayerPedId(), true)
                    DisableControlAction(1, 142, true)
                    DisableControlAction(1, 106, true)
                    DisableControlAction(1, 37, true)
                    Wait(1)
                end
            end
        end)
    end
end

function criarBlip()
    if Config_client['lojaTatoo'] then
        for _, item in pairs(Config_client['lojaTatoo']) do
            if Config_client['markerConfirmation'] then
                if Config_client['markerConfirmation'] == true then
                    item.blip = AddBlipForCoord(item.x, item.y, item.z)
                    SetBlipSprite(item.blip, Config_client['markerId'])
                    SetBlipColour(item.blip, Config_client['markerColor'])
                    SetBlipScale(item.blip, 0.5)
                    SetBlipAsShortRange(item.blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(Config_client['markerName'])
                    EndTextCommandSetBlipName(item.blip)
                end
            end
        end
    end
end

RegisterNUICallback('removeClothes', function(data)
        if data.roupa then
            local ped = PlayerPedId()
            if data.roupa == "mascara" then
                if GetPedDrawableVariation(ped, 1) ~= Config_client['roupas']['mascara'] then
                    SetPedComponentVariation(ped, 1, Config_client['roupas']['mascara'], 0, 2)
            elseif GetPedDrawableVariation(ped, 1) == Config_client['roupas']['mascara'] then
                    SetPedComponentVariation(ped, 1, old_custom[1][1], old_custom[1][2], old_custom[1][3])
            end
        elseif data.roupa == "blusa" then
                if GetPedDrawableVariation(ped, 9) ~= Config_client['roupas']['colete'] then
                    SetPedComponentVariation(ped, 9, Config_client['roupas']['colete'], 0, 2)
            elseif GetPedDrawableVariation(ped, 9) == Config_client['roupas']['colete'] then
                    SetPedComponentVariation(ped, 9, old_custom[9][1], old_custom[9][2], old_custom[9][3])
            end

            if GetPedDrawableVariation(ped, 8) ~= Config_client['roupas']['jaqueta'] then
                    SetPedComponentVariation(ped, 8, Config_client['roupas']['jaqueta'], 0, 2)
            elseif GetPedDrawableVariation(ped, 8) == Config_client['roupas']['jaqueta'] then
                    SetPedComponentVariation(ped, 8, old_custom[8][1], old_custom[8][2], old_custom[8][3])
            end

            if GetPedDrawableVariation(ped, 11) ~= Config_client['roupas']['blusa'] then
                    SetPedComponentVariation(ped, 11, Config_client['roupas']['blusa'], 0, 2)
            elseif GetPedDrawableVariation(ped, 11) == Config_client['roupas']['blusa'] then
                    SetPedComponentVariation(ped, 11, old_custom[11][1], old_custom[11][2], old_custom[11][3])
            end
        elseif data.roupa == "luva" then
                if GetPedDrawableVariation(ped, 3) ~= Config_client['roupas']['luva'] then
                    SetPedComponentVariation(ped, 3, Config_client['roupas']['luva'], 0, 2)
            elseif GetPedDrawableVariation(ped, 3) == Config_client['roupas']['luva'] then
                    SetPedComponentVariation(ped, 3, old_custom[3][1], old_custom[3][2], old_custom[3][3])
            end
        elseif data.roupa == "calca" then
                if GetPedDrawableVariation(ped, 4) ~= Config_client['roupas']['calca'] then
                    SetPedComponentVariation(ped, 4, Config_client['roupas']['calca'], 0, 2)
            elseif GetPedDrawableVariation(ped, 4) == Config_client['roupas']['calca'] then
                    SetPedComponentVariation(ped, 4, old_custom[4][1], old_custom[4][2], old_custom[4][3])
            end
        elseif data.roupa == "sapato" then
                if GetPedDrawableVariation(ped, 6) ~= Config_client['roupas']['sapato'] then
                    SetPedComponentVariation(ped, 6, Config_client['roupas']['sapato'], 0, 2)
            elseif GetPedDrawableVariation(ped, 6) == Config_client['roupas']['sapato'] then
                    SetPedComponentVariation(ped, 6, old_custom[6][1], old_custom[6][2], old_custom[6][3])
            end
        end
    end
end)

RegisterNUICallback("roupasClose", function(data)
        local ped = PlayerPedId()
        SetNuiFocus(false, false)
        SendNUIMessage({
            openLojaRoupa = false
    })
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityInvincible(ped, false)
        Deactivate()
        SendNUIMessage({
            action = "hideMenu",
            value = 0
    })
        setCustomization(old_custom)
        ClearPedTasks(PlayerPedId())
        in_loja = false
        podemostrartexto = true
        deixarinvisivelplayer = false
        noProvador = false
        chegou = false
        naroupas = false
        old_custom = {}
        deixarVisivel()
        atuaisTatoo = {}
        dPNserver.getAtuaistatto()
        TriggerServerEvent('dpn_barber:setPedClient')
end)
    
    function deixarVisivel()
        for _, player in ipairs(GetActivePlayers()) do
            local ped = PlayerPedId()
            local otherPlayer = GetPlayerPed(player)
            if ped ~= otherPlayer then
                SetEntityVisible(otherPlayer, true)
                SetEntityVisible(ped, true)
                SetEntityCollision(ped, true)
        end
    end
end

function refreshTattoos(tatuagem, tipo)
    local tableTatoo = {}
    if tatuagem and tipo then
            ClearPedDecorations(GetPlayerPed(-1))
            if atuaisTatoo[tatuagem] == tipo then -- Ja  tem a tatu
                for k, v in pairs(atuaisTatoo) do
                    if k ~= tatuagem then
                        SetPedDecoration(PlayerPedId(), GetHashKey(v), GetHashKey(k))
                end
                atuaisTatoo[tatuagem] = nil
            end
            valor = valor - Config_client['price']
            SendNUIMessage({
                    action = "setPrice",
                price = valor,
                typeaction = "add"
            })
        else -- ja tem a tatuagem e quer tirar

            if json.encode(atuaisTatoo) == "[]" then -- Não tem nenhuma tatuagem
                if tableTatoo[tatuagem] ~= true then
                    SetPedDecoration(PlayerPedId(), GetHashKey(tipo), GetHashKey(tatuagem))
                end
                atuaisTatoo[tatuagem] = tipo
                tableTatoo[tatuagem] = true
            else
                for k, v in pairs(atuaisTatoo) do
                    SetPedDecoration(PlayerPedId(), GetHashKey(v), GetHashKey(k))
                    if tableTatoo[tatuagem] ~= true then
                        SetPedDecoration(PlayerPedId(), GetHashKey(tipo), GetHashKey(tatuagem))
                    end
                    atuaisTatoo[tatuagem] = tipo
                    tableTatoo[tatuagem] = true
                end
            end
            valor = valor + Config_client['price']
            SendNUIMessage({
                    action = "setPrice",
                price = valor
            })
        end
    end
end

RegisterNUICallback("changeCustom", function(data, cb)
    refreshTattoos(data.tatu, data.type)
end)

RegisterNUICallback("cleartatoo", function(data, cb)
    ClearPedDecorations(GetPlayerPed(-1))
    valor = 0
    SendNUIMessage({
            action = "setPrice",
        price = valor
    })
    atuaisTatoo = {}
end)

function DrawText3D(x, y, z, text, scl, font)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNUICallback("trocarClasse", function(data, cb)
    parteTatu = data.part
end)

function getTats(table, parte)
    local valorDeParte = 0
    for k, v in pairs(table[parte]) do
        return v
    end
end

RegisterNUICallback("requestTatto", function(data, cb)
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        sexo = "Male"
        tableSexo = Config_client['partsM']
        tatuagens = getTats(tableSexo, parteTatu)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        sexo = "Female"
        tableSexo = Config_client['partsF']
        tatuagens = getTats(tableSexo, parteTatu)
    end
    if parteTatu == "head" then
        Camera.currentView = 'head'
        Activate(500)
    elseif parteTatu == "hair" then
        Camera.currentView = 'head'
        Activate(500)    
    elseif parteTatu == "torso" or parteTatu == "leftarm" or parteTatu == "rightarm" then
        Camera.currentView = 'body'
        Activate(500)
    elseif parteTatu == "leftleg" or parteTatu == "rightleg" then
        Camera.currentView = 'legs'
        Activate(500)
    end

    cb({
        tatuagens = tatuagens,
        parteTatu = parteTatu,
        sexo = sexo
    })
end)

RegisterNUICallback("updateRotate", function(data, cb)
    if data.tipo == "rotacao" then
        SetEntityHeading(PlayerPedId(), f(data.valor))
    elseif data.tipo == "zoom" then
        if parseInt(data.valor) == 0 then
            Camera.currentView = 'head'
            Activate(500)
        elseif parseInt(data.valor) == 1 then
            Camera.currentView = 'body'
            Activate(500)
        elseif parseInt(data.valor) == 2 then
            Camera.currentView = 'legs'
            Activate(500)
        elseif parseInt(data.valor) == 3 then
            Camera.currentView = 'corpo'
            Activate(500)
        end
    end
end)

function Deactivate()
    local playerPed = PlayerPedId()
    SetCamActive(Camera.entity, false)
    RenderScriptCams(false, true, 500, true, true)
    FreezePedCameraRotation(playerPed, false)
    Camera.active = false
end

function Activate(delay)

    SetEntityHeading(PlayerPedId(), 125.63)

    if not DoesCamExist(Camera.entity) then
        Camera.entity = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    local playerPed = PlayerPedId()
    FreezePedCameraRotation(playerPed, true)

    SetViewcamera(Camera.currentView)

    SetCamActive(Camera.entity, true)
    RenderScriptCams(true, true, 500, true, true)

    Camera.active = true
end

function CalculatePosition(adjustedAngle)
    if adjustedAngle then
        Camera.angleX = Camera.angleX - Camera.mouseX * 0.1
        Camera.angleY = Camera.angleY + Camera.mouseY * 0.1
    end

    if Camera.angleY > Camera.angleYMax then
        Camera.angleY = Camera.angleYMax
    elseif Camera.angleY < Camera.angleYMin then
        Camera.angleY = Camera.angleYMin
    end

    local radiusMax = CalculateMaxRadius()

    local offsetX = ((Cos(Camera.angleX) * Cos(Camera.angleY)) + (Cos(Camera.angleY) * Cos(Camera.angleX))) / 2 * radiusMax
    local offsetY = ((Sin(Camera.angleX) * Cos(Camera.angleY)) + (Cos(Camera.angleY) * Sin(Camera.angleX))) / 2 * radiusMax
    local offsetZ = ((Sin(Camera.angleY))) * radiusMax

    local pedCoords = GetEntityCoords(PlayerPedId())

    return vector3(pedCoords.x + offsetX, pedCoords.y + offsetY, pedCoords.z + offsetZ)
end

function CalculateMaxRadius()
    if Camera.radius < Camera.radiusMin then
        Camera.radius = Camera.radiusMin
    elseif Camera.radius > Camera.radiusMax then
        Camera.radius = Camera.radiusMax
    end

    local result = Camera.radius

    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)

    local behindX = pedCoords.x + ((Cos(Camera.angleX) * Cos(Camera.angleY)) + (Cos(Camera.angleY) * Cos(Camera.angleX))) / 2 * (Camera.radius + 0.5)
    local behindY = pedCoords.x + ((Sin(Camera.angleX) * Cos(Camera.angleY)) + (Cos(Camera.angleY) * Sin(Camera.angleX))) / 2 * (Camera.radius + 0.5)
    local behindZ = ((Sin(Camera.angleY))) * (Camera.radius + 0.5)

    local testRay = StartShapeTestRay(pedCoords.x, pedCoords.y, pedCoords.z + 0.5, behindX, behindY, behindZ, -1, playerPed, 0)
    local _, hit, hitCoords = GetShapeTestResult(testRay)
    local hitDist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z + 0.5, hitCoords)

    if hit and hitDist < Camera.radius + 0.5 then
        result = hitDist
    end

    return result
end

function SetViewcamera(view)
    local boneIndex = -1
    if view == 'head' then
        boneIndex = tonumber("31086")
        Camera.radiusMin = tonumber("0.8")
        Camera.radiusMax = tonumber("1.0")
        Camera.angleYMin = tonumber("40.0")
        Camera.angleYMax = tonumber("60.0")
        Camera.radius = Camera.radiusMin
        Camera.angleY = Camera.angleYMin
        Camera.angleX = GetEntityHeading(PlayerPedId()) + 90.0

        Camera.position = CalculatePosition(false)
        SetCamCoord(Camera.entity, Camera.position.x, Camera.position.y, Camera.position.z + 0.2)

        targetPos = GetPedBoneCoords(PlayerPedId(), boneIndex, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"))
        PointCamAtCoord(Camera.entity, targetPos.x + 0.6, targetPos.y, targetPos.z)

        Camera.currentView = view
    elseif view == 'body' then
        boneIndex = tonumber("11816")
        Camera.radiusMin = tonumber("1.0")
        Camera.radiusMax = tonumber("2.0")
        Camera.angleYMin = tonumber("0.0")
        Camera.angleYMax = tonumber("35.0")
        Camera.radius = Camera.radiusMin
        Camera.angleY = Camera.angleYMin
        Camera.angleX = GetEntityHeading(PlayerPedId()) + 90.0

        Camera.position = CalculatePosition(false)
        SetCamCoord(Camera.entity, Camera.position.x, Camera.position.y, Camera.position.z)

        targetPos = GetPedBoneCoords(PlayerPedId(), boneIndex, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"))
        PointCamAtCoord(Camera.entity, targetPos.x + 0.6, targetPos.y, targetPos.z)

        Camera.currentView = view
    elseif view == 'legs' then
        boneIndex = tonumber("35502")
        Camera.radiusMin = tonumber("1.1")
        Camera.radiusMax = tonumber("1.25")
        Camera.angleYMin = tonumber("-30.0")
        Camera.angleYMax = tonumber("20.0")
        Camera.radius = Camera.radiusMin
        Camera.angleY = Camera.angleYMin
        Camera.angleX = GetEntityHeading(PlayerPedId()) + 90.0

        Camera.position = CalculatePosition(false)
        SetCamCoord(Camera.entity, Camera.position.x, Camera.position.y, Camera.position.z)

        targetPos = GetPedBoneCoords(PlayerPedId(), boneIndex, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"))
        PointCamAtCoord(Camera.entity, targetPos.x + 1.2, targetPos.y, targetPos.z)

        Camera.currentView = view
    elseif view ==    "corpo" then
        boneIndex = tonumber("35502")
        Camera.radiusMin = tonumber("1.1")
        Camera.radiusMax = tonumber("1.25")
        Camera.angleYMin = tonumber("-30.0")
        Camera.angleYMax = tonumber("20.0")
        Camera.radius = Camera.radiusMin
        Camera.angleY = Camera.angleYMin
        Camera.angleX = GetEntityHeading(PlayerPedId()) + 90.0

        Camera.position = GetOffsetFromEntityInWorldCoords(PlayerPedId(), tonumber("0.0"), tonumber("2.0"), tonumber("0.0"))

        targetPos = GetEntityCoords(PlayerPedId())
        SetCamCoord(Camera.entity, Camera.position.x, Camera.position.y, Camera.position.z + 0.75)
        PointCamAtCoord(Camera.entity, targetPos.x, targetPos.y - 0.5, targetPos.z + 0.25)

    end

end

function f(n)
    n = n + 0.00000
    return n
end

RegisterNUICallback("payament", function(data, cb)
    if dPNserver.verifyPayment(data.price) then
        SetNuiFocus(false, false)

        SendNUIMessage({
            action = "hideMenu",
            value = 0
        })
        DoScreenFadeOut(1000)
        Wait(7200)
        DoScreenFadeIn(1000)
        dPNserver.setTatoo(atuaisTatoo)
        local ped = PlayerPedId()
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityInvincible(ped, false)
        Deactivate()

        setCustomization(old_custom)
        ClearPedTasks(PlayerPedId())
        in_loja = false
        noProvador = false
        chegou = false
        naroupas = false
        old_custom = {}

        deixarVisivel()
        deixarinvisivelplayer = false
        dPN.setTatoos()
        podemostrartexto = true
        
    valor = 0
    SendNUIMessage({
          action =    "setPrice",
      price = valor
    })
    
    SendNUIMessage({
                action =    "hideMenu",
            value = 0
        })
        TriggerServerEvent('dpn_barber:setPedClient')
    end
end)

RegisterNetEvent('ComprarTudo')
AddEventHandler('ComprarTudo', function(comprar)
    if comprar then
        in_loja = false
        SendNUIMessage({
                action =    "hideMenu",
            value = 0
        })
        deixarVisivel()
        SetNuiFocus(false, false)
        Deactivate()
        naroupas = false
        setCustomization(old_custom)
    else
        in_loja = false
        setCustomization(old_custom)
        ClearPedTasks(PlayerPedId())
        SendNUIMessage({
                action =    "hideMenu",
            value = 0
        })
        Deactivate()
        deixarVisivel()
        SetNuiFocus(false, false)
        naroupas = false

    end
end)

function dPN.mandarAtualTatu(custom)
    if custom then
        atuaisTatoo = custom
        dPN.setTatoos()
    end
end

function dPN.setTatoos()
    dPNserver.setFalse()
    if atuaisTatoo then
        ClearPedDecorations(GetPlayerPed(-1))
    if atuaisTatoo == nil or atuaisTatoo == 1 then
      atuaisTatoo = {}
    end
    
        for k, v in pairs(atuaisTatoo) do
            if tatuagensjaaplicadas[k] ~= true then
                SetPedDecoration(PlayerPedId(), GetHashKey(v), GetHashKey(k))
                tatuagensjaaplicadas[k] = true
            end
        end
        tatuagensjaaplicadas = {}
    end
end

function setCustomization(custom)
    local r = async()
    Citizen.CreateThread(function()
        if custom then
            local ped = GetPlayerPed(-1)
            for k, v in pairs(custom) do
                if k ~=    "model" and k ~=    "modelhash" then
                    local isprop, index = parse_part(k)
                    if isprop then
                        if v[1] < 0 then
                            ClearPedProp(ped, index)
                        else
                            SetPedPropIndex(ped, index, v[1], v[2], v[3] or 2)
                        end
                    else
                        SetPedComponentVariation(ped, index, v[1], v[2], v[3] or 2)
                    end
                end
            end
      Wait(100)
            TriggerServerEvent('vrp_tattoo:setPedClient')
        end
        r()
    end)
    return r:wait()
end

function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end