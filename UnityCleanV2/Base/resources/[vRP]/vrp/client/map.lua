local Tools = module("vrp","lib/Tools")

function tvRP.getSkins()
    return GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")
end

function tvRP.getModelPlayer()
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        return "mp_m_freemode_01"
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    end
end

function tvRP.getCustomPlayer()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end

function tvRP.addBlip(x,y,z,idtype,idcolor,text,scale,route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if route then
		SetBlipRoute(blip,true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function tvRP.removeBlip(id)
	RemoveBlip(id)
end

function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end

function tvRP.getWaypoint()
    local waypoint = GetFirstBlipInfoId(8)
    if DoesBlipExist(waypoint) then
        return true,waypoint
    else
        return false
    end
end

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

function tvRP.addMarker(m,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	local marker = { m = m, x = x, y = y, z = z, sx = sx, sy = sy, sz = sz, r = r, g = g, b = b, a = a, visible_distance = visible_distance }

	if marker.sx == nil then marker.sx = 2.0 end
	if marker.sy == nil then marker.sy = 2.0 end
	if marker.sz == nil then marker.sz = 0.7 end

	if marker.r == nil then marker.r = 0 end
	if marker.g == nil then marker.g = 155 end
	if marker.b == nil then marker.b = 255 end
	if marker.a == nil then marker.a = 200 end

	marker.x = marker.x+0.001
	marker.y = marker.y+0.001
	marker.z = marker.z+0.001
	marker.sx = marker.sx+0.001
	marker.sy = marker.sy+0.001
	marker.sz = marker.sz+0.001

	if marker.visible_distance == nil then marker.visible_distance = 150 end

	local id = marker_ids:gen()
	markers[id] = marker

	return id
end

function tvRP.removeMarker(id)
	if markers[id] then
		markers[id] = nil
		marker_ids:free(id)
	end
end

function tvRP.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	tvRP.removeNamedMarker(name)
	named_markers[name] = tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	return named_markers[name]
end

function tvRP.removeNamedMarker(name)
	if named_markers[name] then
		tvRP.removeMarker(named_markers[name])
		named_markers[name] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(markers) do
			local px,py,pz = tvRP.getPosition()
			if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.visible_distance then
				DrawMarker(v.m,v.x,v.y,v.z,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,1)
			end
		end
	end
end)

local areas = {}
function tvRP.setArea(name,x,y,z,radius,height)
	local area = { x = x+0.001, y = y+0.001, z = z+0.001, radius = radius, height = height }
	if area.height == nil then area.height = 6 end
	areas[name] = area
end

function tvRP.removeArea(name)
	if areas[name] then
		areas[name] = nil
	end
end

--[[local standby = 0
function tvRP.setStandBY(timer)
	standby = standby + timer
end

function tvRP.getStandBY()
	return standby
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if standby > 0 then
			standby = standby - 1
		end
	end
end)]]

--RegisterCommand("procurado",function(source,args)
--	if standby > 0 then
--		TriggerEvent("Notify","aviso","Aguarde <b>"..standby.." segundos</b> até que tudo se acalme.")
--	else
--		TriggerEvent("Notify","aviso","Não está sendo procurado.")
--	end
--end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		--if standby <= 0 then
			local px,py,pz = tvRP.getPosition()
			for k,v in pairs(areas) do
				local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)

				if v.player_in and not player_in then
					vRPserver._leaveArea(k)
					v.player_in = false
				end

				if IsControlJustPressed(0,38) then
					if not v.player_in and player_in then
						vRPserver._enterArea(k)
						v.player_in = player_in
					end
				end

				if IsControlJustPressed(0,194) or IsControlJustPressed(0,25) or IsControlJustPressed(0,200) then
					if v.player_in and player_in then
						vRPserver._leaveArea(k)
						v.player_in = false
					end
				end
			end
		--end
	end
end)

function tvRP.getTimeFunction(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if days > 0 then
        return string.format("<b>%d Dias</b>, <b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",days,hours,minutes,seconds)
    elseif hours > 0 then
        return string.format("<b>%d Horas</b>, <b>%d Minutos</b> e <b>%d Segundos</b>",hours,minutes,seconds)
    elseif minutes > 0 then
        return string.format("<b>%d Minutos</b> e <b>%d Segundos</b>",minutes,seconds)
    elseif seconds > 0 then
        return string.format("<b>%d Segundos</b>",seconds)
    end
end