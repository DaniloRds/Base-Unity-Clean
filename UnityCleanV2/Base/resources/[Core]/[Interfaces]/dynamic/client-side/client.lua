-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu",function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true,true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data)
	if data["server"] == "true" then
		TriggerServerEvent(data["trigger"],data["param"])
	else
		TriggerEvent(data["trigger"],data["param"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	SendNUIMessage({ close = true })
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args,rawCommand)
	if true then 
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			-- Remover roupas
			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","dynamicRoupas","chapeu","clothes",false)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","dynamicRoupas","mascara","clothes",false)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","dynamicRoupas","oculos","clothes",false)
			exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar a jaqueta.","dynamicRoupas","jaqueta","clothes",false)
			exports["dynamic"]:AddButton("Camiseta","Colocar/Retirar a camiseta.","dynamicRoupas","camiseta","clothes",false)
			exports["dynamic"]:AddButton("Luvas","Colocar/Retirar as luvas.","dynamicRoupas","luvas","clothes",false)
			exports["dynamic"]:AddButton("Calças","Colocar/Retirar as calças.","dynamicRoupas","calca","clothes",false)
			exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar os sapatos.","dynamicRoupas","sapato","clothes",false)
			exports["dynamic"]:AddButton("Colete","Colocar/Retirar o colete.","dynamicRoupas","colete","clothes",false)

			-- Roupas salvas
			exports["dynamic"]:AddButton("Aplicar","Vestir as roupas salvas.","player:outfitFunctions","aplicar","outfit",true)
			exports["dynamic"]:AddButton("Salvar","Guardar as roupas do corpo.","player:outfitFunctions","salvar","outfit",true)
			exports["dynamic"]:AddButton("Aplicar","Vestir as roupas salvas.","player:outfitFunctions","preaplicar","premiumfit",true)
			exports["dynamic"]:AddButton("Salvar","Guardar as roupas do corpo.","player:outfitFunctions","presalvar","premiumfit",true)

			-- Residências
			exports["dynamic"]:AddButton("Residências Disponíveis","Ativa/Desativa as residências no mapa.","homes:functions","list","propertys",true)
			exports["dynamic"]:AddButton("Minhas Residências","Veja os endereços das suas residências.","homes:functions","checkProperyts","propertys",true)
			exports["dynamic"]:AddButton("Adicionar Morador","Adicione mais um morador a residência.","homes:functions","add","propertys",true)
			exports["dynamic"]:AddButton("Remover Morador","Remova um morador da residência.","homes:functions","rem","propertys",true)
			exports["dynamic"]:AddButton("Ver Moradores","Vejas que mtem acesso a residência.","homes:functions","check","propertys",true)
			exports["dynamic"]:AddButton("IPTU","Veja quanto tempo para o IPTU vencer.","homes:functions","checkTax","propertys",true)
			exports["dynamic"]:AddButton("Pagar IPTU","Pagar o IPTU da residência.","homes:functions","tax","propertys",true)
			exports["dynamic"]:AddButton("Vender","Vender a residência.","homes:functions","transfer","propertys",true)

			-- Player/Jogador
			exports["dynamic"]:AddButton("Entrar/Sair do Porta-Malas","Entra/Sai da mala do veículo mais próximo.","player:autosequestro","","otherPlayers",false)
			exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","player:bvida","","otherPlayers",false)
			exports["dynamic"]:AddButton("Revistar","Reviste o player mais próximo.","player:revistar","","otherPlayers",false)
			exports["dynamic"]:AddButton("Cobrar","Cobre um pagamento de um player próximo.","player:cobrar","","otherPlayers",true)
			exports["dynamic"]:AddButton("Loja Vip","Adquira já conteúdos exclusivos.","shopvip:openNui","","otherPlayers",false)

			-- Veículo			
			exports["dynamic"]:AddButton("Meus Veículos","Veja quais são seus veículos.","garagem:meusVeiculos","","vehicle",true)
			exports["dynamic"]:AddButton("Vender Veículo","Venda seu veículo para alguem.","garagem:venderVeiculo","","vehicle",true)
			exports["dynamic"]:AddButton("Vagas na Garagem","Veja a quantidade de vagas que você tem.","garagem:vagas","vagas","vehicle",true)
			if IsPedInAnyVehicle(ped) then
				exports["dynamic"]:AddButton("Informações do Veículo","Olhe o estado do motor e outros.","player:statusVehicle","","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seat","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seat","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seat","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seat","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)
			end

			-- SUB MENUS	
			exports["dynamic"]:SubMenu("Jogador","Funções de jogador.","otherPlayers")
			exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar peças de roupas.","clothes")
			exports["dynamic"]:SubMenu("Vestuário","Mudança de roupas rápidas.","outfit")
			exports["dynamic"]:SubMenu("Residências","Funções das residências.","propertys")
			exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")

			exports["dynamic"]:openMenu()
		end
	end
end)

----------------------------------------------------------------------------------------------------------
-- KEYMAPPING
----------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
