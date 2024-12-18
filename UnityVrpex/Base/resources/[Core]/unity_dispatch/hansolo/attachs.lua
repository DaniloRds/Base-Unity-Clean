
local Tunnel = module("vrp","lib/Tunnel")
attachs = Tunnel.getInterface("unity_dispatch")-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- /ATTACHS
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	print("Ataathjs")
	local ped = PlayerPedId()
	-- if args[1] == "s" then
		if attachs.checkPassOne() then
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then -- 
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL50") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_03"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_VINTAGEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CERAMICPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MINISMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MINISMG"),GetHashKey("COMPONENT_MINISMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMPACTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMPACTRIFLE"),GetHashKey("COMPONENT_COMPACTRIFLE_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_GUSENBERG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_GUSENBERG"),GetHashKey("COMPONENT_GUSENBERG_CLIP_02"))

			end
		elseif attachs.checkPassTwo() then
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_APPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_APPISTOL"),GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL50") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL50"),GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL"),GetHashKey("COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNSPISTOL_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNSPISTOL_MK2"),GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_02_SLIDE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYPISTOL"),GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_VINTAGEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_VINTAGEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CERAMICPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CERAMICPISTOL"),GetHashKey("COMPONENT_CERAMICPISTOL_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_05"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHINEPISTOL") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_MACHINEPISTOL_CLIP_03"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MACHINEPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MINISMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MINISMG"),GetHashKey("COMPONENT_MINISMG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),GetHashKey("COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"))
				
			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_10"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSHOTGUN"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPSHOTGUN"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ADVANCEDRIFLE"),GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE"),GetHashKey("COMPONENT_BULLPUPRIFLE_VARMOD_LOW"))
			
			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),GetHashKey("COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMPACTRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMPACTRIFLE"),GetHashKey("COMPONENT_COMPACTRIFLE_CLIP_03"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MG"),GetHashKey("COMPONENT_MG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG"),GetHashKey("COMPONENT_COMBATMG_VARMOD_LOWRIDER"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATMG_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATMG_MK2"),GetHashKey("COMPONENT_COMBATMG_MK2_CAMO_10"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_GUSENBERG") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_GUSENBERG"),GetHashKey("COMPONENT_GUSENBERG_CLIP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER"),GetHashKey("COMPONENT_REVOLVER_VARMOD_BOSS"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_REVOLVER_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNIPERRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_SNIPERRIFLE_VARMOD_LUXE"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SNIPERRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYSNIPER") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MAX"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_HEAVYSNIPER_MK2"),GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MASKMANRIFLE") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_MARKSMANRIFLE_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE"),GetHashKey("COMPONENT_MARKSMANRIFLE_VARMOD_LUXE"))

			elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MASKMANRIFLE_MK2") then
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_MARKSMANRIFLE_MK2_CLIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
				GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MASKMANRIFLE_MK2"),GetHashKey("COMPONENT_MARKSMANRIFLE_MK2_CAMO_09"))
			end
		end
	-- end
end)