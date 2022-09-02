-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	.div_registro {
		background: rgba(15,15,15,0.9);
		bottom: 25%;
		right: 2.2%;
		position: absolute;
		padding: 20px 30px;
		color: #fff;
		font-family: Arial;
		line-height: 30px;
		border: 3px solid #e9700d;
		letter-spacing: 1.7px;
		border-radius: 5px;
	}
	.div_registro b {
		color: #e9700d;
		padding: 0 4px 0 0;
	}
]]

local identity = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,344) and GetEntityHealth(PlayerPedId()) > 101 then
			if identity then
				vRP._removeDiv("registro")
				identity = false
			else
				local carteira,banco,coin,nome,sobrenome,idade,user_id,identidade,telefone,job,sub,vip,vipDays,multas = vRPNserver.Identidade()
				local bjob = ""
				local bsub = ""
				local bvip = ""
				local bmultas = ""

				if job ~= "" then
					bjob = "<br><b>Emprego:</b> "..job
				end
				if sub ~= "" then
					bsub = "<br><b>Patente:</b> "..sub
				end
				if vip ~= "" then
					bvip = "<br><b>VIP:</b> "..vip.." - "..vipDays.." Dias"
				end

				if parseInt(multas) > 0 then
					bmultas = "<br><b>Multas Pendentes:</b> " .. multas
				end
				
				vRP._setDiv('registro',css,'<b>Passaporte:</b> '..user_id..'<br><b>Nome:</b> '..nome..' '..sobrenome..'<br><b>Idade:</b> '..idade..'<br><b>Registro:</b> '..identidade..'<br><b>Telefone:</b> '..telefone..bjob..bsub..bvip..'<br><b>Moedas:</b>'..coin..' <img style="width: 16px; height: 16px;"  src="https://i.imgur.com/7s6CFr7.png"/><br><b>Carteira:</b> '..carteira..'<br><b>Banco:</b> '..banco..bmultas)
				identity = true
			end
		end
	end
end)