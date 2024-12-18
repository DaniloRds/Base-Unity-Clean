-- [ VRP ] -----------------------------------------------------------------
local Proxy = module('vrp', 'lib/Proxy')
local Tunnel = module('vrp', 'lib/Tunnel')

hvSERVER = Tunnel.getInterface('vrp_identity')
vRP = Proxy.getInterface('vRP')

hvCLIENT = {}
Tunnel.bindInterface('vrp_identity', hvCLIENT)

-- [ VARIABLES ] -----------------------------------------------------------
local showNui = false
local myID = true

-- [ OPEN MY ID ] ----------------------------------------------------------
RegisterCommand(config['myID']['command'], function()
    if GetEntityHealth(PlayerPedId()) <= 101 then
        return
    end
    if showNui then
        SetNuiFocus(false, false)
        SetCursorLocation(0.5, 0.5)
        SendNUIMessage({
            action = 'hide'
        })
        vRP._DeletarObjeto()
    else
        if hvSERVER.verifyItem() then
            myID = true
            vRP._CarregarObjeto("amb@world_human_clipboard@male@base", "base", "p_ld_id_card_01", 49, 60309)
            Wait(100)
            SetNuiFocus(true, true)
            -- SetNuiFocusKeepInput(true)
            SetCursorLocation(0.9, 0.9)
            SendNUIMessage({
                action = 'show',
                myID = true
            })
            disableFire()
        end
    end
    showNui = not showNui
end)

RegisterKeyMapping(config['myID']['command'], 'vrp_identity', 'keyboard', 'F11')

-- [ OPEN MY OTHER ] ----------------------------------------------------------
RegisterCommand(config['otherID']['command'], function()
    if GetEntityHealth(PlayerPedId()) <= 101 then
        return
    end
    if showNui then
        SetNuiFocus(false, false)
        SetCursorLocation(0.5, 0.5)
        SendNUIMessage({
            action = 'hide'
        })
        vRP._DeletarObjeto()
    else
        local perm = hvSERVER.checkPermission()
        if perm then
            myID = false
            vRP._CarregarObjeto("amb@world_human_clipboard@male@base", "base", "p_ld_id_card_01", 49, 60309)
            Wait(100)
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SetCursorLocation(0.9, 0.9)
            SendNUIMessage({
                action = 'show',
                myID = false
            })
            disableFire()
        end
    end
    showNui = not showNui
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLE FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
disableFire = function()
    CreateThread(function()
        local ped = PlayerPedId()
        while showNui do
            DisableControlAction(ped, 24, false)
            DisableControlAction(ped, 200, false)
            Wait(4)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('closeNui', function()
    showNui = false
    SetNuiFocus(false, false)
    SetCursorLocation(0.5, 0.5)
    SendNUIMessage({
        action = 'hide'
    })
    vRP._DeletarObjeto()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST INFOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('getPlayerInfos', function(data, cb)
    local resp, type = false, false
    if myID then
        resp, type = hvSERVER.checkInfos()
    else
        resp, type = hvSERVER.checkPeopleInfos()
    end
    if resp then
        -- print(resp[1])
        cb({
            resp = resp,
            type = type
        })
    else
        showNui = false
        SetNuiFocus(false, false)
        SetCursorLocation(0.5, 0.5)
        SendNUIMessage({
            action = 'hide'
        })
        vRP._DeletarObjeto()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUIRE SING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('requireSign', function(data, cb)
    local resp = hvSERVER.checkPerm()
    if resp then
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(false)
        SetCursorLocation(0.9, 0.9)
    end
    cb(resp)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL SING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('cancelSign', function(data, cb)
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SetCursorLocation(0.9, 0.9)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE SING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('saveSign', function(data, cb)
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SetCursorLocation(0.9, 0.9)
    local resp = hvSERVER.saveSign(data['index'])
    if resp then
        cb(resp)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST PLAYER PHOTO
-----------------------------------------------------------------------------------------------------------------------------------------
local function drawText2D(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end

local function CellFrontCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

function hvCLIENT.requestPhoto(webhookUrl, frontCam)
    local p = promise.new()
    CreateMobilePhone(10)
    CellCamActivate(true, true)
    CellFrontCamActivate(frontCam)
    while true do
        drawText2D('[PRESSIONE  ~b~E~w~  PARA  TIRAR   FOTO]', 4, 0.92, 0.5, 0.50, 255, 255, 255, 180)
        drawText2D('[OU  PRESSIONE  ~g~R~w~  PARA  CANCELAR]', 4, 0.92, 0.53, 0.42, 186, 186, 186, 180)
        if IsControlJustPressed(0, 38) then
            exports['screenshot-basic']:requestScreenshotUpload(webhookUrl, 'files[]', function(data)
                local resp = json.decode(data)
                p:resolve(resp)
            end)
            Wait(1000)
            DestroyMobilePhone()
            updatePhoto()
            break
        end
        if IsControlJustPressed(0, 45) then
            DestroyMobilePhone()
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SetCursorLocation(0.9, 0.9)
            vRP._CarregarObjeto('amb@world_human_stand_mobile@female@text@enter', 'enter', 'p_ld_id_card_01', 50, 28422)
            return
        end
        Wait(4)
    end
    return Citizen.Await(p)
end

function updatePhoto()
    disableFire()
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SetCursorLocation(0.9, 0.9)
    vRP._CarregarObjeto('amb@world_human_stand_mobile@female@text@enter', 'enter', 'p_ld_id_card_01', 50, 28422)
    showNui = true
    Wait(400)
    SendNUIMessage({
        action = 'updatePhoto'
    })
end

RegisterNUICallback('takePhoto', function()
    Wait(1000)
    local resp = hvSERVER.takePhoto()
    Wait(800)
    showNui = true
    disableFire()
    SendNUIMessage({
        action = 'show',
        myID = true
    })
end)
