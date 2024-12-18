--[ vRP ]----------------------------------------------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]---------------------------------------------------------------------------------------

misc = Tunnel.getInterface("unity_dispatch")

--[ VARIABLES ]----------------------------------------------------------------------------------------

local waterCoolers = {
    {'prop_watercooler'}
}

--[ THREADS ]------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped, 0)
        local coolerEmpty = false

        for k,v in pairs(waterCoolers) do
            local cooler = GetClosestObjectOfType(pedCoords["x"], pedCoords["y"], pedCoords["z"], 1.0, GetHashKey(v[1]), true, true, true)
            SetEntityAsMissionEntity(cooler, true, true)
            if DoesEntityExist(cooler) then
                coolerCoords = GetEntityCoords(cooler, 0)
            end
        end

        if coolerCoords ~= nil then
            local distance = GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], coolerCoords["x"], coolerCoords["y"], coolerCoords["z"])
            if distance < 1.5 then
                idle = 5   
            end
            if distance > 2 then
                coolerCoords = nil
            end
        end

        if coolerCoords ~= nil then
            if GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], coolerCoords["x"], coolerCoords["y"], coolerCoords["z"] < 1) and not IsPedInAnyVehicle(ped) then
                --DrawText3D(cfg.cds[bancos][1],cfg.cds[bancos][2],cfg.cds[bancos][3], "~b~[Banco]\n~w~Pressione ~b~[E]~w~ para acessar")
                DrawText3D(coolerCoords["x"], coolerCoords["y"], coolerCoords["z"]+1.2, "Pressione [~b~E~w~] Para ~b~ENCHER SUA GARRAFA D'ÁGUA~w~.")
                
                if GetDistanceBetweenCoords(pedCoords["x"], pedCoords["y"], pedCoords["z"], coolerCoords["x"], coolerCoords["y"], coolerCoords["z"] < 0.5) then
                    if IsControlPressed(1,38) then
                        if misc.searchCooler(coolerCoords["x"]) then
                            misc.coolerPayment()
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end 
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215) --0,0,255
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end