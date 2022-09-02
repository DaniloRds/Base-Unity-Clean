local items = {}

local nomes = {
	Knife = "Faca",
	Dagger = "Adaga",
	Knuckle = "Soco-Inglês",
	Machete = "Machete",
	Switchblade = "Canivete",
	Wrench = "Chave de Grifo",
	Hammer = "Martelo",
	Golfclub = "Taco de Golf",
	Crowbar = "Pé de Cabra",
	Hatchet = "Machado",
	Flashlight = "Lanterna",
	Bat = "Taco de Beisebol",
	Bottle = "Garrafa",
	Battleaxe = "Machado de Batalha",
	Poolcue = "Taco de Sinuca",
	Stone_hatchet = "Machado de Pedra",
	Pistol = "M1911",
	Machinepistol = "TEC-9",
	Gadget_parachute = "Paraquedas",
	Combatpistol = "Glock 19",
	Carbinerifle = "M4A1",
	Carbinerifle_mk2 = "MPX",
	Compactrifle = "AKS-74U",
	Smg = "MP5",
	Pumpshotgun = "Shotgun",
	Pumpshotgun_mk2 = "Remington 870",
	Stungun = "Taser",
	Nightstick = "Cassetete",
	Snspistol = "HK P7M10",
	Microsmg = "Uzi",
	Assaultrifle = "AK-103",
	Fireextinguisher = "Extintor",
	Flare = "Sinalizador",
	Pistol50 = "Pistol .50",
	Appistol = "AP Pistol",
	Revolver = "Magnum 44",
	Revolver_mk2 = "Magnum 357",
	Pistol_mk2 = "FN Five Seven",
	Vintagepistol = "M1922",
	Assaultsmg = "MTAR-21",
	Musket = "Winchester 22",
	Gusenberg = "Thompson",
	Combatpdw = "Sig Sauer MPX",
	Heavysniper = "M82",
	Bzgas = "Granada",
	Petrolcan = "Galão de Gasolina"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.03 }

return items