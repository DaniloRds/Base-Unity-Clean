local function f(n)
	return (n+0.00001)
end

function interpolateCam(x, y, z, rX, rY, rZ, fov, duration, shake) 
    if DoesCamExist(cam) then
        camPos = GetCamCoord(cam)
        SetFocusPosAndVel(camPos.x, camPos.y, camPos.z, 0.0, 0.0, 0.0)
        SetHdArea(camPos.x, camPos.y, camPos.z, 30)
        local interpolCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, rX, rY, rZ, fov, false, 0)
        if shake then ShakeCam(interpolCam, "HAND_SHAKE", 0.1) end 
        SetCamActiveWithInterp(interpolCam, cam, duration, 1, 1)
        RenderScriptCams(true, true, duration, false, false, 0)
        DestroyCam(cam, true)
        cam = interpolCam
        interpolCam = nil
    end

end

function PointCamAtBone(bone,ox,oy,oz)
    SetCamActive(cam,true)
    local veh = vehSelected
    local b = GetEntityBoneIndexByName(veh,bone)
    local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh,b))
    local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh,bx,by,bz))
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh,ox2+f(ox),oy2+f(oy),oz2+f(oz)))
    SetCamCoord(cam,x,y,z)
    PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh,0,oy2,oz2))
    RenderScriptCams(1,1,1000,0,0)
end


function MoveVehCam(pos,x,y,z)
    SetCamActive(cam,true)
    local veh = vehSelected
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2,d.x*-2,d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),(height)+f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),(height/2)+f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,-(width/2)+f(x),f(y),f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,(width/2)+f(x),f(y),f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),f(y),(height/2)+f(z)))
	end
	SetCamCoord(cam,ox,oy,oz)
    PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh,0,0,f(0)))
    RenderScriptCams(0,1,1000,0,0)
	RenderScriptCams(1,1,1000,0,0)
end

function defaultCam()
    SetFollowVehicleCamViewMode(0)
    RenderScriptCams(0,1,1000,0,0)
    SetVehicleDoorShut(vehSelected,1,0)
    SetVehicleDoorShut(vehSelected,0,0)
    SetVehicleDoorShut(vehSelected,4,0)
    SetVehicleDoorShut(vehSelected,5,0)
end