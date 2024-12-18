-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEAR
-----------------------------------------------------------------------------------------------------------------------------------------
local nocauteado = false
local deathtimer = 600

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
    SetEntityHealth(PlayerPedId(),parseInt(health))
    if health > 101 then
        nocauteado = false
		deathtimer = 900
		ClearPedTasksImmediately(PlayerPedId())
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFRIENDLYFIRE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEADO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			wait = 1
			if not nocauteado then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				NetworkResurrectLocalPlayer(x,y,z,true,true,false)
				deathtimer = 600
				nocauteado = true
				vRPserver._updateHealth(101)
				SetEntityHealth(ped,101)
				tvRP.playAnim(false,{{"mini@cpr@char_b@cpr_str","cpr_kol_idle"}},true)
				SetEntityInvincible(ped,false)
				if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
				end
				TriggerEvent("radio:outServers")
				TransitionToBlurred(1000)
			else
				
				local bone = GetPedBoneCoords(PlayerPedId(), 24818, 0.0, 0.0, 0.0)
				if deathtimer > 0 then
					draw3DText(bone.x, bone.y, bone.z+0.5, "[~r~Voce Ficou Incosiente~w~]\n Tempo Restante de Vida \n ~r~"..deathtimer.."~w~ Segundos")
				else
					draw3DText(bone.x, bone.y, bone.z+0.5, "[~r~Volte ao Aeroporto~w~]\nPressione ~g~E")
				end
				--SetPedToRagdoll(ped,1000,1000,0,0,0,0)
				SetEntityHealth(ped,101)
				local anim = IsEntityPlayingAnim(PlayerPedId(),"mini@cpr@char_b@cpr_str","cpr_kol_idle",3)
				if anim ~= 1 then
					tvRP.playAnim(false,{{"mini@cpr@char_b@cpr_str","cpr_kol_idle"}},true)
				end
				BlockWeaponWheelThisFrame()
				DisableControlAction(0,21,true)
				DisableControlAction(0,22,true)
				DisableControlAction(0,23,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,32,true)
				DisableControlAction(0,33,true)
				DisableControlAction(0,34,true)
				DisableControlAction(0,35,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,168,true)
				DisableControlAction(0,169,true)
				DisableControlAction(0,170,true)
				DisableControlAction(0,177,true)
				DisableControlAction(0,182,true)
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,268,true)
				DisableControlAction(0,269,true)
				DisableControlAction(0,270,true)
				DisableControlAction(0,271,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,311,true)
				DisableControlAction(0,344,true)
			end
		end
		Citizen.Wait(wait)
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local wait = 1000
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 and deathtimer <= 0 then
			wait = 1
            if IsControlJustPressed(0,38) then
                TriggerEvent("resetBleeding")
                TriggerEvent("resetDiagnostic")
                TriggerServerEvent("clearInventory")
                deathtimer = 600
				nocauteado = false
				TransitionFromBlurred(1000)
                ClearPedBloodDamage(ped)
                SetEntityInvincible(ped,false)
                DoScreenFadeOut(1000)
                SetEntityHealth(ped,400)
                SetPedArmour(ped,0)
                Citizen.Wait(1000)
                SetEntityCoords(PlayerPedId(),-801.15+0.0001,-99.95+0.0001,37.57+0.0001,1,0,0,1)
                FreezeEntityPosition(ped,true)
                SetTimeout(5000,function()
                    FreezeEntityPosition(ped,false)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
                end)
            end
        end
		Citizen.Wait(wait)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------
-- ISINCOMA
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.isInComa()
	return nocauteado
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKRESSURECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.killGod()
	TransitionFromBlurred(1000)
	nocauteado = false
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,201)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PrisionGod()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		nocauteado = false
		ClearPedBloodDamage(ped)
		SetEntityInvincible(ped,false)
		SetEntityHealth(ped,201)
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW3D
-----------------------------------------------------------------------------------------------------------------------------------------
function draw3DText(x,y,z, text)
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