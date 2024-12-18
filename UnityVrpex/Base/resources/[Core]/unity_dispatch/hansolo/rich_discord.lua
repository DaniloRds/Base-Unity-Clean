local Tunnel = module("vrp","lib/Tunnel")
misc = Tunnel.getInterface("unity_dispatch")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(821518247261634590)

	    local players = misc.discord()
		
	    SetDiscordRichPresenceAsset('richdiscord')
		SetRichPresence("Moradores: "..players.."\n Base Unity Vrpex")
		
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/pbT5wVp8e9")
        SetDiscordRichPresenceAction(1, "Site", "https://unitydev.discloud.app/")
		Citizen.Wait(10000)
	end
end)