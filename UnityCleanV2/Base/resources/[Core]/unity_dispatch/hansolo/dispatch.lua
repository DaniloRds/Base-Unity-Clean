Citizen.CreateThread(function()
    for i = 1,120 do
        EnableDispatchService(i,false)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ DENSITY NPCS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetVehicleDensityMultiplierThisFrame(0.5) -- seleciona densidade do trafico
        SetPedDensityMultiplierThisFrame(0.5) -- seleciona a densidade de Npc
        SetRandomVehicleDensityMultiplierThisFrame(0.0) -- seleciona a densidade de carros estacionadas a andar etc
        SetParkedVehicleDensityMultiplierThisFrame(0.0) -- seleciona a densidade de carros estacionadas
        SetScenarioPedDensityMultiplierThisFrame(0.3, 0.5) -- seleciona a densidade de Npc a andar pela cidade
        SetGarbageTrucks(false) --Desactiva os Camioes do Lixo de dar Spawn Aleatoriamente
        SetRandomBoats(true) --Desactiva os Barcos de dar Spawn na agua
        SetCreateRandomCops(false) --Desactiva a Policia a andar pela cidade
        SetCreateRandomCopsNotOnScenarios(false) --Para o Spanw Aleatorio de Policias Fora do Cenario
        SetCreateRandomCopsOnScenarios(false) --Para o Spanw Aleatorio de Policias no Cenario
        DisablePlayerVehicleRewards(PlayerId()) --Nao mexer --> Impossibilita que os players possam ganhar armas nas viaturas da policia e ems
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
        RemoveVehiclesFromGeneratorsInArea(x - 1000.0, y - 1000.0, z - 1000.0, x + 1000.0, y + 1000.0, z + 1000.0)
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
        SetAudioFlag("PoliceScannerDisabled",true);
    end
end)

local density = false
Citizen.CreateThread(function()
	SetTimeout(120000,function()
		density = true
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TASERTIME ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end
		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MAPA NA MÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local wasmenuopen = false

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if IsPauseMenuActive() and not wasmenuopen then
            SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true) -- set unarmed
            TriggerEvent("Map:ToggleMap")
			TriggerEvent('hudOff',true)
            --TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_TOURIST_MAP", 0, false) -- Start the scenario
            wasmenuopen = true
        end
            
        if not IsPauseMenuActive() and wasmenuopen then
        	Wait(2000)
            TriggerEvent("Map:ToggleMap")
			TriggerEvent('hudOff',false)
            wasmenuopen = false
        end
    end
end)

local holdingMap = false
local mapModel = "prop_tourist_map_01"
local animDict = "amb@world_human_tourist_map@male@base"
local animName = "base"
local map_net = nil

-- Toggle Map --

RegisterNetEvent("Map:ToggleMap")
AddEventHandler("Map:ToggleMap", function()
    if not holdingMap then
        RequestModel(GetHashKey(mapModel))
        while not HasModelLoaded(GetHashKey(mapModel)) do
            Citizen.Wait(100)
        end

        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(100)
        end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local mapspawned = CreateObject(GetHashKey(mapModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(200)
        local netid = ObjToNet(mapspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(mapspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        map_net = netid
        holdingMap = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(map_net), 1, 1)
        DeleteEntity(NetToObj(map_net))
        map_net = nil
        holdingMap = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TREMOR DE TELA AO BATER VEÍCULO ]----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			wait = 1
			local currentSpeed = GetEntitySpeed(vehicle)*3.6
			if currentSpeed ~= oldSpeed then
				if (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 80) then
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.5)
					SetVehicleEngineOn(vehicle, false, false, true)
					SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-100)
				end
				oldSpeed = currentSpeed
			else
				if oldSpeed ~= 0 then
					oldSpeed = 0
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DAMAGE WALK MODE ]-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				wait = 3
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
		Citizen.Wait(wait)
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COOLDOWN BUNNYHOP ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESATIVA O CONTROLE DO CARRO ENQUANTO ESTIVER NO AR ]--------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local wait = 1000
		if IsPedInAnyVehicle(PlayerPedId()) then
			wait = 3
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)
			if DoesEntityExist(veh) and not IsEntityDead(veh) then
				local model = GetEntityModel(veh)
				if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
					DisableControlAction(0,59)
					DisableControlAction(0,60)
					--DisableControlAction(0,73)
				end
			end
		end
		Citizen.Wait(wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR AUTO-CAPACETE NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
		local wait = 1000
			if IsPedInAnyVehicle(PlayerPedId()) then
				local veh = GetVehiclePedIsUsing(PlayerPedId())
				if veh ~= 0 then 
					SetPedConfigFlag(PlayerPedId(),35,false) 
				end
			end
		Citizen.Wait(wait)  
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR SONS DA CIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function() 
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
	SetAudioFlag("PoliceScannerDisabled",true); 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ESTOURAR OS PNEUS ]------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local wait = 1000
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
			wait = 3
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
                      if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
						SetVehiclePetrolTankHealth(vehicle, -4000, 1)
						SetVehicleEngineTemperature(vehicle, 5000, 1)
						SetVehicleEngineHealth(vehicle, -4000, 1)
						SetVehicleTyreBurst(vehicle, 0, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 1, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 2, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 3, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 4, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 5, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 45, 1)
						Citizen.Wait(100)
						SetVehicleTyreBurst(vehicle, 47, 1)
                    end
                end
            end
        end
		Citizen.Wait(wait)
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR X NA MOTO ]--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			wait = 3
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				DisableControlAction(0,73,true) 
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVA EMPINAR A MOTO A MAIS DE 100KM/H
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
			wait = 3
            local vehicle = GetVehiclePedIsIn(ped)
            local speed = math.floor(GetEntitySpeed(vehicle) * 3.6)
              if GetPedInVehicleSeat(vehicle, -1) == ped and (GetVehicleClass(vehicle) == 8 or IsVehicleModel(vehicle,GetHashKey("kawasaki"))) then
                if speed > 100 then
                    DisableControlAction(1,60,true)
                end
            end
        end
		Citizen.Wait(wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ Um Tiro na Cabeça Mata ]-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(4)
        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DESABILITAR A CORONHADA ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local wait = 500
        local ped = PlayerPedId()
			if IsPedArmed(ped,6) then
				wait = 3
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
			end
		Citizen.Wait(wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO ]---------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local wait = 1000
        local ped = PlayerPedId()
        DisableControlAction(0,36,true)

        if not IsPedInAnyVehicle(ped) then
			wait = 3 
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
				
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
		else
			wait = 1000
        end
		Citizen.Wait(wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACAO DA BOCA AO FALAR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
  local players = {}
  for i = 0, 256 do
      if NetworkIsPlayerActive(i) then
          players[#players + 1] = i
      end
  end
  return players
end

Citizen.CreateThread(function()

  RequestAnimDict("facials@gen_male@variations@normal")
  RequestAnimDict("mp_facial")

  local talkingPlayers = {}
  while true do
      Citizen.Wait(300)

      for k,v in pairs(GetPlayers()) do
          local boolTalking = NetworkIsPlayerTalking(v)
          if v ~= PlayerId() then
              if boolTalking and not talkingPlayers[v] then
                  PlayFacialAnim(GetPlayerPed(v), "mic_chatter", "mp_facial")
                  talkingPlayers[v] = true
              elseif not boolTalking and talkingPlayers[v] then
                  PlayFacialAnim(GetPlayerPed(v), "mood_normal_1", "facials@gen_male@variations@normal")
                  talkingPlayers[v] = nil
              end
          end
      end
  end
end)