local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local speed_lr = 3.0
local speed_ud = 3.0
local helicam = false
local fov = (fov_max+fov_min)*0.5

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if IsPlayerInPolmav() then
			wait = 3
			local heli = GetVehiclePedIsIn(PlayerPedId())
			SetVehicleRadioEnabled(heli,false)
			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = true
				end
				if IsControlJustPressed(0,154) then
					if GetPedInVehicleSeat(heli,1) == PlayerPedId() or GetPedInVehicleSeat(heli,2) == PlayerPedId() then
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
						TaskRappelFromHeli(PlayerPedId(),1)
					end
				end
			end
		end

		if helicam then
			wait = 3
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end
			local heli = GetVehiclePedIsIn(PlayerPedId())
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,heli,0.0,0.0,-1.5,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam,fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0)
			PopScaleformMovieFunctionVoid()
			while helicam and not IsEntityDead(PlayerPedId()) and (GetVehiclePedIsIn(PlayerPedId()) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end
		Citizen.Wait(wait)
	end
end)

function IsPlayerInPolmav()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	return IsVehicleModel(vehicle,GetHashKey("paramedicoheli")) or IsVehicleModel(vehicle,GetHashKey("policiaheli"))
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
end

function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z+rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then
		fov = math.max(fov-zoomspeed,fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov+zoomspeed,fov_max)
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0),10,GetVehiclePedIsIn(PlayerPedId()),0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num,math.cos(z)*num,math.sin(x))
end