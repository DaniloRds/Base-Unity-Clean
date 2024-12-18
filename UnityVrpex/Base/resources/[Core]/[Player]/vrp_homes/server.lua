-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucasas = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESINFO
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FH01"] = { 5000000,2,1000 },
	["FH02"] = { 5000000,2,1000 },
	["FH03"] = { 5000000,2,1000 },
	["FH04"] = { 5000000,2,1000 },
	["FH05"] = { 5000000,2,1000 },
	["FH06"] = { 5000000,2,1000 },
	["FH07"] = { 5000000,2,1000 },
	["FH08"] = { 5000000,2,1000 },
	["FH09"] = { 5000000,2,1000 },
	["FH10"] = { 5000000,2,1000 },
	["FH11"] = { 5000000,2,1000 },
	["FH12"] = { 5000000,2,1000 },
	["FH13"] = { 5000000,2,1000 },
	["FH14"] = { 5000000,2,1000 },
	["FH15"] = { 5000000,2,1000 },
	["FH16"] = { 5000000,2,1000 },
	["FH17"] = { 5000000,2,1000 },
	["FH18"] = { 5000000,2,1000 },
	["FH19"] = { 5000000,2,1000 },
	["FH20"] = { 5000000,2,1000 },
	["FH21"] = { 5000000,2,1000 },
	["FH22"] = { 5000000,2,1000 },
	["FH23"] = { 5000000,2,1000 },
	["FH24"] = { 5000000,2,1000 },
	["FH25"] = { 5000000,2,1000 },
	["FH26"] = { 5000000,2,1000 },
	["FH27"] = { 5000000,2,1000 },
	["FH28"] = { 5000000,2,1000 },
	["FH29"] = { 5000000,2,1000 },
	["FH30"] = { 5000000,2,1000 },
	["FH31"] = { 5000000,2,1000 },
	["FH32"] = { 5000000,2,1000 },
	["FH33"] = { 5000000,2,1000 },
	["FH34"] = { 5000000,2,1000 },
	["FH35"] = { 5000000,2,1000 },
	["FH36"] = { 5000000,2,1000 },
	["FH37"] = { 5000000,2,1000 },
	["FH38"] = { 5000000,2,1000 },
	["FH39"] = { 5000000,2,1000 },
	["FH40"] = { 5000000,2,1000 },
	["FH41"] = { 5000000,2,1000 },
	["FH42"] = { 5000000,2,1000 },
	["FH43"] = { 5000000,2,1000 },
	["FH44"] = { 5000000,2,1000 },
	["FH45"] = { 5000000,2,1000 },
	["FH46"] = { 5000000,2,1000 },
	["FH47"] = { 5000000,2,1000 },
	["FH48"] = { 5000000,2,1000 },
	["FH49"] = { 5000000,2,1000 },
	["FH50"] = { 5000000,2,1000 },
	["FH51"] = { 5000000,2,1000 },
	["FH52"] = { 5000000,2,1000 },
	["FH53"] = { 5000000,2,1000 },
	["FH54"] = { 5000000,2,1000 },
	["FH55"] = { 5000000,2,1000 },
	["FH56"] = { 5000000,2,1000 },
	["FH57"] = { 5000000,2,1000 },
	["FH58"] = { 5000000,2,1000 },
	["FH59"] = { 5000000,2,1000 },
	["FH60"] = { 5000000,2,1000 },
	["FH61"] = { 5000000,2,1000 },
	["FH62"] = { 5000000,2,1000 },
	["FH63"] = { 5000000,2,1000 },
	["FH64"] = { 5000000,2,1000 },
	["FH65"] = { 5000000,2,1000 },
	["FH66"] = { 5000000,2,1000 },
	["FH67"] = { 5000000,2,1000 },
	["FH68"] = { 5000000,2,1000 },
	["FH69"] = { 5000000,2,1000 },
	["FH70"] = { 5000000,2,1000 },
	["FH71"] = { 5000000,2,1000 },
	["FH72"] = { 5000000,2,1000 },
	["FH73"] = { 5000000,2,1000 },
	["FH74"] = { 5000000,2,1000 },
	["FH75"] = { 5000000,2,1000 },
	["FH76"] = { 5000000,2,1000 },
	["FH77"] = { 5000000,2,1000 },
	["FH78"] = { 5000000,2,1000 },
	["FH79"] = { 5000000,2,1000 },
	["FH80"] = { 5000000,2,1000 },
	["FH81"] = { 5000000,2,1000 },
	["FH82"] = { 5000000,2,1000 },
	["FH83"] = { 5000000,2,1000 },
	["FH84"] = { 5000000,2,1000 },
	["FH85"] = { 5000000,2,1000 },
	["FH86"] = { 5000000,2,1000 },
	["FH87"] = { 5000000,2,1000 },
	["FH88"] = { 5000000,2,1000 },
	["FH89"] = { 5000000,2,1000 },
	["FH90"] = { 5000000,2,1000 },
	["FH91"] = { 5000000,2,1000 },
	["FH92"] = { 5000000,2,1000 },
	["FH93"] = { 5000000,2,1000 },
	["FH94"] = { 5000000,2,1000 },
	["FH95"] = { 5000000,2,1000 },
	["FH96"] = { 5000000,2,1000 },
	["FH97"] = { 5000000,2,1000 },
	["FH98"] = { 5000000,2,1000 },
	["FH99"] = { 5000000,2,1000 },
	["FH100"] = { 5000000,2,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LUXURY--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LX02"] = { 7000000,2,1000 },
	["LX01"] = { 7000000,2,1000 },
	["LX03"] = { 7000000,2,1000 },
	["LX04"] = { 7000000,2,1000 },
	["LX05"] = { 7000000,2,1000 },
	["LX06"] = { 7000000,2,1000 },
	["LX07"] = { 7000000,2,1000 },
	["LX08"] = { 7000000,2,1000 },
	["LX09"] = { 7000000,2,1000 },
	["LX10"] = { 7000000,2,1000 },
	["LX11"] = { 7000000,2,1000 },
	["LX12"] = { 7000000,2,1000 },
	["LX13"] = { 7000000,2,1000 },
	["LX14"] = { 7000000,2,1000 },
	["LX15"] = { 7000000,2,1000 },
	["LX16"] = { 7000000,2,1000 },
	["LX17"] = { 7000000,2,1000 },
	["LX18"] = { 7000000,2,1000 },
	["LX19"] = { 7000000,2,1000 },
	["LX20"] = { 7000000,2,1000 },
	["LX21"] = { 7000000,2,1000 },
	["LX22"] = { 7000000,2,1000 },
	["LX23"] = { 7000000,2,1000 },
	["LX24"] = { 7000000,2,1000 },
	["LX25"] = { 7000000,2,1000 },
	["LX26"] = { 7000000,2,1000 },
	["LX27"] = { 7000000,2,1000 },
	["LX28"] = { 7000000,2,1000 },
	["LX29"] = { 7000000,2,1000 },
	["LX30"] = { 7000000,2,1000 },
	["LX31"] = { 7000000,2,1000 },
	["LX32"] = { 7000000,2,1000 },
	["LX33"] = { 7000000,2,1000 },
	["LX34"] = { 7000000,2,1000 },
	["LX35"] = { 7000000,2,1000 },
	["LX36"] = { 7000000,2,1000 },
	["LX37"] = { 7000000,2,1000 },
	["LX38"] = { 7000000,2,1000 },
	["LX39"] = { 7000000,2,1000 },
	["LX40"] = { 7000000,2,1000 },
	["LX41"] = { 7000000,2,1000 },
	["LX42"] = { 7000000,2,1000 },
	["LX43"] = { 7000000,2,1000 },
	["LX44"] = { 7000000,2,1000 },
	["LX45"] = { 7000000,2,1000 },
	--["LX46"] = { 7000000,2,1000 },
	["LX47"] = { 7000000,2,1000 },
	["LX48"] = { 7000000,2,1000 },
	["LX49"] = { 7000000,2,1000 },
	["LX50"] = { 7000000,2,1000 },
	["LX51"] = { 7000000,2,1000 },
	["LX52"] = { 7000000,2,1000 },
	["LX53"] = { 7000000,2,1000 },
	["LX54"] = { 7000000,4,1000 },
	["LX55"] = { 7000000,2,1000 },
	["LX56"] = { 7000000,2,1000 },
	["LX57"] = { 7000000,2,1000 },
	["LX58"] = { 7000000,2,1000 },
	["LX59"] = { 7000000,2,1000 },
	["LX60"] = { 7000000,2,1000 },
	["LX61"] = { 7000000,2,1000 },
	["LX62"] = { 7000000,2,1000 },
	["LX63"] = { 7000000,2,1000 },
	["LX64"] = { 7000000,2,1000 },
	["LX65"] = { 7000000,2,1000 },
	["LX66"] = { 7000000,2,1000 },
	["LX67"] = { 7000000,2,1000 },
	["LX68"] = { 7000000,2,1000 },
	["LX69"] = { 7000000,2,1000 },
	["LX70"] = { 7000000,2,1000 },	
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------SAMIR-------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LS01"] = { 200000,2,200 },
	["LS02"] = { 200000,2,200 },
	["LS03"] = { 200000,2,200 },
	["LS04"] = { 200000,2,200 },
	["LS05"] = { 200000,2,200 },
	["LS06"] = { 200000,2,200 },
	["LS07"] = { 200000,2,200 },
	["LS08"] = { 200000,2,200 },
	["LS09"] = { 200000,2,200 },
	["LS10"] = { 200000,2,200 },
	["LS11"] = { 200000,2,200 },
	["LS12"] = { 200000,2,200 },
	["LS13"] = { 200000,2,200 },
	["LS14"] = { 200000,2,200 },
	["LS15"] = { 200000,2,200 },
	["LS16"] = { 200000,2,200 },
	["LS17"] = { 200000,2,200 },
	["LS18"] = { 200000,2,200 },
	["LS19"] = { 200000,2,200 },
	["LS20"] = { 200000,2,200 },
	["LS21"] = { 200000,2,200 },
	["LS22"] = { 200000,2,200 },
	["LS23"] = { 200000,2,200 },
	["LS24"] = { 200000,2,200 },
	["LS25"] = { 200000,2,200 },
	["LS26"] = { 200000,2,200 },
	["LS27"] = { 200000,2,200 },
	["LS28"] = { 200000,2,200 },
	["LS29"] = { 200000,2,200 },
	["LS30"] = { 200000,2,200 },
	["LS31"] = { 200000,2,200 },
	["LS32"] = { 200000,2,200 },
	["LS33"] = { 200000,2,200 },
	["LS34"] = { 200000,2,200 },
	["LS35"] = { 200000,2,200 },
	["LS36"] = { 200000,2,200 },
	["LS37"] = { 200000,2,200 },
	["LS38"] = { 200000,2,200 },
	["LS39"] = { 200000,2,200 },
	["LS40"] = { 200000,2,200 },
	["LS41"] = { 200000,2,200 },
	["LS42"] = { 200000,2,200 },
	["LS43"] = { 200000,2,200 },
	["LS44"] = { 200000,2,200 },
	["LS45"] = { 200000,2,200 },
	["LS46"] = { 200000,2,200 },
	["LS47"] = { 200000,2,200 },
	["LS48"] = { 200000,2,200 },
	["LS49"] = { 200000,2,200 },
	["LS50"] = { 200000,2,200 },
	["LS51"] = { 200000,2,200 },
	["LS52"] = { 200000,2,200 },
	["LS53"] = { 200000,2,200 },
	["LS54"] = { 200000,2,200 },
	["LS55"] = { 200000,2,200 },
	["LS56"] = { 200000,2,200 },
	["LS57"] = { 200000,2,200 },
	["LS58"] = { 200000,2,200 },
	["LS59"] = { 200000,2,200 },
	["LS60"] = { 200000,2,200 },
	["LS61"] = { 200000,2,200 },
	["LS62"] = { 200000,2,200 },
	["LS63"] = { 200000,2,200 },
	["LS64"] = { 200000,2,200 },
	["LS65"] = { 200000,2,200 },
	["LS66"] = { 200000,2,200 },
	["LS67"] = { 200000,2,200 },
	["LS68"] = { 200000,2,200 },
	["LS69"] = { 200000,2,200 },
	["LS70"] = { 200000,2,200 },
	["LS71"] = { 200000,2,200 },
	["LS72"] = { 200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------BOLLINI------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["BL01"] = { 200000,2,200 },
	["BL02"] = { 200000,2,200 },
	["BL03"] = { 200000,2,200 },
	["BL04"] = { 200000,2,200 },
	["BL05"] = { 200000,2,200 },
	["BL06"] = { 200000,2,200 },
	["BL07"] = { 200000,2,200 },
	["BL08"] = { 200000,2,200 },
	["BL09"] = { 200000,2,200 },
	["BL10"] = { 200000,2,200 },
	["BL11"] = { 200000,2,200 },
	["BL12"] = { 200000,2,200 },
	["BL13"] = { 200000,2,200 },
	["BL14"] = { 200000,2,200 },
	["BL15"] = { 200000,2,200 },
	["BL16"] = { 200000,2,200 },
	["BL17"] = { 200000,2,200 },
	["BL18"] = { 200000,2,200 },
	["BL19"] = { 200000,2,200 },
	["BL20"] = { 200000,2,200 },
	["BL21"] = { 200000,2,200 },
	["BL22"] = { 200000,2,200 },
	["BL23"] = { 200000,2,200 },
	["BL24"] = { 200000,2,200 },
	["BL25"] = { 200000,2,200 },
	["BL26"] = { 200000,2,200 },
	["BL27"] = { 200000,2,200 },
	["BL28"] = { 200000,2,200 },
	["BL29"] = { 200000,2,200 },
	["BL30"] = { 200000,2,200 },
	["BL31"] = { 200000,2,200 },
	["BL32"] = { 200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LOSVAGOS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LV01"] = { 300000,2,250 },
	["LV02"] = { 300000,2,250 },
	["LV03"] = { 300000,2,250 },
	["LV04"] = { 300000,2,250 },
	["LV05"] = { 300000,2,250 },
	["LV06"] = { 300000,2,250 },
	["LV07"] = { 300000,2,250 },
	["LV08"] = { 300000,2,250 },
	["LV09"] = { 300000,2,250 },
	["LV10"] = { 300000,2,250 },
	["LV11"] = { 300000,2,250 },
	["LV12"] = { 300000,2,250 },
	["LV13"] = { 300000,2,250 },
	["LV14"] = { 300000,2,250 },
	["LV15"] = { 300000,2,250 },
	["LV16"] = { 300000,2,250 },
	["LV17"] = { 300000,2,250 },
	["LV18"] = { 300000,2,250 },
	["LV19"] = { 300000,2,250 },
	["LV20"] = { 300000,2,250 },
	["LV21"] = { 300000,2,250 },
	["LV22"] = { 300000,2,250 },
	["LV23"] = { 300000,2,250 },
	["LV24"] = { 300000,2,250 },
	["LV25"] = { 300000,2,250 },
	["LV26"] = { 300000,2,250 },
	["LV27"] = { 300000,2,250 },
	["LV28"] = { 300000,2,250 },
	["LV29"] = { 300000,2,250 },
	["LV30"] = { 300000,2,250 },
	["LV31"] = { 300000,2,250 },
	["LV32"] = { 300000,2,250 },
	["LV33"] = { 300000,2,250 },
	["LV34"] = { 300000,2,250 },
	["LV35"] = { 300000,2,250 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------KRONDORS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["KR01"] = { 200000,2,200 },
	["KR02"] = { 200000,2,200 },
	["KR03"] = { 200000,2,200 },
	["KR04"] = { 200000,2,200 },
	["KR05"] = { 200000,2,200 },
	["KR06"] = { 200000,2,200 },
	["KR07"] = { 200000,2,200 },
	["KR08"] = { 200000,2,200 },
	["KR09"] = { 200000,2,200 },
	["KR10"] = { 200000,2,200 },
	["KR11"] = { 200000,2,200 },
	["KR12"] = { 200000,2,200 },
	["KR13"] = { 200000,2,200 },
	["KR14"] = { 200000,2,200 },
	["KR15"] = { 200000,2,200 },
	["KR16"] = { 200000,2,200 },
	["KR17"] = { 200000,2,200 },
	["KR18"] = { 200000,2,200 },
	["KR19"] = { 200000,2,200 },
	["KR20"] = { 200000,2,200 },
	["KR21"] = { 200000,2,200 },
	["KR22"] = { 200000,2,200 },
	["KR23"] = { 200000,2,200 },
	["KR24"] = { 200000,2,200 },
	["KR25"] = { 200000,2,200 },
	["KR26"] = { 200000,2,200 },
	["KR27"] = { 200000,2,200 },
	["KR28"] = { 200000,2,200 },
	["KR29"] = { 200000,2,200 },
	["KR30"] = { 200000,2,200 },
	["KR31"] = { 200000,2,200 },
	["KR32"] = { 200000,2,200 },
	["KR33"] = { 200000,2,200 },
	["KR34"] = { 200000,2,200 },
	["KR35"] = { 200000,2,200 },
	["KR36"] = { 200000,2,200 },
	["KR37"] = { 200000,2,200 },
	["KR38"] = { 200000,2,200 },
	["KR39"] = { 200000,2,200 },
	["KR40"] = { 200000,2,200 },
	["KR41"] = { 200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------GROOVEMOTEL--------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["GR01"] = { 200000,2,200 },
	["GR02"] = { 200000,2,200 },
	["GR03"] = { 200000,2,200 },
	["GR04"] = { 200000,2,200 },
	["GR05"] = { 200000,2,200 },
	["GR06"] = { 200000,2,200 },
	["GR07"] = { 200000,2,200 },
	["GR08"] = { 200000,2,200 },
	["GR09"] = { 200000,2,200 },
	["GR10"] = { 200000,2,200 },
	["GR11"] = { 200000,2,200 },
	["GR12"] = { 200000,2,200 },
	["GR13"] = { 200000,2,200 },
	["GR14"] = { 200000,2,200 },
	["GR15"] = { 200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------ALLSUELLMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["AS01"] = { 200000,2,200 },
	["AS02"] = { 200000,2,200 },
	["AS03"] = { 200000,2,200 },
	["AS04"] = { 200000,2,200 },
	["AS05"] = { 200000,2,200 },
	["AS06"] = { 200000,2,200 },
	["AS07"] = { 200000,2,200 },
	["AS08"] = { 200000,2,200 },
	["AS09"] = { 200000,2,200 },
	["AS10"] = { 200000,2,200 },
	["AS12"] = { 200000,2,200 },
	["AS13"] = { 200000,2,200 },
	["AS14"] = { 200000,2,200 },
	["AS15"] = { 200000,2,200 },
	["AS16"] = { 200000,2,200 },
	["AS17"] = { 200000,2,200 },
	["AS18"] = { 200000,2,200 },
	["AS19"] = { 200000,2,200 },
	["AS20"] = { 200000,2,200 },
	["AS21"] = { 200000,2,200 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------PINKCAGEMOTEL-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PC01"] = { 140000,2,150 },
	["PC02"] = { 140000,2,150 },
	["PC03"] = { 140000,2,150 },
	["PC04"] = { 140000,2,150 },
	["PC05"] = { 140000,2,150 },
	["PC06"] = { 140000,2,150 },
	["PC07"] = { 140000,2,150 },
	["PC08"] = { 140000,2,150 },
	["PC09"] = { 140000,2,150 },
	["PC10"] = { 140000,2,150 },
	["PC11"] = { 140000,2,150 },
	["PC12"] = { 140000,2,150 },
	["PC13"] = { 140000,2,150 },
	["PC14"] = { 140000,2,150 },
	["PC15"] = { 140000,2,150 },
	["PC16"] = { 140000,2,150 },
	["PC17"] = { 140000,2,150 },
	["PC18"] = { 140000,2,150 },
	["PC19"] = { 140000,2,150 },
	["PC20"] = { 140000,2,150 },
	["PC21"] = { 140000,2,150 },
	["PC22"] = { 140000,2,150 },
	["PC23"] = { 140000,2,150 },
	["PC24"] = { 140000,2,150 },
	["PC25"] = { 140000,2,150 },
	["PC26"] = { 140000,2,150 },
	["PC27"] = { 140000,2,150 },
	["PC28"] = { 140000,2,150 },
	["PC29"] = { 140000,2,150 },
	["PC30"] = { 140000,2,150 },
	["PC31"] = { 140000,2,150 },
	["PC32"] = { 140000,2,150 },
	["PC33"] = { 140000,2,150 },
	["PC34"] = { 140000,2,150 },
	["PC35"] = { 140000,2,150 },
	["PC36"] = { 140000,2,150 },
	["PC37"] = { 140000,2,150 },
	["PC38"] = { 140000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------PALETOMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PL01"] = { 140000,2,150 },
	["PL02"] = { 140000,2,150 },
	["PL03"] = { 140000,2,150 },
	["PL04"] = { 140000,2,150 },
	["PL05"] = { 140000,2,150 },
	["PL06"] = { 140000,2,150 },
	["PL07"] = { 140000,2,150 },
	["PL08"] = { 140000,2,150 },
	["PL09"] = { 140000,2,150 },
	["PL11"] = { 140000,2,150 },
	["PL12"] = { 140000,2,150 },
	["PL13"] = { 140000,2,150 },
	["PL14"] = { 140000,2,150 },
	["PL15"] = { 140000,2,150 },
	["PL16"] = { 140000,2,150 },
	["PL17"] = { 140000,2,150 },
	["PL18"] = { 140000,2,150 },
	["PL19"] = { 140000,2,150 },
	["PL20"] = { 140000,2,150 },
	["PL21"] = { 140000,2,150 },
	["PL22"] = { 140000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------PALETOBAY-------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PB01"] = { 300000,2,250 },
	["PB02"] = { 300000,2,250 },
	["PB03"] = { 300000,2,250 },
	["PB04"] = { 300000,2,250 },
	["PB05"] = { 300000,2,250 },
	["PB06"] = { 300000,2,250 },
	["PB07"] = { 300000,2,250 },
	["PB08"] = { 300000,2,250 },
	["PB09"] = { 300000,2,250 },
	["PB10"] = { 300000,2,250 },
	["PB11"] = { 300000,2,250 },
	["PB12"] = { 300000,2,250 },
	["PB13"] = { 300000,2,250 },
	["PB14"] = { 300000,2,250 },
	["PB15"] = { 300000,2,250 },
	["PB16"] = { 300000,2,250 },
	["PB17"] = { 300000,2,250 },
	["PB18"] = { 300000,2,250 },
	["PB19"] = { 300000,2,250 },
	["PB20"] = { 300000,2,250 },
	["PB21"] = { 300000,2,250 },
	["PB22"] = { 300000,2,250 },
	["PB23"] = { 300000,2,250 },
	["PB24"] = { 300000,2,250 },
	["PB25"] = { 300000,2,250 },
	["PB26"] = { 300000,2,250 },
	["PB27"] = { 300000,2,250 },
	["PB28"] = { 300000,2,250 },
	["PB29"] = { 300000,2,250 },
	["PB30"] = { 300000,2,250 },
	["PB31"] = { 300000,2,250 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MANSAO------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["MS01"] = { 99999999,2,1500 },
	["MS02"] = { 99999999,2,1500 },
	["MS03"] = { 99999999,10,1500 },
	["MS04"] = { 99999999,5,1000000000 },
	["MS05"] = { 99999999,2,1500 },
	["MS07"] = { 99999999,2,1500 },
	["MS08"] = { 99999999,2,1500 },
	["MS09"] = { 99999999,2,1500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["SS01"] = { 99999999,2,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FZ01"] = { 99999999,2,1500 },
	
	["JACK"] = { 99999999,2,50000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local blipHomes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(15000)
	end
end)
------------------------------------------------------------------------------------------------------------------------
-- HOMES
------------------------------------------------------------------------------------------------------------------------
RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
			TriggerClientEvent("Notify",source,"sucesso","Todas as residências disponíveis foram marcadas no seu mapa.",6000)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				--if not vRP.hasGroup(user_id,"Platina") then
					local house_price = parseInt(homes[tostring(args[2])][1])
					local house_tax = 0.10
					if house_price >= 7000000 then
						house_tax = 0.00
					end
					if vRP.tryFullPayment(user_id,parseInt(house_price * house_tax)) then
						vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				--end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(homes[tostring(v.home)][1])
						local house_tax = 0.10
						if house_price >= 7000000 then
							house_tax = 0.00
						end

						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)

RegisterServerEvent("homes:functions")
AddEventHandler("homes:functions",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if mode == "add" and homes then
			local possuiCasa = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#possuiCasa) >= 1 then
				TriggerClientEvent("dynamic:closeSystem",source)
				local house_name = vRP.prompt(source,"Digite o endereço da casa:","")
				local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(house_name) })
				if myHomes[1] then
					local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(house_name) })
					if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(house_name)][2]) then
						TriggerClientEvent("Notify",source,"negado","A residência "..tostring(house_name).." atingiu o máximo de moradores.",10000)
						return
					end

					local new_resident = vRP.prompt(source,"Digite o RG do novo morador:","")

					vRP.execute("homes/add_permissions",{ home = tostring(house_name), user_id = parseInt(new_resident) })
					vRP.execute("homes/upd_permissions",{ home = tostring(house_name), user_id = parseInt(new_resident) })
					local identity = vRP.getUserIdentity(parseInt(new_resident))
					if identity then
						TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(house_name).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "rem" and homes then
			local possuiCasa = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#possuiCasa) >= 1 then
				TriggerClientEvent("dynamic:closeSystem",source)
				local house_name = vRP.prompt(source,"Digite o endereço da casa:","")
				local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(house_name) })
				if myHomes[1] then
					local resident = vRP.prompt(source,"Digite o RG do morador:","")
					local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(resident), home = tostring(house_name) })
					if userHomes[1] then
						vRP.execute("homes/rem_permissions",{ home = tostring(house_name), user_id = parseInt(resident) })
						local identity = vRP.getUserIdentity(parseInt(resident))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(house_name).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
			TriggerClientEvent("Notify",source,"sucesso","Todas as residências disponíveis foram marcadas no seu mapa.",6000)
			TriggerClientEvent("dynamic:closeSystem",source)
		elseif mode == "check" and homes then
			local possuiCasa = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#possuiCasa) >= 1 then
				TriggerClientEvent("dynamic:closeSystem",source)
				local house_name = vRP.prompt(source,"Digite o endereço da casa:","")
				local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(house_name) })
				if myHomes[1] then
					local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(house_name) })
					if parseInt(#userHomes) > 1 then
						local permissoes = ""
						for k,v in pairs(userHomes) do
							if v.user_id ~= user_id then
								local identity = vRP.getUserIdentity(v.user_id)
								permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
								if k ~= #userHomes then
									permissoes = permissoes.."<br>"
								end
							end
							Citizen.Wait(10)
						end
						TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(house_name).."</b>: <br>"..permissoes,20000)
					else
						TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "transfer" and homes then
			local possuiCasa = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#possuiCasa) >= 1 then
				TriggerClientEvent("dynamic:closeSystem",source)
				local house_name = vRP.prompt(source,"Digite o endereço da casa:","")
				local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(house_name) })
				if myHomes[1] then
					local buyer = vRP.prompt(source,"Digite o RG do comprador:","")
					local identity = vRP.getUserIdentity(parseInt(buyer))
					if identity then
						local ok = vRP.request(source,"Transferir a residência <b>"..tostring(house_name).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
						if ok then
							vRP.execute("homes/rem_allpermissions",{ home = tostring(house_name) })
							vRP.execute("homes/buy_permissions",{ home = tostring(house_name), user_id = parseInt(buyer), tax = parseInt(myHomes[1].tax) })
							TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(house_name).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "tax" and homes then
			local possuiCasa = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#possuiCasa) >= 1 then
				TriggerClientEvent("dynamic:closeSystem",source)
				local house_name = vRP.prompt(source,"Digite o endereço da casa:","")
				local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(house_name) })
				if ownerHomes[1] then
					local house_price = parseInt(homes[tostring(house_name)][1])
					local house_tax = 0.10
					if house_price >= 7000000 then
						house_tax = 0.00
					end
					if vRP.tryFullPayment(user_id,parseInt(house_price * house_tax)) then
						vRP.execute("homes/rem_permissions",{ home = tostring(house_name), user_id = parseInt(ownerHomes[1].user_id) })
						vRP.execute("homes/buy_permissions",{ home = tostring(house_name), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "checkTax" and homes then
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(homes[tostring(v.home)][1])
						local house_tax = 0.10
						if house_price >= 7000000 then
							house_tax = 0.00
						end

						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b> IPTU:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>IPTU em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						end
						Citizen.Wait(10)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		elseif mode == "checkProperyts" and homes then
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						TriggerClientEvent("Notify",source,"importante","<b>Suas Residências:</b> "..v.home.."</b>",20000)
						Citizen.Wait(10)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Você não possuí uma residência.</b>",20000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then

						if homes[homeName][1] >= 7000000 then
							return true
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) and homes[homeName][1] < 5000000 then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) and homes[homeName][1] < 5000000 then
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b> ?",30)
					if ok then
						if vRP.tryFullPayment(user_id,parseInt(homes[tostring(homeName)][1])) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
					return false
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,"policia.permissao") then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"aviso","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(homes[tostring(homeName)][3]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(homes[tostring(homeName)][3]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)
							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
							SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end
		return false
	end
end