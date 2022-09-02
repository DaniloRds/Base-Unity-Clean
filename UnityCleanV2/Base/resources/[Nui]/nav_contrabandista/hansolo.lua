local menuactive = false
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nav_contrabandista")

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "comprar-algema" then
		TriggerServerEvent("contrabandista-comprar","algemas")

	elseif data == "comprar-c4" then
		TriggerServerEvent("contrabandista-comprar","c4")

	elseif data == "comprar-capuz" then
		TriggerServerEvent("contrabandista-comprar","capuz")

	elseif data == "comprar-furadeira" then
		TriggerServerEvent("contrabandista-comprar","furadeira")

	elseif data == "comprar-lockpick" then
		TriggerServerEvent("contrabandista-comprar","lockpick")

	elseif data == "comprar-placa" then
		TriggerServerEvent("contrabandista-comprar","placa")

	elseif data == "comprar-serra" then
		TriggerServerEvent("contrabandista-comprar","serra")
	
	elseif data == "comprar-pen" then
		TriggerServerEvent("contrabandista-comprar","pendrive")

	elseif data == "comprar-keycard" then
		TriggerServerEvent("contrabandista-comprar","keycard")

	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 582.42, ['y'] = -2722.71, ['z'] = 7.19 }, -- 582.41, -2722.72, 7.19
	{ ['x'] = 845.01, ['y'] = -902.78, ['z'] = 25.26 } -- 845.01, -902.78, 25.26
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local tdg = 1000

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) <= 2 then
				tdg = 1
				DrawText3D(lojas.x, lojas.y, lojas.z, "[~y~E~w~] Para ~y~Acessar o Contrabando~w~.")
			end
			
			if distance <= 15 then
				tdg = 1
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and func.checkPermissao () then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(tdg)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
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