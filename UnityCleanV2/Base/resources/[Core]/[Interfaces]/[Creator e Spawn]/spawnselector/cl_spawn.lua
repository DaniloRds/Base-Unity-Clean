local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
spawnselector = Tunnel.getInterface("spawnselector")
local SpawnLocation = {}


RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu', function()
    SetTimecycleModifier('hud_def_blur')
    SendNUIMessage({action = "display"})
    SetNuiFocus(true, true)
    TriggerEvent('hudOff', true)
end)


function getTime()
    local hour = GetClockHours()
    if hour >= 6 and hour < 20 then
        return "dia"
    end
    return "noite"
end

local SPAWNS = {
    ["mirror"] = vector3(1036.73,-756.16,57.77),
    ["sandy"] = vector3(2468.67,4072.51,37.98),
    ["motel"] = vector3(-267.74,-892.29,31.22),
    ["paleto"] = vector3(-759.07,5583.87,36.71)
}

RegisterNUICallback('spawn', function(data, cb)
    local SpawnName = data.location
 
    if SpawnName == "last" then
        local coords = spawnselector.ultimaposicao()
        -- print(coords)
        SPAWNS["last"] = vector3(coords.x,coords.y,coords.z) 
    end
    SpawnLocation = SPAWNS[SpawnName]
    TriggerEvent("ToogleBackCharacter")
    CameraPos(SpawnLocation.x,SpawnLocation.y,SpawnLocation.z)
end)

RegisterNUICallback('time', function(data, cb)
    SendNUIMessage({action = getTime()})
end)

function CameraPos(x,y,z)
    local pos = {x = x, y = y, z = z}
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
    SetTimecycleModifier('default')
    SetNuiFocus(false, false)
    Citizen.Wait(500)
    local cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam2, pos.x,pos.y,pos.z+200)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
    Citizen.Wait(900)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam, pos.x,pos.y,pos.z+2)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    DoScreenFadeIn(1000)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    DisplayHud(true)
    DisplayRadar(true)
    TriggerEvent('hudOff', false)
end
