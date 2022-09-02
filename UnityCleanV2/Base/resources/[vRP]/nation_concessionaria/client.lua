local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_concessionaria")
fclient = {}
Tunnel.bindInterface("nation_concessionaria", fclient)

local timer = 0
local config = false
local inTest = false
local nearestConce = {
		close = true,
		conce = vec3(-56.49, -1096.08, 26.43), 
		test_locais = {
			{ coords = vec3(-879.56, -3223.78, 13.54), h = 60.54 },
			{ coords = vec3(-877.56, -3220.02, 13.54), h = 60.54 },
			{ coords = vec3(-875.68, -3216.68, 13.54), h = 60.54 },
			{ coords = vec3(-873.9, -3213.27, 13.54), h = 60.54 },
		}
	
}

DoScreenFadeIn(1000)

RegisterNetEvent("nationConce:setConfig")
AddEventHandler(
	"nationConce:setConfig",
	function(cfg)
        config = cfg
    end
)

Citizen.CreateThread(
	function()
		SetNuiFocus(false,false)

        while not config do
            TriggerServerEvent("nationConce:getConfig")
            Citizen.Wait(1000)
        end
    end
)

--- THREAD PARA ENCONTRAR A CONCESSIONÁRIA MAIS PRÓXIMA ---

Citizen.CreateThread(
    function()
        --[[ TriggerScreenblurFadeOut(500)
    DoScreenFadeIn(1000)
    SetNuiFocus(false) ]]
        -- config = func.getConfig()
        while true do
            if not nui and not inTest and timer == 0 and config then
                local playercoords = GetEntityCoords(PlayerPedId())
                if nearestConce and nearestConce.conce then
					local distance = #(playercoords - nearestConce.conce)
                else
                    for k, v in ipairs(config.locais) do
                        local distance = #(playercoords - v.conce)
                        if distance < 15 then
                            earestConce = config.locais[k]
                        end
                    end
                end
            end
            Citizen.Wait(500)
        end
    end
)

--- THREAD PARA DESENHAR OS MARKERS (CONCE MAIS PRÓXIMA) E ABRIR A NUI CASO O PLAYER PRESSIONE \"E\" ---

Citizen.CreateThread(
    function()
        while true do
			local idle = 500
            if not nui and not inTest and timer == 0 and nearestConce and nearestConce.conce then
                local coords = nearestConce.conce
                local playercoords = GetEntityCoords(PlayerPedId())
				local distance = #(playercoords - coords)
                idle = 5

                if distance <= 5 then
                    if conceMarker then
                        conceMarker(coords)
                    else
                        DrawMarker(36, coords, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 153, 102, 255, 155, 1, 1, 1, 1)
                        DrawMarker(
                            28,
                            coords.x,
                            coords.y,
                            coords.z - 0.97,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1.0,
                            1.0,
                            0.5,
                            102,
                            0,
                            255,
                            155,
                            0,
                            0,
                            0,
                            1
                        )
				    end
                end
				
                if conceText and distance <= 1 then
                    conceText()
				end

                if IsControlJustPressed(0, 38) and distance <= 3 then
                    toggleNui()
                end
            end
            Citizen.Wait(idle)
        end
    end
)

function checkNui(coords)
    Citizen.CreateThread(
        function()
            while nui do
                local playercoords = GetEntityCoords(PlayerPedId())
                local distance = #(playercoords - coords)
                if distance > 1.5 then
                    closeConce()
                end
                Citizen.Wait(1000)
            end
        end
    )
end

function notify(mode, message, time)
    if showNotify then
        showNotify(mode, message, time)
    else
        TriggerEvent("Notify", mode, message, time)
    end
end

--- INICIA O TEST DRIVE

function testDrive(model,price)
    if not nearestConce then return end
        local mhash = loadModel(model)
        closeConce()
        if mhash then
			local count = 0
            for _,spawn in ipairs(nearestConce.test_locais) do
            local spawnCoords = spawn.coords
            local closestVehicleOnSpot = GetClosestVehicle(spawnCoords.x,spawnCoords.y,spawnCoords.z,3.001,0,71)
                if DoesEntityExist(closestVehicleOnSpot) then
                    count = count + 1
                    if count >= #nearestConce.test_locais then
                        notify('negado', 'Todas as vagas estão ocupadas no momento.', 3000)
                        func.chargeBack(price)
                        return
                    end
                else
                    Citizen.CreateThread(function()
                    inTest = true
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    local myCoords = GetEntityCoords(PlayerPedId())
                    SetEntityCoords(PlayerPedId(), spawnCoords)
                    local plate = vRP.getRegistrationNumber()
                    local veh = createVehicle(mhash,spawnCoords,plate)
                    SetEntityHeading(veh, spawn.h)
                    SetPedIntoVehicle(PlayerPedId(), veh, -1)
                    SetVehicleDoorsLocked(veh,4)
                    DoScreenFadeIn(1000)
                    SendNUIMessage({ action = "showTimer", time = config.tempo_testdrive })
                    notify("importante", "Test Drive iniciado. Não saia do veículo e nem vá para muito longe do local.",3000)
                    while inTest and IsPedInAnyVehicle(PlayerPedId(),false) and #(GetEntityCoords(PlayerPedId()) - spawnCoords) < config.maxDistance and GetPedInVehicleSeat(veh,-1) == PlayerPedId() do
                       Citizen.Wait(500)
                    end
                    if inTest then
                        inTest = false
                        notify("aviso", "Test Drive cancelado.",3000)
                        if #(GetEntityCoords(PlayerPedId()) - spawnCoords) >= config.maxDistance then
                            notify("aviso", "Você se afastou muito do local do test.",3000)
                        end
                        SendNUIMessage({ action = "stopTimer" })
                    else
                        notify("importante", "Test Drive finalizado com sucesso.",3000)
                    end
                        DoScreenFadeOut(1000)
                        Wait(1000)
                        SetEntityAsNoLongerNeeded(veh)
                        SetEntityAsMissionEntity(veh,true,true)
                        DeleteVehicle(veh)
                        SetEntityCoords(PlayerPedId(), myCoords)
                        Wait(1000)
                        DoScreenFadeIn(1000)
                        if GetEntityHealth(PlayerPedId()) < 102 then
                            vRP.killGod()
                            vRP.setHealth(150)
                        end
                    end)
                return
            end
        end 
    else
        notify("aviso","Veículo indisponível para test drive.",3000)
        func.chargeBack(price)
    end
end


--- CRIA O VEÍCULO DO TEST DRIVE

function createVehicle(mhash, spawnCoords, plate)
    local vehicle = CreateVehicle(mhash, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    if plate then
        SetVehicleNumberPlateText(vehicle, plate)
    end
    if DoesEntityExist(vehicle) then
        local netveh = VehToNet(vehicle)
        NetworkRegisterEntityAsNetworked(vehicle)
        while not NetworkGetEntityIsNetworked(vehicle) do
            NetworkRegisterEntityAsNetworked(vehicle)
            Citizen.Wait(1)
        end
        if NetworkDoesNetworkIdExist(netveh) then
            SetEntitySomething(vehicle, true)
            if NetworkGetEntityIsNetworked(vehicle) then
                SetNetworkIdExistsOnAllMachines(netveh, true)
            end
        end
        SetVehicleIsStolen(vehicle, false)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetEntityInvincible(vehicle, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehRadioStation(vehicle, "OFF")
        SetModelAsNoLongerNeeded(mhash)
    end
    return vehicle
end

-- CARREGAR O MODEL DO VEÍCULO --
function loadModel(model)
    local mhash = GetHashKey(model)
    local timeout = 5000
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        timeout = timeout - 1
        if timeout <= 0 then
            return false
        end
        Citizen.Wait(1)
    end
    return mhash
end

--- PEGA AS MODIFICAÇÕES DO VEÍCULO PARA SALVAR NO BANCO DE DADOS

function fclient.getVehicleMods(vehicle)
    if func.checkAuth() then
        local myveh = {}
        local mhash = loadModel(vehicle)
        local coords = GetEntityCoords(PlayerPedId())
        if mhash then
            local veh = CreateVehicle(mhash, coords.x, coords.y, coords.z - 10, 0.0, false, false)
            if DoesEntityExist(veh) then
                myveh = getVehicleMods(veh)
                SetEntityAsNoLongerNeeded(veh)
                SetEntityAsMissionEntity(veh, true, true)
                DeleteVehicle(veh)
            end
        end
        return myveh
    end
end

--- RETORNA A CLASSE DE UM VEÍCULO PELO ÍNDICE ---

function getVehicleClass(class)
    return config.vehicleClasses[class] or "none"
end

--- RETORNA A LISTA DE VEÍCULOS DA CONCE

function getConceVehicleList()
    if func.checkAuth() then
        local vehicles = func.getConceVehicles()
        local discount = func.getDiscount() / 100
        if vehicles and #vehicles > 0 then
            for i in ipairs(vehicles) do
                if not vehicles[i].class then
                    local class = GetVehicleClassFromName(vehicles[i].vehicle)
                    vehicles[i].class = getVehicleClass(class)
                end
                vehicles[i].price = vehicles[i].price - (vehicles[i].price * discount)
            end
        end
        return vehicles or {}
    end
end


--- RETORNA A LISTA DE VEÍCULOS EM DESTAQUE DA CONCE

function getTopVehicleList()
    if func.checkAuth() then
        local vehicles = func.getTopVehicles()
        local discount = func.getDiscount() / 100
        if vehicles and #vehicles > 0 then
            for i in ipairs(vehicles) do
                if not vehicles[i].class then
                    local class = GetVehicleClassFromName(vehicles[i].vehicle)
                    vehicles[i].class = getVehicleClass(class)
                end
                vehicles[i].price = vehicles[i].price - (vehicles[i].price * discount)
            end
        end
        return vehicles or {}
    end
end

--- RETORNA A LISTA DOS VEÍCULOS DO PLAYER

function getMyVehicles(force)
    if func.checkAuth() then
        local myVehicles = func.getMyVehicles(force)
        if myVehicles and #myVehicles > 0 then
            for i in ipairs(myVehicles) do
                if not myVehicles[i].class then
                    local class = GetVehicleClassFromName(myVehicles[i].vehicle)
                    myVehicles[i].class = getVehicleClass(class)
                end
            end
        end
        return myVehicles
    end
end

--- TOGGLE DA NUI ---
function toggleNui()
    nui = not nui
    if nui then
        openConce()
    else
        closeConce()
    end
end


--- ABRIR CONCE ---
function openConce()
    if func.checkAuth() then
        TriggerScreenblurFadeIn(500)
	    SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = "show",
                config = config,
                vehList = getConceVehicleList(),
                topVehicles = getTopVehicleList(),
                myVehicles = getMyVehicles(true)
            }
        )
        nui = true
        checkNui(GetEntityCoords(PlayerPedId()))
    end
end



--- ABRIR MENU DE GERENCIAMENTO DA CONCE
function fclient.showAdminMenu()
    if func.checkAuth() then
        if not nui then
            nui = true
            checkNui(GetEntityCoords(PlayerPedId()))
            TriggerScreenblurFadeIn(500)
            SetNuiFocus(true, true)
            SendNUIMessage(
                {
                    action = "showAdmin"
                }
            )
        end
    end
end



--- FECHAR A NUI ---
function closeConce()
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false)
    SendNUIMessage({action = "hide"})
    nui = false
end

--- PEGAR A COR DO VEÍCULO

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, parseInt(match));
    end
    return result;
end

function getColor(color)
    return split(color,",")
end

---


-- FECHAR --
RegisterNUICallback(
    "close",
    function(data)
        closeConce()
        SendNUIMessage({action = "hideAdmin"})
    end
)


RegisterNUICallback(
    "buy-vehicle",
    function(data, cb)
        if func.checkAuth() then
            if data and timer == 0 then
                startTimer(3)
                local vehicle, color = data.vehicle, getColor(data.color)
                local state, message = func.buyVehicle(vehicle, color)
                cb({state, message})
                return
            end
        end
    end
)



RegisterNUICallback(
    "sell-vehicle",
    function(data, cb)
        if func.checkAuth() then
            if data and timer == 0 then
                startTimer(3)
                local vehicle = data.vehicle
                local state, message = func.sellVehicle(vehicle)
                cb({state, message})
                return
            end
        end
    end
)

RegisterNUICallback("updateVehicles", function(data, cb)
    cb({ vehList = getConceVehicleList(), topVehicles = getTopVehicleList(), myVehicles = getMyVehicles() })
end)

RegisterNUICallback(
    "try-test",
    function(data, cb)
        if data and timer == 0 then
            startTimer(7)
            local state, message = func.testDrive(data.vehicle)
            cb({state = state, message = message})
        end
    end
)


RegisterNUICallback(
    "pay-test",
    function(data, cb)
        if data then
            local state, message, price = func.payTest(data.vehicle)
            cb({state, message, price})
        end
    end
)


RegisterNUICallback(
    "test-drive",
    function(data)
        if data then
            testDrive(data.vehicle, data.price)
        end
    end
)

RegisterNUICallback(
    "end-test",
    function(data)
        inTest = false
    end
)
RegisterNUICallback(
    "try-rent",
    function(data, cb)
        if data and timer == 0 then
            startTimer(3)
            local state, message = func.rentVehicle(data.vehicle)
            cb({state = state, message = message})
        end
    end
)

RegisterNUICallback(
    "pay-rent",
    function(data, cb)
        if data then
            local state, message = func.payRent(data.vehicle)
            cb({state, message})
        end
    end
)

RegisterNUICallback(
    "manageConce",
    function(data)
        if data and timer == 0 then
            startTimer(3)
            func.manageConce(data.mode, data.vehicle, data.qtd)
        end
    end
)

--- COOLDOWN

function startTimer(time)
    Citizen.CreateThread(
        function()
            timer = time
            while timer > 0 do
                Citizen.Wait(1000)
                timer = timer - 1
            end
        end
    )
end
