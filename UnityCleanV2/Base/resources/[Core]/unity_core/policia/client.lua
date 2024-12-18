local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
policia_tunnel = Tunnel.getInterface("unity_core")
-------------------------------------------------------------------------------------------------------------------------
-- /RMASCARA
-------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rmascara")
AddEventHandler("rmascara",function()
	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end)
-------------------------------------------------------------------------------------------------------------------------
-- /RCHAPEU
-------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rchapeu")
AddEventHandler("rchapeu",function()
	ClearPedProp(PlayerPedId(),0)
end)

-------------------------------------------------------------------------------------------------------------
-- COLOCAR E REMOVER VEÍCULO
-------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:cv")
AddEventHandler("player:cv",function()
	policia_tunnel.colocarVeiculo()
end)

RegisterNetEvent("player:rv")
AddEventHandler("player:rv",function()
	policia_tunnel.removerVeiculo()
end)
-------------------------------------------------------------------------------------------------------------
-- AUTOSEQUESTRO
-------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:autosequestro")
AddEventHandler("player:autosequestro",function()
	local vehicle = vRP.getNearestVehicle(4)
	if vehicle then
		policia_tunnel.autosequestro()
	else
		TriggerEvent("Notify", "negado", "Você precisa estar mais próximo de um veículo.")
	end
end)
-------------------------------------------------------------------------------------------------------------------------
-- SET & REMOVE ALGEMAS
-------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setalgemas")
AddEventHandler("setalgemas",function()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,41,0,2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,25,0,2)
	end
end)
RegisterNetEvent("removealgemas")
AddEventHandler("removealgemas",function()
	SetPedComponentVariation(PlayerPedId(),7,0,0,2)
end)
-------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-------------------------------------------------------------------------------------------------------------------------
other = nil
drag = false
carregado = false
RegisterNetEvent("carregar")
AddEventHandler("carregar",function(p1)
    other = p1
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(1)
		if drag and other then
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
        else
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
				carregado = false
			end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not IsPedInAnyVehicle(PlayerPedId()) then
			if IsControlJustPressed(0,47) then
				TriggerServerEvent("vrp_policia:algemar")
			end
			if IsControlJustPressed(0,74) then
				TriggerServerEvent("vrp_policia:carregar")
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
local blacklistedWeapons = {
	"WEAPON_DAGGER",
	"WEAPON_BAT",
	"WEAPON_APPISTOL",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_STUNGUN",
	"WEAPON_FLARE",
	"GADGET_PARACHUTE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_RAYPISTOL",
	"WEAPON_FIREWORK",
	"WEAPON_BZGAS",
	"WEAPON_MUSKET"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local blacklistweapon = false
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		for k,v in ipairs(blacklistedWeapons) do
			if GetSelectedPedWeapon(ped) == GetHashKey(v) then
				blacklistweapon = true
			end
		end

		if IsPedShooting(ped) and not blacklistweapon then
			TriggerServerEvent('atirando',x,y,z)
		end

		blacklistweapon = false
	end
end)

local blips = {}
RegisterNetEvent('notificacao')
AddEventHandler('notificacao',function(x,y,z,user_id)
	if not DoesBlipExist(blips[user_id]) then
		PlaySoundFrontend(-1,"Enter_1st","GTAO_FM_Events_Soundset",false)
		TriggerEvent("NotifyPush",{ code = "RU", title = "Ocorrência em andamento", x = x, y = y, z = z, badge = "Disparos de arma de fogo" })
		blips[user_id] = AddBlipForCoord(x,y,z)
		SetBlipScale(blips[user_id],0.5)
		SetBlipSprite(blips[user_id],10)
		SetBlipColour(blips[user_id],49)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Disparos de arma de fogo")
		EndTextCommandSetBlipName(blips[user_id])
		SetBlipAsShortRange(blips[user_id],false)
		SetTimeout(30000,function()
			if DoesBlipExist(blips[user_id]) then
				RemoveBlip(blips[user_id])
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
local cone = nil
RegisterNetEvent('cone')
AddEventHandler('cone',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
	local prop = "prop_mp_cone_02"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		cone = CreateObject(GetHashKey(prop),coord.x,coord.y-0.5,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(cone)
		SetModelAsNoLongerNeeded(cone)
		Citizen.InvokeNative(0xAD738C3085FE7E11,cone,true,true)
		SetEntityHeading(cone,h)
		FreezeEntityPosition(cone,true)
		SetEntityAsNoLongerNeeded(cone)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			Citizen.InvokeNative(0xAD738C3085FE7E11,cone,true,true)
			SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(cone))
			DeleteObject(cone)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local barreira = nil
RegisterNetEvent('barreira')
AddEventHandler('barreira',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.5,-0.94)
	local prop = "prop_mp_barrier_02b"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		barreira = CreateObject(GetHashKey(prop),coord.x,coord.y-0.95,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(barreira)
		SetModelAsNoLongerNeeded(barreira)
		Citizen.InvokeNative(0xAD738C3085FE7E11,barreira,true,true)
		SetEntityHeading(barreira,h-180)
		FreezeEntityPosition(barreira,true)
		SetEntityAsNoLongerNeeded(barreira)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			barreira = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			Citizen.InvokeNative(0xAD738C3085FE7E11,barreira,true,true)
			SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(barreira))
			DeleteObject(barreira)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
local spike = nil
RegisterNetEvent('spike')
AddEventHandler('spike',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,2.5,0.0)
	local prop = "p_ld_stinger_s"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		spike = CreateObject(GetHashKey(prop),coord.x,coord.y,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(spike)
		SetModelAsNoLongerNeeded(spike)
		Citizen.InvokeNative(0xAD738C3085FE7E11,spike,true,true)
		SetEntityHeading(spike,h-180)
		FreezeEntityPosition(spike,true)
		SetEntityAsNoLongerNeeded(spike)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			Citizen.InvokeNative(0xAD738C3085FE7E11,spike,true,true)
			SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(spike))
			DeleteObject(spike)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local vcoord = GetEntityCoords(veh)
		local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
		if IsPedInAnyVehicle(PlayerPedId()) then
			if DoesObjectOfTypeExistAtCoords(vcoord.x,vcoord.y,vcoord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
				SetVehicleTyreBurst(veh,0,true,1000.0)
				SetVehicleTyreBurst(veh,1,true,1000.0)
				SetVehicleTyreBurst(veh,2,true,1000.0)
				SetVehicleTyreBurst(veh,3,true,1000.0)
				SetVehicleTyreBurst(veh,4,true,1000.0)
				SetVehicleTyreBurst(veh,5,true,1000.0)
				SetVehicleTyreBurst(veh,6,true,1000.0)
				SetVehicleTyreBurst(veh,7,true,1000.0)
				if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
					spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),false,false,false)
					Citizen.InvokeNative(0xAD738C3085FE7E11,spike,true,true)
					SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(spike))
					DeleteObject(spike)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local prisioneiro = false
local reducaopenal = false

RegisterNetEvent('prisioneiro')
AddEventHandler('prisioneiro',function(status)
	prisioneiro = status
	reducaopenal = false
	local ped = PlayerPedId()
	if prisioneiro then
		SetEntityInvincible(ped,false)
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,true,true)
		SetTimeout(10000,function()
			SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true,true)
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if prisioneiro then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),694.44,143.78,80.76,true)
			if distance >= 100 then
				SetEntityCoords(PlayerPedId(),673.32,90.96,83.95)
				TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 1500
		if prisioneiro then
			wait = 3
			local distance1 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1691.59,2566.05,45.56,true)
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1669.51,2487.71,45.82,true)

			if GetEntityHealth(PlayerPedId()) <= 100 then
				reducaopenal = false
				vRP._DeletarObjeto()
			end

			if distance1 <= 100 and not reducaopenal then
				DrawMarker(3,1691.59,2566.05,45.56,0,0,0,0,180.0,130.0,1.0,1.0,0.5,0,255,255,100,1,0,0,1)
				if distance1 <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA PEGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = true
						ResetPedMovementClipset(PlayerPedId(),0)
						SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
					end
				end
			end

			if distance2 <= 100 and reducaopenal then
				DrawMarker(3,1669.51,2487.71,45.82,0,0,0,0,180.0,130.0,1.0,1.0,0.5,0,255,255,100,1,0,0,1)
				if distance2 <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = false
						TriggerServerEvent("diminuirpena")
						vRP._DeletarObjeto()
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 1500
		if reducaopenal then
			wait = 2
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
		end
		Citizen.Wait(wait)
	end
end)
----------------------------------------------------------------------------
-- GUARDA AS ARMAS DO POLICIAL E DEIXA APENAS UMA PISTOL COM 50 MUNIÇÕES
----------------------------------------------------------------------------
RegisterNetEvent('limparArmas')
AddEventHandler('limparArmas',function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true);
    SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
    RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
    GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),100,0,1)
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
end)
----------------------------------------------------------------------------
-- ANDAR
----------------------------------------------------------------------------
RegisterCommand("homem",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@confident")
	end
end)

RegisterCommand("mulher",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@heels@c")
	end
end)

RegisterCommand("depressivo",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@depressed@a")
	end
end)

RegisterCommand("depressiva",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@depressed@a")
	end
end)

RegisterCommand("empresario",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@business@a")
	end
end)

RegisterCommand("determinado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@brave@a")
	end	
end)

RegisterCommand("descontraido",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@casual@a")
	end
end)

RegisterCommand("farto",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@fat@a")
	end
end)

RegisterCommand("estiloso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hipster@a")
	end
end)

RegisterCommand("ferido",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@injured")
	end
end)

RegisterCommand("nervoso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hurry@a")
	end
end)

RegisterCommand("desleixado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hobo@a")
	end
end)

RegisterCommand("infeliz",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@sad@a")
	end
end)

RegisterCommand("musculoso",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@muscle@a")
	end
end)

RegisterCommand("desligado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@shadyped@a")
	end
end)

RegisterCommand("fadiga",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@buzzed")
	end
end)

RegisterCommand("apressado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@hurry_butch@a")
	end
end)

RegisterCommand("descolado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@money")
	end
end)

RegisterCommand("corridinha",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@quick")
	end
end)

RegisterCommand("piriguete",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@maneater")
	end
end)

RegisterCommand("petulante",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@sassy")
	end
end)

RegisterCommand("arrogante",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@arrogant@a")
	end
end)

RegisterCommand("bebado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@slightlydrunk")
	end
end)

RegisterCommand("bebado2",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@verydrunk")
	end
end)

RegisterCommand("bebado3",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
	end
end)

RegisterCommand("irritado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@fire")
	end
end)

RegisterCommand("intimidado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
	end
end)

RegisterCommand("poderosa",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@handbag")
	end
end)

RegisterCommand("chateado",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@injured")
	end
end)

RegisterCommand("estilosa",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@posh@")
	end
end)

RegisterCommand("sensual",function(source,args)
	if not prisioneiro then
	vRP.loadAnimSet("move_f@sexy@a")
	end
end)

-- [DRAW]
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end