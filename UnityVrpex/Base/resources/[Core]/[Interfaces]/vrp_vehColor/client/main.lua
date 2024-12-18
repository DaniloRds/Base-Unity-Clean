Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")

sv = Tunnel.getInterface("vrp_vehColor")

src = {
    getVehicleMods = function(veh)
        return getVehicleMods(veh)
    end,
    setVehicleMods = function(veh)
        return setVehicleMods(veh,custom)
    end
}
Tunnel.bindInterface("vrp_vehColor", src)
Proxy.addInterface("vrp_vehColor", src)

-- variaveis/tables de rotina
custom = {}
oldCustom = {}
selectedColors = {}
vehSelected = nil
buyOut = nil
cam = nil
totalPrice = 0
colorsPrice = {}

function createBlips()
    for _, item in pairs(blips) do
        local blip = AddBlipForCoord(item.x,item.y,item.z)
        SetBlipSprite(blip,446)
        SetBlipAsShortRange(blip,true)
        SetBlipColour(blip,1)
        SetBlipScale(blip,0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Mecânica')
        EndTextCommandSetBlipName(blip)
    end
end

function init(veh)
    totalPrice = 0
    SetFollowVehicleCamViewMode(0)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
    defaultCam()
    selectedColors = {
        ['metalic'] = 1,
        ['smetalic'] = 1,
        ['matte'] = 1,
        ['smatte'] = 1,
        ['metal'] = 1,
        ['smetal'] = 1,
        ['pearlescent'] = 1,
        ['wheel'] = 1
    }
    vehSelected = veh
    _, custom = src.getVehicleMods(veh)
    oldCustom = custom
    updateColors(custom)
end

-- Citizen.CreateThread(function()
--     createBlips()
--     for _, data in pairs(markers) do
--         for _, slot in pairs(data.slots) do
--             TriggerEvent("hoverfy:insertTable",{{ slot.x, slot.y, slot.z, 1.5, "E","Iniciar Pintura","Pressione para abrir/fechar o menu" }})
--         end
--     end
-- end)

local menuIsOpen = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(),true))
        local ped = PlayerPedId()
            for _, data in pairs(markers) do
                if GetDistanceBetweenCoords(data.location.x,data.location.y,data.location.z,px,py,pz,true) <= data.location.distance then
                    while true do
                        px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(),true))
                        if IsPedInAnyVehicle(ped) then
                            for _, slot in pairs(data.slots) do
                                DrawMarker(27,slot.x, slot.y, slot.z-0.5,0,0,0,0.0,0,0,2.0,2.0,2.0, 255,255,255, 196,0,0,0,10)
                                if IsControlJustPressed(1,38) and GetDistanceBetweenCoords(slot.x,slot.y,slot.z,px,py,pz,true) <= 2 and IsPedInAnyVehicle(PlayerPedId()) and not menuIsOpen and sv.getPermission() then
                                    local ped = PlayerPedId()
                                    local vehicle = GetVehiclePedIsUsing(ped)
                                    local body = GetVehicleBodyHealth(vehicle)
                                    if body > 995 then
                                        -- print("Body",body)
                                        sv.startTotal()
                                        TriggerEvent('hudOff',true)
                                        -- TriggerEvent("hoverfy:hidden")
                                        local veh = GetVehiclePedIsUsing(PlayerPedId())
                                        if veh then
                                            local playerMoney = sv.getPlayerTotalMoney()
                                            openNui(veh, vehTypes[GetVehicleClass(veh)], playerMoney)
                                            sv.saveOldCustom(oldCustom)
                                        end
                                        SetVehicleEngineOn(vehicle, false, false, true)
                                    else
                                        TriggerEvent("Notify", "aviso", "Você precisa <b>reparar o veículo</b> para fazer a pintura.", 5000)
                                    end
                                end
                            end
                            if GetDistanceBetweenCoords(data.location.x,data.location.y,data.location.z,px,py,pz,true) > data.location.distance then
                                break
                            end
                        end
                        Citizen.Wait(5)
                    end
                end
            end
    
    end
end)