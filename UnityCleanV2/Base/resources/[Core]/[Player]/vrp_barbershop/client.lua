local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP") 

kPT = {}
Tunnel.bindInterface("vrp_barbershop",kPT)
Proxy.addInterface("vrp_barbershop",kPT)
kPTserver = Tunnel.getInterface("vrp_barbershop")
acabou = true
primeiro = true

local currentCharacterMode = { 
    fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0,
    noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0,
    cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0,
    chinWidth = 0,chinShape = 0, neckWidth = 0, hairModel = 7, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0,
    eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, 
    lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, 
    frecklesModel = -1, makeupModel = -1 }

function kPT.setCharacter(data)
if data then
        custom = data
        for i=3,1,-1 do
            TaskUpdateHeadOptions()
            TaskUpdateSkinOptions()
            TaskUpdateFaceOptions()
        end
    end
end

function TaskUpdateSkinOptions()
    local data = custom
    if data.shapeMix == 1 then
        data.shapeMix = 1.0 
    else 
        data.shapeMix = data.shapeMix
    end
    currentCharacterMode.fathersID = data.fathersID
    currentCharacterMode.mothersID = data.mothersID
    currentCharacterMode.skinColor = data.skinColor
    currentCharacterMode.shapeMix = data.shapeMix

    SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,data.shapeMix,0,0,false)
end

function TaskUpdateFaceOptions()
local ped = PlayerPedId()
    local data = custom
    currentCharacterMode.eyesColor = data.eyesColor
    currentCharacterMode.eyebrowsHeight = data.eyebrowsHeight
    currentCharacterMode.eyebrowsWidth = data.eyebrowsWidth
    currentCharacterMode.noseWidth = data.noseWidth
    currentCharacterMode.noseHeight = data.noseHeight
    currentCharacterMode.noseLength = data.noseLength
    currentCharacterMode.noseBridge = data.noseBridge
    currentCharacterMode.noseTip = data.noseTip
    currentCharacterMode.noseShift = data.noseShift
    currentCharacterMode.cheekboneHeight = data.cheekboneHeight
    currentCharacterMode.cheekboneWidth = data.cheekboneWidth
    currentCharacterMode.cheeksWidth = data.cheeksWidth
    currentCharacterMode.lips = data.lips
    currentCharacterMode.jawWidth = data.jawWidth
    currentCharacterMode.jawHeight = data.jawHeight
    currentCharacterMode.chinLength = data.chinLength
    currentCharacterMode.chinPosition = data.chinPosition
    currentCharacterMode.chinWidth = data.chinWidth
    currentCharacterMode.chinShape = data.chinShape
    currentCharacterMode.neckWidth = data.neckWidth

    -- Olhos
    SetPedEyeColor(ped,data.eyesColor)
    -- Sobrancelha
    SetPedFaceFeature(ped,6,data.eyebrowsHeight)
    SetPedFaceFeature(ped,7,data.eyebrowsWidth)
    -- Nariz
    SetPedFaceFeature(ped,0,data.noseWidth)
    SetPedFaceFeature(ped,1,data.noseHeight)
    SetPedFaceFeature(ped,2,data.noseLength)
    SetPedFaceFeature(ped,3,data.noseBridge)
    SetPedFaceFeature(ped,4,data.noseTip)
    SetPedFaceFeature(ped,5,data.noseShift)
    -- Bochechas
    SetPedFaceFeature(ped,8,data.cheekboneHeight)
    SetPedFaceFeature(ped,9,data.cheekboneWidth)
    SetPedFaceFeature(ped,10,data.cheeksWidth)
    -- Boca/Mandibula
    SetPedFaceFeature(ped,12,data.lips)
    SetPedFaceFeature(ped,13,data.jawWidth)
    SetPedFaceFeature(ped,14,data.jawHeight)
    -- Queixo
    SetPedFaceFeature(ped,15,data.chinLength)
    SetPedFaceFeature(ped,16,data.chinPosition)
    SetPedFaceFeature(ped,17,data.chinWidth)
    SetPedFaceFeature(ped,18,data.chinShape)
    -- Pescoço
    SetPedFaceFeature(ped,19,data.neckWidth)
end

function TaskUpdateHeadOptions()
    local ped = PlayerPedId()
    local data = custom
    -- Cabelo
    SetPedComponentVariation(ped,2,data.hairModel,0,0)
    SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

    -- Sobrancelha 
    SetPedHeadOverlay(ped,2,data.eyebrowsModel,0.99)
    SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

    -- Barba
    SetPedHeadOverlay(ped,1,data.beardModel,0.99)
    SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

    -- Pelo Corporal
    SetPedHeadOverlay(ped,10,data.chestModel,0.99)
    SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

    -- Blush
    SetPedHeadOverlay(ped,5,data.blushModel,0.99)
    SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

    -- Battom
        SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
    SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)

    -- Manchas
    SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
    SetPedHeadOverlayColor(ped,0,0,0,0)

    -- Envelhecimento
    SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
    SetPedHeadOverlayColor(ped,3,0,0,0)

    -- Aspecto
    SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
    SetPedHeadOverlayColor(ped,6,0,0,0)

    -- Pele
    SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
    SetPedHeadOverlayColor(ped,7,0,0,0)

    -- Sardas
    SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
    SetPedHeadOverlayColor(ped,9,0,0,0)

    -- Maquiagem
    SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
    SetPedHeadOverlayColor(ped,4,0,0,0)
end

function kPT.getCharacter()
    if primeiro == true then
        return custom
    elseif primeiro == false then
        return currentCharacterMode
    end
end

function kPT.open()
    for k,v in pairs(Config['locs']) do
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v['x'],v['y'],v['z'],true)
        if distance <= Config['distance'] then
            cadeiras = v['cadeiras']
            SetNuiFocus(true, true)
            SendNUIMessage({ action = "showMenu" })
         end
    end
end

-- Cria hoverfy
Citizen.CreateThread(function()
    for k,v in pairs(Config['locs']) do
        TriggerEvent("hoverfy:insertTable",{{ v.x,v.y,v.z, 1.5, "E","Barbearia","Pressione para abrir/fechar o menu" }})
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        for k,v in pairs(Config['locs']) do
            local ped = PlayerPedId()
            local pCDS = GetEntityCoords(ped)
            local bCDS = vector3(v.x,v.y,v.z)
            local Dist = #(pCDS - bCDS)
            if Dist < 3 then
                sleep = 4
                if Dist < 2 then
                    if IsControlJustPressed(0, 38) then
                        kPTserver.openBarber(source)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function sentar()
     local ped = PlayerPedId()
     SetEntityHeading(ped,cadeiras[cadeira][4])
     SetEntityCoordsNoOffset(ped,cadeiras[cadeira][1],cadeiras[cadeira][2],cadeiras[cadeira][3],0,0,1)
     vRP._playAnim(false,{{"timetable@reunited@ig_10","base_amanda"}},true)
end

RegisterNUICallback("chair",function(data,cb)
    cadeira = data.chair
    sentar()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("barberClose",function(data)
    local ped = PlayerPedId()
    SetNuiFocus(false,false)
    SendNUIMessage({ action = "hideMenu" })
    DeleteCam()
    kPTserver.Save()
    TriggerEvent('cancelando',false)
    ClearPedTasks(ped)

end)

function DeleteCam()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 0, true, true)
    cam = nil
end

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    FreezePedCameraRotation(ped, false)
    SetNuiFocus(false,false)
end)

RegisterNUICallback("UpdateInformation",function(data,cb)
    currentCharacterMode.hairModel = data.hairModel
    currentCharacterMode.firstHairColor = data.firstHairColor
    currentCharacterMode.secondHairColor = data.secondHairColor
    currentCharacterMode.beardModel = data.beardModel
    currentCharacterMode.beardColor = data.beardColor
    currentCharacterMode.eyebrowsModel = data.eyebrowsModel
    currentCharacterMode.blushColor = data.blushColor
    currentCharacterMode.blushModel = data.blushModel
    currentCharacterMode.makeupModel = data.makeupModel
    currentCharacterMode.lipstickModel = data.lipstickModel
    currentCharacterMode.lipstickColor = data.lipstickColor
    currentCharacterMode.ageingModel = data.ageingModel
    currentCharacterMode.blemishesModel = data.blemishesModel
    currentCharacterMode.sundamageModel = data.sundamageModel
    currentCharacterMode.frecklesModel = data.frecklesModel
    currentCharacterMode.eyebrowsColor = data.eyebrowsColor
    currentCharacterMode.chestModel = data.chestModel
    currentCharacterMode.chestColor = data.chestColor
    currentCharacterMode.complexionModel = data.complexionModel
    TaskUpdate()
end)

function TaskUpdate()
local ped = PlayerPedId()
    local data = currentCharacterMode
    if data.hairModel == nil then
        data.hairModel = custom.hairModel
    end

    if data.firstHairColor == nil then
        data.firstHairColor = custom.firstHairColor
    end

    if data.secondHairColor == nil then
        data.secondHairColor = custom.secondHairColor
    end

    if data.beardModel == nil then
        data.beardModel = custom.beardModel
    end

    if data.beardColor == nil then
        data.beardColor = custom.beardColor
    end
    
    if data.eyebrowsColor == nil then
        data.eyebrowsColor = custom.eyebrowsColor
    end

    if data.blushModel == nil then
        data.blushModel = custom.blushModel
    end

    if data.blushColor == nil then
        data.blushColor = custom.blushColor
    end

    if data.makeupModel == nil then
        data.makeupModel = custom.makeupModel
    end

    if data.lipstickModel == nil then
        data.lipstickModel = custom.lipstickModel
    end

    if data.lipstickColor == nil then
        data.lipstickColor = custom.lipstickColor
    end

    if data.ageingModel == nil then
        data.ageingModel = custom.ageingModel
    end

    if data.blemishesModel == nil then
        data.blemishesModel = custom.blemishesModel
    end

    if data.sundamageModel == nil then
        data.sundamageModel = custom.sundamageModel
    end

    if data.frecklesModel == nil then
        data.frecklesModel = custom.frecklesModel
    end

    if data.frecklesModel == nil then
        data.frecklesModel = custom.frecklesModel
    end

    if data.chestModel == nil then
        data.chestModel = custom.chestModel
    end

    if data.chestColor == nil then
        data.chestColor = custom.chestColor
    end

    SetPedComponentVariation(ped,2,data.hairModel,0,0)--Tipo do cabelo
    SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)--Cor primaria e secundaria do cabelo

    SetPedHeadOverlay(ped,1,data.beardModel,0.99)--Bigode
    SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)--Cor do bigode



    SetPedHeadOverlay(ped,2,data.eyebrowsModel,0.99)
    SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)


    SetPedHeadOverlay(ped,5,data.blushModel,0.99)--Blush
    SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)--Cor do blush


    SetPedHeadOverlay(ped,4,data.makeupModel,0.99)--Maquiagem
    SetPedHeadOverlayColor(ped,4,0,0,0)


    SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)--Batom
    SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor) --COr do batom


    SetPedHeadOverlay(ped,3,data.ageingModel,0.99)--Envelhecimento
    SetPedHeadOverlayColor(ped,3,0,0,0)
    
    SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)--Sardas
    SetPedHeadOverlayColor(ped,0,0,0,0)
    

    SetPedHeadOverlay(ped,6,data.sundamageModel,0.99)--Manchas
    SetPedHeadOverlayColor(ped,6,0,0,0)
    

    SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)--Sardas
    SetPedHeadOverlayColor(ped,9,0,0,0)

    
    SetPedHeadOverlay(ped,10,data.chestModel,0.99)-- Pelo Corporal
    SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)
    primeiro = false

end

function setCamFace()
    local ped = PlayerPedId()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetPedBoneCoords(ped, 31086)
        SetCamCoord(cam, camPos.x, camPos.y+0.5, camPos.z+0.1)
        PointCamAtCoord(cam, pos.x, pos.y-2, pos.z+0.3)
    end
end


function SetCamRight()
    local ped = PlayerPedId()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetPedBoneCoords(ped, 31086)
        SetCamCoord(cam, camPos.x-0.4, camPos.y+0.3, camPos.z+0.1)
        PointCamAtCoord(cam, pos.x+1.4, pos.y-2, pos.z+0.3)
    end
end

function SetCamLeft()
    local ped = PlayerPedId()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetPedBoneCoords(ped, 31086)
        SetCamCoord(cam, camPos.x+0.6, camPos.y-0.2, camPos.z+0.1)
        PointCamAtCoord(cam, pos.x-3, pos.y+1, pos.z+0.3)
    end
end

RegisterNUICallback("handing",function(data,cb)
    local camera = data.state
    ligado = ligado
    if camera == "left" and ligado ~= "left" then
        ligado = "left"
        SetCamLeft()
    elseif camera == "right" and ligado ~= "right" then 
        ligado = "right"
        SetCamRight()
    elseif camera == "face" and ligado ~= "face" then
        ligado = "face" 
        setCamFace()
    end
end)

RegisterCommand('barber',function()
    kPTserver.openBarber(source)
end)


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