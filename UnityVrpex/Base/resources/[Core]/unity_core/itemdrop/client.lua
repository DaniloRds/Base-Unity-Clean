local dropList = {}

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove',function(id)
	if dropList[id] ~= nil then
		dropList[id] = nil
	end
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll',function(id,marker)
	dropList[id] = marker
end)

local cooldown = false
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		for k,v in pairs(dropList) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 5 then
				wait = 2
				DrawText3D(v.x,v.y,v.z, "~g~[Item]\n~w~"..v.count.."x ~b~"..string.upper(v.name),4,0.5,0.93,0.50,255,255,255,180)
				if distance <= 1.5 and v.count ~= nil and v.name ~= nil and not IsPedInAnyVehicle(ped) then
					DrawMarker(21,v.x,v.y,v.z-0.5,0,0,0,0.0,0,0,0.5,0.5,0.4,0,255,255,50,0,0,0,1)
					--	dwakdaks("PRESSIONE  ~y~E~w~  PARA PEGAR~y~ "..v.count.."X "..string.upper(v.name),4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(1,38) and not cooldown then
						cooldown = true
						TriggerServerEvent('DropSystem:take',k)
						SetTimeout(3000,function()
							cooldown = false
						end)
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function uudwaia(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function dwakdaks(x,y,z, text)
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

function DrawText3D(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
  end