local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(978820595561148437)

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset('logo2')
		SetRichPresence("Moradores: "..players.."\n Base Clean 2.0 ")
		Citizen.Wait(10000)
	end
end)