local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
arc = Tunnel.getInterface("unity_core")
Config = {}
Config = module("unity_core","config_wall")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------------------------------------------------------------------
local wall = false
local players = {}
local admin = false
local lines = false

----------------------------------------------------------------------------------------------------------------------------------------
-- wall
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wall",function()
    if not admin then
		return
	end

	if admin then
		wall = not wall
	end		

    if wall then
		TriggerEvent("Notify","aviso","WALL ON!",8000)
		arc.reportwallLog()
	else
		TriggerEvent("Notify","aviso","WALL OFF!",8000)
		arc.reportunwallLog()
	end
end)

Citizen.CreateThread(function()
	while true do
	    local maze = 2000
		if wall then
			for k, id in ipairs(GetActivePlayers()) do
				if ((NetworkIsPlayerActive( id )) and GetPlayerPed(id) ~= PlayerPedId()) then
					x1, y1, z1 = table.unpack( GetEntityCoords( PlayerPedId(), true ) )
					x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
					distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))	
					if admin and (PlayerPedId() ~= GetPlayerPed(id)) then
						if GetPlayerPed(id) ~= -1 and players[id] ~= nil then
							local name = GetPlayerName(id)
							if name == nil or name == "" or name == -1 then
								name = "STEAM OFF"
							end
							local health = (GetEntityHealth(GetPlayerPed(id)) - 100)
							if health == 1 then
								health = 0
							end
							local vidaPorcento = health / 3
							vidaPorcento = math.floor(vidaPorcento)
							if vidaPorcento == 0 then
								vidaPorcento= "~h~~r~Morto~w~"
							end
							if vidaPorcento == 75 then
								vidaPorcento= "~y~75~w~"
							end
							if vidaPorcento == 74 then
								vidaPorcento= "~y~74~w~"
							end
							if vidaPorcento == 73 then
								vidaPorcento= "~y~73~w~"
							end
							if vidaPorcento == 72 then
								vidaPorcento= "~y~72~w~"
							end
							if vidaPorcento == 71 then
								vidaPorcento= "~y~71~w~"
							end
							if vidaPorcento == 70 then
								vidaPorcento= "~y~70~w~"
							end
							if vidaPorcento == 69 then
								vidaPorcento= "~y~69~w~"
							end
							if vidaPorcento == 68 then
								vidaPorcento= "~y~68~w~"
							end
							if vidaPorcento == 67 then
								vidaPorcento= "~y~67~w~"
							end
							if vidaPorcento == 66 then
								vidaPorcento= "~y~66~w~"
							end
							if vidaPorcento == 65 then
								vidaPorcento= "~y~65~w~"
							end
							if vidaPorcento == 64 then
								vidaPorcento= "~y~64~w~"
							end
							if vidaPorcento == 63 then
								vidaPorcento= "~y~63~w~"
							end
							if vidaPorcento == 62 then
								vidaPorcento= "~y~62~w~"
							end
							if vidaPorcento == 61 then
								vidaPorcento= "~y~61~w~"
							end
							if vidaPorcento == 60 then
								vidaPorcento= "~y~60~w~"
							end
							if vidaPorcento == 59 then
								vidaPorcento= "~y~59~w~"
							end
							if vidaPorcento == 58 then
								vidaPorcento= "~y~58~w~"
							end
							if vidaPorcento == 57 then
								vidaPorcento= "~y~57~w~"
							end
							if vidaPorcento == 56 then
								vidaPorcento= "~y~56~w~"
							end
							if vidaPorcento == 55 then
								vidaPorcento= "~y~55~w~"
							end
							if vidaPorcento == 54 then
								vidaPorcento= "~o~54~w~"
							end
							if vidaPorcento == 53 then
								vidaPorcento= "~o~53~w~"
							end
							if vidaPorcento == 52 then
								vidaPorcento= "~o~52~w~"
							end
							if vidaPorcento == 51 then
								vidaPorcento= "~o~51~w~"
							end
							if vidaPorcento == 50 then
								vidaPorcento= "~o~50~w~"
							end
							if vidaPorcento == 49 then
								vidaPorcento= "~o~49~w~"
							end
							if vidaPorcento == 48 then
								vidaPorcento= "~o~48~w~"
							end
							if vidaPorcento == 47 then
								vidaPorcento= "~o~47~w~"
							end
							if vidaPorcento == 46 then
								vidaPorcento= "~o~46~w~"
							end
							if vidaPorcento == 45 then
								vidaPorcento= "~o~45~w~"
							end
							if vidaPorcento == 44 then
								vidaPorcento= "~o~44~w~"
							end
							if vidaPorcento == 43 then
								vidaPorcento= "~o~43~w~"
							end
							if vidaPorcento == 42 then
								vidaPorcento= "~o~42~w~"
							end
							if vidaPorcento == 41 then
								vidaPorcento= "~o~41~w~"
							end
							if vidaPorcento == 40 then
								vidaPorcento= "~o~40~w~"
							end
							if vidaPorcento == 39 then
								vidaPorcento= "~o~39~w~"
							end
							if vidaPorcento == 38 then
								vidaPorcento= "~o~38~w~"
							end
							if vidaPorcento == 37 then
								vidaPorcento= "~o~37~w~"
							end
							if vidaPorcento == 36 then
								vidaPorcento= "~o~36~w~"
							end
							if vidaPorcento == 35 then
								vidaPorcento= "~o~35~w~"
							end
							if vidaPorcento == 34 then
								vidaPorcento= "~r~34~w~"
							end
							if vidaPorcento == 33 then
								vidaPorcento= "~r~33~w~"
							end
							if vidaPorcento == 32 then
								vidaPorcento= "~r~32~w~"
							end
							if vidaPorcento == 31 then
								vidaPorcento= "~r~31~w~"
							end
							if vidaPorcento == 30 then
								vidaPorcento= "~r~30~w~"
							end
							if vidaPorcento == 29 then
								vidaPorcento= "~r~29~w~"
							end
							if vidaPorcento == 28 then
								vidaPorcento= "~r~28~w~"
							end
							if vidaPorcento == 27 then
								vidaPorcento= "~r~27~w~"
							end
							if vidaPorcento == 26 then
								vidaPorcento= "~r~26~w~"
							end
							if vidaPorcento == 25 then
								vidaPorcento= "~r~25~w~"
							end
							if vidaPorcento == 24 then
								vidaPorcento= "~r~24~w~"
							end
							if vidaPorcento == 23 then
								vidaPorcento= "~r~23~w~"
							end
							if vidaPorcento == 22 then
								vidaPorcento= "~r~22~w~"
							end
							if vidaPorcento == 21 then
								vidaPorcento= "~r~21~w~"
							end
							if vidaPorcento == 20 then
								vidaPorcento= "~r~20~w~"
							end
							if vidaPorcento == 19 then
								vidaPorcento= "~r~19~w~"
							end
							if vidaPorcento == 18 then
								vidaPorcento= "~r~18~w~"
							end
							if vidaPorcento == 17 then
								vidaPorcento= "~r~17~w~"
							end
							if vidaPorcento == 16 then
								vidaPorcento= "~r~16~w~"
							end
							if vidaPorcento == 15 then
								vidaPorcento= "~r~15~w~"
							end
							if vidaPorcento == 14 then
								vidaPorcento= "~r~14~w~"
							end
							if vidaPorcento == 13 then
								vidaPorcento= "~r~13~w~"
							end
							if vidaPorcento == 12 then
								vidaPorcento= "~r~12~w~"
							end
							if vidaPorcento == 11 then
								vidaPorcento= "~r~11~w~"
							end
							if vidaPorcento == 10 then
								vidaPorcento= "~r~10~w~"
							end
							if vidaPorcento == 9 then
								vidaPorcento= "~r~9~w~"
							end
							if vidaPorcento == 8 then
								vidaPorcento= "~r~8~w~"
							end
							if vidaPorcento == 7 then
								vidaPorcento= "~r~7~w~"
							end
							if vidaPorcento == 6 then
								vidaPorcento= "~r~6~w~"
							end
							if vidaPorcento == 5 then
								vidaPorcento= "~r~5~w~"
							end
							if vidaPorcento == 4 then
								vidaPorcento= "~r~4~w~"
							end
							if vidaPorcento == 3 then
								vidaPorcento= "~r~3~w~"
							end
							if vidaPorcento == 2 then
								vidaPorcento= "~r~2~w~"
							end
							if vidaPorcento == 1 then
								vidaPorcento = "~r~1~w~"
							end
							local arma = GetSelectedPedWeapon(GetPlayerPed(id))
							if arma == GetHashKey"WEAPON_PISTOL_MK2" then 
								arma = "Five Seven"
							end
							if arma == GetHashKey"WEAPON_COMBATPISTOL" then
								arma = "Glock"
							end
							if arma == GetHashKey"WEAPON_PETROLCAN" then
								arma = "Gasolina"
							end
							if arma == GetHashKey"WEAPON_FLARE" then
								arma = "Sinalizador"
							end
							if arma == GetHashKey"WEAPON_FIREEXTINGUISHER" then
								arma = "Extintor"
							end
							if arma == GetHashKey"WEAPON_KNIFE" then
								arma = "Faca"
							end
							if arma == GetHashKey"WEAPON_SMG_MK2" then
								arma = "SMG II"
							end
							if arma == GetHashKey"WEAPON_ASSAULTSMG" then
								arma = "P90"
							end
							if arma == GetHashKey"WEAPON_DAGGER" then
								arma = "Adaga"
							end
							if arma == GetHashKey"WEAPON_KNUCKLE" then
								arma = "Soco Ingles"
							end
							if arma == GetHashKey"WEAPON_MACHETE" then
								arma = "Machete"
							end
							if arma == GetHashKey"WEAPON_SAWNOFFSHOTGUN" then
								arma = "12 De Cano Curto"
							end
							if arma == GetHashKey"WEAPON_SWITCHBLADE" then
								arma = "Canivete"
							end
							if arma == GetHashKey"WEAPON_WRENCH" then
								arma = "Chave Inglesa"
							end
							if arma == GetHashKey"WEAPON_UNARMED" then
								arma = ""
							end
							if arma == GetHashKey"WEAPON_HAMMER" then
								arma = "Martelo"
							end
							if arma == GetHashKey"WEAPON_PISTOL50" then
								arma = "Pistola .50"
							end
							if arma == GetHashKey"WEAPON_CARBINERIFLE" then
								arma = "M4A1"
							end
							if arma == GetHashKey"WEAPON_CARBINERIFLE_MK2" then
								arma = "M4 II"
							end
							if arma == GetHashKey"WEAPON_GOLFCLUB" then
								arma = "Taco De Golf"
							end
							if arma == GetHashKey"WEAPON_CROWBAR" then
								arma = "Pé De Cabra"
							end
							if arma == GetHashKey"WEAPON_HATCHET" then
								arma = "Machado"
							end
							if arma == GetHashKey"WEAPON_FLASHLIGHT" then
								arma = "Lanterna"
							end
							if arma == GetHashKey"WEAPON_BAT" then
								arma = "Taco De Beisebol"
							end
							if arma == GetHashKey"WEAPON_BOTTLE" then
								arma = "Garrafa"
							end
							if arma == GetHashKey"WEAPON_COMBATPDW" then
								arma = "Sig Sauer"
							end
							if arma == GetHashKey"WEAPON_BATTLEAXE" then
								arma = "Machado De Guerra"
							end
							if arma == GetHashKey"WEAPON_POOLCUE" then
								arma = "Taco De Sinuca"
							end
							if arma == GetHashKey"WEAPON_STONE_HATCHET" then
								arma = "Machado De Pedra"
							end
							if arma == GetHashKey"WEAPON_RPG" then
								arma = "Bazuca"
							end
							if arma == GetHashKey"WEAPON_NIGHTSTICK" then
								arma = "Cassetete"
							end
							if arma == GetHashKey"WEAPON_MACHINEPISTOL" then
								arma = "Tec-9"
							end
							if arma == GetHashKey"WEAPON_ASSAULTRIFLE_MK2" then
								arma = "AK II"
							end
							if arma == GetHashKey"WEAPON_STUNGUN" then
								arma = "Tazer"
							end
							if arma == GetHashKey"WEAPON_SPECIALCARBINE_MK2" then
								arma = "G36"
							end
							if arma == GetHashKey"WEAPON_SNSPISTOL_MK2" then
								arma = "Pistola Fajuta II"
							end
							if arma == GetHashKey"WEAPON_CARBINERIFLE" then
								arma = "Carabina"
							end
							if arma == GetHashKey"WEAPON_SMG" then
								arma = "SMG"
							end
							if arma == GetHashKey"WEAPON_PUMPSHOTGUN_MK2" then
								arma = "Shotgun II"
							end
							if arma == GetHashKey"WEAPON_MUSKET" then
								arma = "Mosquete"
							end
							if arma == GetHashKey"WEAPON_PISTOL" then
								arma = "Pistola"
							end
							if arma == GetHashKey"WEAPON_APPISTOL" then
								arma = "AP PISTOL"
							end
							if arma == GetHashKey"WEAPON_SNSPISTOL" then
								arma = "Pistola Fajuta"
							end
							if arma == GetHashKey"WEAPON_HEAVYPISTOL" then
								arma = "Pistola Pesada"
							end
							if arma == GetHashKey"weapon_vintagepistol" then
								arma = "Vintaje Pistol"
							end
							if arma == GetHashKey"WEAPON_FLAREGUN" then
								arma = "Sinalizador"
							end
							if arma == GetHashKey"WEAPON_MARKSMANPISTOL" then
								arma = "MARKSMAN PISTOL"
							end
							if arma == GetHashKey"WEAPON_REVOLVER" then
								arma = "REVOLVER"
							end
							if arma == GetHashKey"WEAPON_REVOLVER_MK2" then
								arma = "REVOLVER II"
							end
							if arma == GetHashKey"weapon_doubleaction" then
								arma = "Double Action"
							end
							if arma == GetHashKey"weapon_raypistol" then
								arma = "Ray Pistol"
							end
							if arma == GetHashKey"weapon_ceramicpistol" then
								arma = "Ceramic Pistol"
							end
							if arma == GetHashKey"weapon_navyrevolver" then
								arma = "Navy Revolver"
							end
							if arma == GetHashKey"weapon_gadgetpistol" then
								arma = "Gadget Pistol"
							end
							if arma == GetHashKey"weapon_microsmg" then
								arma = "Micro SMG"
							end
							if arma == GetHashKey"weapon_minismg" then
								arma = "MINI SMG"
							end
							if arma == GetHashKey"weapon_raycarbine" then
								arma = "Ray Carbine"
							end
							if arma == GetHashKey"weapon_pumpshotgun" then
								arma = "Pump Shotgun"
							end
							if arma == GetHashKey"weapon_assaultshotgun" then
								arma = "Assault Shothun"
							end
							if arma == GetHashKey"weapon_bullpupshotgun" then
								arma = "BullPup Shotgun"
							end
							if arma == GetHashKey"weapon_heavyshotgun" then
								arma = "Heavy Shotgun"
							end
							if arma == GetHashKey"weapon_dbshotgun" then
								arma = "DB Shothun"
							end
							if arma == GetHashKey"weapon_autoshotgun" then
								arma = "Auto Shotgun"
							end
							if arma == GetHashKey"weapon_combatshotgun" then
								arma = "Combat Shotgun"
							end
							if arma == GetHashKey"weapon_assaultrifle" then
								arma = "AK 47"
							end
							if arma == GetHashKey"weapon_advancedrifle" then
								arma = "Advanced Rifle"
							end
							if arma == GetHashKey"weapon_specialcarbine" then
								arma = "Special Carbine"
							end
							if arma == GetHashKey"weapon_bullpuprifle" then
								arma = "BullPup Rifle"
							end
							if arma == GetHashKey"weapon_bullpuprifle_mk2" then
								arma = "BullPup Rifle II"
							end
							if arma == GetHashKey"weapon_compactrifle" then
								arma = "Compact Rifle"
							end
							if arma == GetHashKey"weapon_militaryrifle" then
								arma = "Military Rifle"
							end
							if arma == GetHashKey"weapon_mg" then
								arma = "MG"
							end
							if arma == GetHashKey"weapon_combatmg" then
								arma = "CombatMG"
							end
							if arma == GetHashKey"weapon_combatmg" then
								arma = "CombatMG II"
							end
							if arma == GetHashKey"weapon_gusenberg" then
								arma = "GusenBerg"
							end
							if arma == GetHashKey"weapon_sniperrifle" then
								arma = "Sniper"
							end
							if arma == GetHashKey"weapon_heavysniper" then
								arma = "Heavy Sniper"
							end
							if arma == GetHashKey"weapon_heavysniper_mk2" then
								arma = "Heavy Sniper II"
							end
							if arma == GetHashKey"weapon_marksmanrifle" then
								arma = "MarksMan Sniper"
							end
							if arma == GetHashKey"weapon_marksmanrifle_mk2" then
								arma = "MarksMan Sniper II"
							end
							if arma == GetHashKey"weapon_grenadelauncher" then
								arma = "Grenade Launcher II"
							end
							if arma == GetHashKey"weapon_grenadelauncher_smoke" then
								arma = "Grenade Smoker"
							end
							if arma == GetHashKey"weapon_minigun" then
								arma = "Minigun"
							end
							if arma == GetHashKey"weapon_firework" then
								arma = "FireWork"
							end
							if arma == GetHashKey"weapon_railgun" then
								arma = "RailGun"
							end
							if arma == GetHashKey"weapon_hominglauncher" then
								arma = "Homing Laucher"
							end
							if arma == GetHashKey"weapon_compactlauncher" then
								arma = "Compact Launcher"
							end
							if arma == GetHashKey"weapon_rayminigun" then
								arma = "Ray Minigun"
							end
							if arma == GetHashKey"weapon_grenade" then
								arma = "Granada"
							end
							if arma == GetHashKey"weapon_bzgas" then
								arma = "bzgas"
							end
							if arma == GetHashKey"weapon_molotov" then
								arma = "Molotov"
							end
							if arma == GetHashKey"weapon_stickybomb" then
								arma = "Bomba Adesiva"
							end
							if arma == GetHashKey"weapon_proxmine" then
								arma = "Bomba Proxima"
							end
							if arma == GetHashKey"weapon_snowball" then
								arma = "Bola De Neve"
							end
							if arma == GetHashKey"weapon_pipebomb" then
								arma = "Pipe Bomt"
							end
							if arma == GetHashKey"weapon_ball" then
								arma = "Bola De Tenis"
							end
							if arma == GetHashKey"weapon_smokegrenade" then
								arma = "Granada De Fumaça"
							end
							if arma == GetHashKey"weapon_flare" then
								arma = "Sinalizador Launcher"
							end
							if arma == GetHashKey"weapon_hazardcan" then
								arma = "Galão"
							end
							if arma == 0 then
								arma = "Arma Desconhecida"
							end
							local colete = GetPedArmour(GetPlayerPed(id))
							if distance <= 250 then
								maze = 1
								DrawText3D(x2, y2, z2+1.7,"~o~["..distance.." m]~w~\n[ ~o~"..players[id].."~w~ ] "..name.." [HP: ~o~"..vidaPorcento.."~w~]")
								DrawText3D(x2, y2, z2-1.5,"~b~"..arma.."")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(maze)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local Maze = 1000
	    for _, id in ipairs(GetActivePlayers()) do
			local pid = arc.getId(GetPlayerServerId(id))
			if players[id] ~= pid or not players[id] then
				players[id] = pid
			end
		end
		Citizen.Wait(Maze)
	end
end)

Citizen.CreateThread(function()
	while true do
        local Maze = 1000
		admin = arc.getPermissao() 
        Citizen.Wait(Maze)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO 3D
----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.25)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end