local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
player_tunnel = Tunnel.getInterface("unity_core")
-----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING - STATUS DO VEÍCULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","importante","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",15000)
	end
end)
-- EVENTO
RegisterNetEvent('player:statusVehicle')
AddEventHandler('player:statusVehicle', function(cor) 
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","importante","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",15000)
	end
end)  
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		TriggerServerEvent('salario:pagamento')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COR NA ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor) 
    local tinta = tonumber(cor)
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
    if tinta >= 0 then
        SetPedWeaponTintIndex(ped,arma,tinta)
    end
end)  

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh,-1) then
				TriggerServerEvent("TryDoorsEveryone",veh,2,GetVehicleNumberPlateText(veh))
			end
		end
	end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if energetico then
			wait = 1
			RestorePlayerStamina(PlayerId(),1.0)
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,29,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,169,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)			
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /bvida 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida', function(source, args, rawCommand)
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels","grab", 3)  then
        if not IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till","loop", 3) then
            if not IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@back@idle_a","idle_a", 3) then
				if not IsEntityPlayingAnim(ped, "amb@prop_human_parking_meter@female@idle_a","idle_a_female", 3) then
                TriggerServerEvent('bvida')
				end
            end
        end
    end
end)

RegisterNetEvent("player:bvida")
AddEventHandler("player:bvida", function()
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels","grab", 3)  then
        if not IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till","loop", 3) then
            if not IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@back@idle_a","idle_a", 3) then
				if not IsEntityPlayingAnim(ped, "amb@prop_human_parking_meter@female@idle_a","idle_a_female", 3) then
                TriggerServerEvent('bvida')
				end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seat")
AddEventHandler("player:seat",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)

RegisterCommand("seat", function(source, args, raw) --change command here
    TriggerEvent("player:seat",args[1])
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mala",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capo",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehNet,Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "1" then
				RollUpWindow(Vehicle,0)
				RollUpWindow(Vehicle,1)
				RollUpWindow(Vehicle,2)
				RollUpWindow(Vehicle,3)
			else
				RollDownWindow(Vehicle,0)
				RollDownWindow(Vehicle,1)
				RollDownWindow(Vehicle,2)
				RollDownWindow(Vehicle,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == 5 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Dados
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roll',function(source,args)
	rolls = 1
	if args[1] ~= nil and tonumber(args[1]) then
		rolls = tonumber(args[1])
	end

	local die = 6
	if args[2] ~= nil and tonumber(args[2]) then
		die = tonumber(args[2])
	end

	local number = 0
	local text = "Resultado: "
	for i = rolls,1,-1 do
		number = number + math.random(1,die)
		text = ""..text.." ~g~"..number.." ~w~/ ~g~"..die..""
	end

	vRP._playAnim(true,{{"anim@mp_player_intcelebrationmale@wank","wank"}},false)
	Citizen.Wait(1500)
	TriggerServerEvent('ChatRoll',text)
	ClearPedTasks(PlayerId())
end)

local DisplayRoll = false
RegisterNetEvent('DisplayRoll')
AddEventHandler('DisplayRoll',function(text,source)
	local DisplayRoll = true
	local id = GetPlayerFromServerId(source)
    Citizen.CreateThread(function()
        while DisplayRoll do
            Wait(1)
            local coordsMe = GetEntityCoords(GetPlayerPed(id),false)
			local coords = GetEntityCoords(PlayerPedId(),false)
            local distance = Vdist2(coordsMe,coords)
            if distance <= 30 then
                DrawText3Ds(coordsMe['x'],coordsMe['y'],coordsMe['z']+0.10,text)
            end
        end
    end)
    Wait(7000)
    DisplayRoll = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ /ME ] ------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('me', function(source, args, rawCommand)
    local text = '' .. rawCommand:sub(4) .. ''
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 then
        TriggerServerEvent('ChatMe', text)
    end
end)

local DisplayMe = false
RegisterNetEvent('DisplayMe')
AddEventHandler('DisplayMe',function(text,source)
    local DisplayMe = true
    local id = GetPlayerFromServerId(source)
    if id == -1 then
        return
    end
    Citizen.CreateThread(function()
        while DisplayMe do
            local ped = PlayerPedId()
            Wait(1)
            local coordsMe = GetEntityCoords(GetPlayerPed(id),false)
            local coords = GetEntityCoords(ped,false)
            local distance = Vdist2(coordsMe,coords)
            if distance <= 30 then
                DrawText3D(coordsMe['x'],coordsMe['y'],coordsMe['z']+0.90,text)
            end
        end
    end)
    Wait(7000)
    DisplayMe = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC ROUPAS - EXPORT DO SCRIPT dynamic
-----------------------------------------------------------------------------------------------------------------------------------------
local active = {}
local savedClothes = {} 
RegisterNetEvent('dynamicRoupas')
AddEventHandler('dynamicRoupas',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and player_tunnel.checkRoupas() then
		if modelo == "jaqueta" then
			local modelClothe = 11 -- Modelo da peça de roupa
			if not active["jaqueta"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["jaqueta"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						end
						active["jaqueta"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["jaqueta"][1],savedClothes["jaqueta"][2],savedClothes["jaqueta"][3])
				active["jaqueta"] = false
			end
	
		elseif modelo == "chapeu" then
			local modelClothe = 0 -- Modelo da peça de roupa
			if not active["chapeu"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == "p0" then
						savedClothes["chapeu"] = numberClothes
						-- print(savedClothes)
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)

						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedPropIndex(ped,modelClothe,8,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedPropIndex(ped,modelClothe,120,0,2)
						end

						active["chapeu"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedPropIndex(ped,modelClothe,savedClothes["chapeu"][1],savedClothes["chapeu"][2],savedClothes["chapeu"][3])
				active["chapeu"] = false
			end

		elseif modelo == "mascara" then
			local modelClothe = 1
			if not active["mascara"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["mascara"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,0,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,0,0,2)
						end
						active["mascara"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["mascara"][1],savedClothes["mascara"][2],savedClothes["mascara"][3])
				active["mascara"] = false
			end

		elseif modelo == "oculos" then
			local modelClothe = 1 -- Modelo da peça de roupa
			if not active["oculos"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == "p1" then
						savedClothes["oculos"] = numberClothes
						-- print(savedClothes)
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedPropIndex(ped,modelClothe,0,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedPropIndex(ped,modelClothe,5,0,2)
						end
						active["oculos"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedPropIndex(ped,modelClothe,savedClothes["oculos"][1],savedClothes["oculos"][2],savedClothes["oculos"][3])
				active["oculos"] = false
			end

		elseif modelo == "camiseta" then
			local modelClothe = 8
			if not active["camiseta"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["camiseta"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						end
						active["camiseta"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["camiseta"][1],savedClothes["camiseta"][2],savedClothes["camiseta"][3])
				active["camiseta"] = false
			end

		elseif modelo == "luvas" then
			local modelClothe = 3
			if not active["luvas"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["luvas"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						end
						active["luvas"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["luvas"][1],savedClothes["luvas"][2],savedClothes["luvas"][3])
				active["luvas"] = false
			end

		elseif modelo == "calca" then
			local modelClothe = 4
			if not active["calca"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["calca"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,14,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,15,0,2)
						end
						active["calca"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["calca"][1],savedClothes["calca"][2],savedClothes["calca"][3])
				active["calca"] = false
			end

		elseif modelo == "sapato" then
			local modelClothe = 6
			if not active["sapato"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["sapato"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,34,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,35,0,2)
						end
						active["sapato"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["sapato"][1],savedClothes["sapato"][2],savedClothes["sapato"][3])
				active["sapato"] = false
			end

		elseif modelo == "colete" then
			local modelClothe = 9
			if not active["colete"] then
				local customization = vRP.getCustomization()
				for model, numberClothes in pairs(customization) do
					if tostring(model) == tostring(modelClothe) then
						savedClothes["colete"] = numberClothes
						vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Wait(2500)
						ClearPedTasks(ped)
						if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,0,0,2)
						elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
							SetPedComponentVariation(ped,modelClothe,0,0,2)
						end
						active["colete"] = true
					end
				end
			else
				vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,modelClothe,savedClothes["colete"][1],savedClothes["colete"][2],savedClothes["colete"][3])
				active["colete"] = false
			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW (REBOQUE)
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil

RegisterCommand("tow",function(source,args)
    local vehicle = GetPlayersLastVehicle()
    local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

    if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
        rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
        if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
            TriggerServerEvent("trytow",VehToNet(vehicle),VehToNet(rebocado))
        end
    end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
    if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
        local vehicle = NetToVeh(vehid)
        local rebocado = NetToVeh(rebid)
        if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
            if reboque == nil then
                if vehicle ~= rebocado then
                    local min,max = GetModelDimensions(GetEntityModel(rebocado))
                    AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
                    reboque = rebocado
                end
            else
                AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
                DetachEntity(reboque,false,false)
                PlaceObjectOnGroundProperly(reboque)
                reboque = nil
                rebocado = nil
            end
        end
    end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDeformationFixed(v) 
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bandagem')
AddEventHandler('bandagem',function()
    local ped = PlayerPedId()
    local bandagem = 0
    repeat
        Citizen.Wait(600)
        bandagem = bandagem + 1
        if GetEntityHealth(ped) > 101 then
            SetEntityHealth(ped,GetEntityHealth(ped)+1)
        end
    until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 101 or bandagem == 60
        TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
local card = {
	[1] = "A",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "10",
	[11] = "J",
	[12] = "Q",
	[13] = "K"
}

local tipos = {
	[1] = "^8♣",
	[2] = "^8♠",
	[3] = "^9♦",
	[4] = "^9♥"
}

RegisterNetEvent('CartasMe')
AddEventHandler('CartasMe',function(id,name,cd,naipe)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)),GetEntityCoords(GetPlayerPed(sonid)),true) < 5.999 then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestro2
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						Citizen.InvokeNative(0xAD738C3085FE7E11,sequestrado,true,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						Citizen.InvokeNative(0xAD738C3085FE7E11,npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,true)
						SetEntityInvincible(npc,false)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR VEÍCULO
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- UPDATE ROUPAS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("updateRoupas")
-- AddEventHandler("updateRoupas",function(custom)
-- 	local ped = PlayerPedId()
-- 	if GetEntityHealth(ped) > 101 then
-- 		if custom[1] == -1 then
-- 			SetPedComponentVariation(ped,1,0,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
-- 		end

-- 		if custom[3] == -1 then
-- 			SetPedComponentVariation(ped,5,0,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
-- 		end

-- 		if custom[5] == -1 then
-- 			SetPedComponentVariation(ped,7,0,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
-- 		end

-- 		if custom[7] == -1 then
-- 			SetPedComponentVariation(ped,3,15,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
-- 		end

-- 		if custom[9] == -1 then
-- 			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
-- 				SetPedComponentVariation(ped,4,18,0,2)
-- 			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
-- 				SetPedComponentVariation(ped,4,15,0,2)
-- 			end
-- 		else
-- 			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
-- 		end

-- 		if custom[11] == -1 then
-- 			SetPedComponentVariation(ped,8,15,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
-- 		end

-- 		if custom[13] == -1 then
-- 			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
-- 				SetPedComponentVariation(ped,6,34,0,2)
-- 			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
-- 				SetPedComponentVariation(ped,6,35,0,2)
-- 			end
-- 		else
-- 			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
-- 		end

-- 		if custom[15] == -1 then
-- 			SetPedComponentVariation(ped,11,15,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
-- 		end

-- 		if custom[17] == -1 then
-- 			SetPedComponentVariation(ped,9,0,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
-- 		end

-- 		if custom[19] == -1 then
-- 			SetPedComponentVariation(ped,10,0,0,2)
-- 		else
-- 			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
-- 		end

-- 		if custom[21] == -1 then
-- 			ClearPedProp(ped,0)
-- 		else
-- 			SetPedPropIndex(ped,0,custom[21],custom[22],2)
-- 		end

-- 		if custom[23] == -1 then
-- 			ClearPedProp(ped,1)
-- 		else
-- 			SetPedPropIndex(ped,1,custom[23],custom[24],2)
-- 		end

-- 		if custom[25] == -1 then
-- 			ClearPedProp(ped,2)
-- 		else
-- 			SetPedPropIndex(ped,2,custom[25],custom[26],2)
-- 		end

-- 		if custom[27] == -1 then
-- 			ClearPedProp(ped,6)
-- 		else
-- 			SetPedPropIndex(ped,6,custom[27],custom[28],2)
-- 		end

-- 		if custom[29] == -1 then
-- 			ClearPedProp(ped,7)
-- 		else
-- 			SetPedPropIndex(ped,7,custom[29],custom[30],2)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3DS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(0)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/300
	--DrawRect(_x,_y+0.0125,0.01+factor,0.1,0,0,0,80)
end

-----------------------------------------------------------------------------------------------------------------------------------------
--[ DRAWTEXT3DS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end