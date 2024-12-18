-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local shopOpen = false
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
local shoplock = {
	{ ['x'] = -41.64, ['y'] = -1099.24, ['z'] = 26.43 },
	{ ['x'] = -48.27, ['y'] = -1096.8, ['z'] = 26.43 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN SHOP
-----------------------------------------------------------------------------------------------------------------------------------------

-- CASO QUEIRA QUE A LOJA SEJA ACESSADA POR BLIP RETIRE O COMENTÁRIO DA LINHA 30 A 51 
-- E CONFIGURE AS COORDENADAS ACIMA

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)
-- 		local ped = PlayerPedId()
-- 		if not IsPedInAnyVehicle(ped) then
-- 			local x,y,z = table.unpack(GetEntityCoords(ped))
-- 			for k,v in pairs(shoplock) do
-- 				local distance = Vdist(x,y,z,v.x,v.y,v.z)
-- 				if distance <= 10.5 then
-- 					DrawMarker(29,v.x,v.y,v.z-0.1,0,0,0,0.0,0,0,1.5,1.5,1.5,0,255,228,196,196,0,0,10)
-- 					DrawMarker(27,v.x,v.y,v.z-0.9,0,0,0,0.0,0,0,1.5,1.5,1.5,0,255,228,196,0,0,0,10)
-- 					if distance <= 1.5 and IsControlJustPressed(0,38) then
-- 						SetNuiFocus(true,true)
-- 						SendNUIMessage({ action = "showMenu" })
-- 						shopOpen = true
-- 						vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

RegisterCommand("lojavip",function(source,args)
	local ped = PlayerPedId()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })
	shopOpen = true
	vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
end)

RegisterNetEvent("shopvip:openNui")
AddEventHandler("shopvip:openNui",function(action)
	local ped = PlayerPedId()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })
	shopOpen = true
	vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
	TriggerEvent("dynamic:closeSystem")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	shopOpen = false
	Citizen.Wait(500)
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST CARROSVIP1
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarrosvip1",function(data,cb)
	local veiculos = vSERVER.CarrosVip1()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST CARROSVIP2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarrosvip2",function(data,cb)
	local veiculos = vSERVER.CarrosVip2()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST CARROSVIP3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarrosvip3",function(data,cb)
	local veiculos = vSERVER.CarrosVip3()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST MOTOSVIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotosVip",function(data,cb)
	local veiculos = vSERVER.MotosVip()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST ADICIONAISVIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAdicionaisVip",function(data,cb)
	local veiculos = vSERVER.AdicionaisVip()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST PACOTESVIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPacotesVip",function(data,cb)
	local veiculos = vSERVER.PacotesVip()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST POSSUIDOSVIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidosVip",function(data,cb)
	local veiculos = vSERVER.PossuidosVip()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyShop",function(data)
	if data.name ~= nil then
		vSERVER.buyShop(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellShop",function(data)
	if data.name ~= nil then
		vSERVER.sellShop(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shopvip:Update")
AddEventHandler("shopvip:Update",function(action)
	SendNUIMessage({ action = action })
end)