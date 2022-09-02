local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emD = {}
Tunnel.bindInterface("vrp_discord",emD)
----------------------------------------------------------------------------------------------------
--[ FUNÇÃO DO DISCORD ]-----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function emD.discord()
	local quantidade = 0
	local users = vRP.getUsers()

	for k,v in pairs(users) do
		quantidade = quantidade + 1
	end

	return parseInt(quantidade)
end