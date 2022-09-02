local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
src = {}
Tunnel.bindInterface("vrp_player",src)
vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgarmas = ""
local webhookgarmas250 = ""
local webhookequipar = "" 
local webhookenviaritem = ""
local webhookenviardinheiro = ""
local webhookdropar = ""
local webhookpaypal = ""
local webhookgive = ""
local webhooksaquear = ""
local webhookchat = ""
local webhookilegal = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ROUPAS SERVER.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.")
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["dinheiroespecie"] = { index = "dinheiroespecie", nome = "Dinheiro em Espécie"},
	["semi-identidade"] = { index = "semi-identidade", nome = "Identidade Sem Plástico" },
	["plastico"] = { index = "plastico", nome = "Plástico" },
	["insumos"] = { index = "insumos", nome = "Insumos Alimentícios" },
	["relatorio"] = { index = "relatorio", nome = "Relatório" },
	["valefone"] = { index = "valefone", nome = "Vale Troca Número"},
	["valeplaca"] = { index = "valeplaca", nome = "Vale Troca Placa"},
	["valemansao"] = { index = "valemansao", nome = "Vale Mansão"},
	["laranja"] = { index = "laranja", nome = "Laranja" },
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	["colete"] = { index = "colete", nome = "Colete" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite" },
	["receita-medica"] = { index = "receita-medica", nome = "Receita Médica" },
	["tora"] = { index = "tora", nome = "Tora de Madeira" },
	["alianca"] = { index = "alianca", nome = "Aliança" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex" },
	["omeprazol"] = { index = "omeprazol", nome = "Omeprazol" },
	["dipirona"] = { index = "dipirona", nome = "Dipirona" },
	["gelol"] = { index = "gelol", nome = "Gelol" },
	["paracetamol"] = { index = "paracetamol", nome = "Paracetamol" },
	["decupramim"] = { index = "decupramim", nome = "Decupramim" },
	["identidade"] = { index = "identidade", nome = "Identidade" },
	["maquininha"] = { index = "maquininha", nome = "Maquininha" },
	["buscopan"] = { index = "buscopan", nome = "Buscopan" },
	["cartaoclonado"] = { index = "cartaoclonado", nome = "Cartão Clonado" },
	["cartaodecredito"] = { index = "cartaodecredito", nome = "Cartão de Crédito" },
	["cartaodedebito"] = { index = "cartaodedebito", nome = "Cartão de Débito" },
	["heroin"] = { index = "heroin", nome = "Heroina" },
	["eter"] = { index = "eter", nome = "Eter" },
	["cloroformio"] = { index = "cloroformio", nome = "Cloroformio" },
	["novalgina"] = { index = "novalgina", nome = "Novalgina" },
	["alivium"] = { index = "alivium", nome = "Alivium" },
	["agua-oxigenada"] = { index = "agua-oxigenada", nome = "Agua-Oxigenada" },
	["nokusin"] = { index = "nokusin", nome = "Nokusin" },
	["sidelnafila"] = { index = "sidelnafila", nome = "Sidelnafila" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja" },
	["tequila"] = { index = "tequila", nome = "Tequila" },
	["alvejante"] = { index = "alvejante", nome = "Alvejante" },
	["borrifador"] = { index = "borrifador", nome = "Borrifador" },
	["caixa-vazia"] = { index = "caixa-vazia", nome = "Caixa Vazia" },
	["vodka"] = { index = "vodka", nome = "Vodka" },
	["whisky"] = { index = "whisky", nome = "Whisky" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque" },
	["absinto"] = { index = "absinto", nome = "Absinto" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["algemas"] = { index = "algemas", nome = "Algemas" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick" },
	["militec"] = { index = "militec", nome = "Militec-1" },
	["celular"] = { index = "celular", nome = "Celular" },
	["carnedecormorao"] = { index = "carnedecormorao", nome = "Carne de Cormorão" },
	["carnedecorvo"] = { index = "carnedecorvo", nome = "Carne de Corvo" },
	["carnedeaguia"] = { index = "carnedeaguia", nome = "Carne de Águia" },
	["carnedecervo"] = { index = "carnedecervo", nome = "Carne de Cervo" },
	["carnedecoelho"] = { index = "carnedecoelho", nome = "Carne de Coelho" },
	["carnedecoyote"] = { index = "carnedecoyote", nome = "Carne de Coyote" },
	["carnedelobo"] = { index = "carnedelobo", nome = "Carne de Lobo" },
	["carnedepuma"] = { index = "carnedepuma", nome = "Carne de Puma" },
	["carnedejavali"] = { index = "carnedejavali", nome = "Carne de Javali" },
	["graos"] = { index = "graos", nome = "Graos" },
	["graosimpuros"] = { index = "graosimpuros", nome = "Graos Impuros" },
	["keycard"] = { index = "keycard", nome = "Keycard" },
	["isca"] = { index = "isca", nome = "Isca" },
	["dourado"] = { index = "dourado", nome = "Dourado" },
	["corvina"] = { index = "corvina", nome = "Corvina" },
	["salmao"] = { index = "salmao", nome = "Salmão" },
	["pacu"] = { index = "pacu", nome = "Pacu" },
	["pintado"] = { index = "pintado", nome = "Pintado" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré" },
	["lambari"] = { index = "lambari", nome = "Lambari" },
	["energetico"] = { index = "energetico", nome = "Energético" },
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["maconha"] = { index = "maconha", nome = "Maconha" },
	["adubo"] = { index = "adubo", nome = "Adubo" },
	["fertilizante"] = { index = "fertilizante", nome = "Fertilizante" },
	["capsula"] = { index = "capsula", nome = "Cápsula" },
	["polvora"] = { index = "polvora", nome = "Pólvora" },
	["malote"] = { index = "malote", nome = "Malote" },
	["cedula"] = { index = "cedula", nome = "Cédula" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Tecidos ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["tecido"] = { index = "tecido", nome = "Tecido" },
	["tecidor"] = { index = "tecidor", nome = "Tecido Reforçado" },
	["agulha"] = { index = "agulha", nome = "Agulha" },

	["orgao"] = { index = "orgao", nome = "Órgão" },
	["etiqueta"] = { index = "etiqueta", nome = "Etiqueta" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive" },
	["notebook"] = { index = "notebook", nome = "Notebook" },
	["placa"] = { index = "placa", nome = "Placa" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado" },
	["pulseiraroubada"] = { index = "pulseiraroubada", nome = "Pulseira Roubada" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado" },
	["brincoroubado"] = { index = "brincoroubado", nome = "Brinco Roubado" },
	["carteiraroubada"] = {  index = "carteiraroubada", nome = "Carteira Roubada"  },
	["tabletroubado"] = {  index = "tabletroubado", nome = "Tablet Roubado"  },
	["sapatosroubado"] = {  index = "sapatosroubado", nome = "Sapatos Roubado"  },
	["folhadecoca"] = { index = "folhadecoca", nome = "Folha de Coca" },
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Coca" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína" },
	["fungo"] = { index = "fungo", nome = "Fungo" },
	["dietilamina"] = { index = "dietilamina", nome = "Dietilamina" },
	["lsd"] = { index = "lsd", nome = "LSD" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas Não Alcoólicas ]-----------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["agua"] = { index = "agua", nome = "Água" },
	["leite"] = { index = "leite", nome = "Leite" },
	["cafe"] = { index = "cafe", nome = "Café" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com leite" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino" },
	["cha"] = { index = "cha", nome = "Chá" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk" },
	["cola"] = { index = "cola", nome = "Cola" },

	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha" },
	["hotdog"] = { index = "hotdog", nome = "HotDog" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer" },
	["chips"] = { index = "chips", nome = "Batata Chips" },
	["batataf"] = { index = "batataf", nome = "Batata Frita" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza" },
	["frango"] = { index = "frango", nome = "Frango Frito" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate" },
	["taco"] = { index = "taco", nome = "Taco" },
	["yakisoba"] = { index = "yakisoba", nome = "Yakisoba" },
	["raceticket"] = { index = "raceticket", nome = "Race Ticket" },

	["uva"] = { index = "uva", nome = "Uva" },
	["uvafermentada"] = { index = "uvafermentada", nome = "Uva Fermentada" },
	["vinhobranco"] = { index = "vinhobranco", nome = "Vinho Branco" },
	["vinhorose"] = { index = "vinhorose", nome = "Vinho Rose" },
	["vinhotinto"] = { index = "vinhotinto", nome = "Vinho Tinto" },


	["acidobateria"] = { index = "acidobateria", nome = "Ácido de Bateria" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["armacaodearma"] = { index = "armacaodearma", nome = "Armação de Arma" },
	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma" },
	["logsinvasao"] = { index = "logsinvasao", nome = "L. Inv. Banco" },
	["keysinvasao"] = { index = "keysinvasao", nome = "K. Inv. Banco" },
	["pendriveinformacoes"] = { index = "pendriveinformacoes", nome = "P. com Info." },
	["acessodeepweb"] = { index = "acessodeepweb", nome = "P. DeepWeb" },
	["diamante"] = { index = "diamante", nome = "Min. Diamante" },
	["ouro"] = { index = "ouro", nome = "Min. Ouro" },
	["bronze"] = { index = "bronze", nome = "Min. Bronze" },
	["ferro"] = { index = "ferro", nome = "Min. Ferro" },
	["rubi"] = { index = "rubi", nome = "Min. Rubi" },
	["esmeralda"] = { index = "esmeralda", nome = "Min. Esmeralda" },
	["safira"] = { index = "safira", nome = "Min. Safira" },
	["topazio"] = { index = "topazio", nome = "Min. Topazio" },
	["ametista"] = { index = "ametista", nome = "Min. Ametista" },
	["diamante2"] = { index = "diamante2", nome = "Diamante" },
	["ouro2"] = { index = "ouro2", nome = "Ouro" },
	["bronze2"] = { index = "bronze2", nome = "Bronze" },
	["ferro2"] = { index = "ferro2", nome = "Ferro" },
	["rubi2"] = { index = "rubi2", nome = "Rubi" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Esmeralda" },
	["safira2"] = { index = "safira2", nome = "Safira" },
	["topazio2"] = { index = "topazio2", nome = "Topazio" },
	["ametista2"] = { index = "ametista2", nome = "Ametista" },
	["ingresso"] = { index = "ingresso", nome = "Ingresso Eventos" },
	["radio"] = { index = "radio", nome = "Radio" },
	["serra"] = { index = "serra", nome = "Serra" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira" },
	["c4"] = { index = "c4", nome = "C-4" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["xerelto"] = { index = "xerelto", nome = "Xerelto" },
	["coumadin"] = { index = "coumadin", nome = "Coumadin" },
	["aneldecompromisso"] = { index = "aneldecompromisso", nome = "Anel de Compromisso" },
	["aneldecompromissodasam"] = { index = "aneldecompromissodasam", nome = "Anel de Compromisso da Sam" },
	["sugar"] = { index = "sugar", nome = "Açúcar" },
	["algodaodoce"] = { index = "algodaodoce", nome = "Algodão Doce" },
	["colardeperolas"] = { index = "colardeperolas", nome = "Colar de Pérolas" },
	["pulseiradeouro"] = { index = "pulseiradeouro", nome = "Pulseira de Ouro" },
	["chocolate"] = { index = "chocolate", nome = "Chocolate" },
	["pirulito"] = { index = "pirulito", nome = "Pirulito" },
	["buque"] = { index = "buque", nome = "Buquê de Flores" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a1", nome = "M4A1" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer MPX" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "ia2", nome = "IA2" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103" },
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9" },
	["wbody|WEAPON_SMG"] = { index = "mpx", nome = "MPX" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS-74U" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
	["wbody|WEAPON_PISTOL50"] = { index = "pistol50", nome = "PISTOL50" },
	["wbody|WEAPON_APPISTOL"] = { index = "appistol", nome = "APPISTOL" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-pistol50", nome = "M.PISTOL50" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-appistol", nome = "M.APPISTOL" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M.M1911" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.Five Seven" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "M.HK P7M10" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "M.M1922" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "M.Magnum 44" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a1", nome = "M.M4A1" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "M.MTAR-21" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "M.Sig Sauer MPX" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-shotgun", nome = "M.Shotgun" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-ia2", nome = "M.IA2" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "M.AK-103" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.Tec-9" },
	["wammo|WEAPON_SMG"] = { index = "m-mpx", nome = "M.MPX" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS-74U" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M.Thompson" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[2])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- USER VEHS [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- reskin
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reskin',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(vRPclient.getCustomization(source))		
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /bvida 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bvida")
AddEventHandler("bvida",function()
    local source = source
    vRPclient._setCustomization(source,vRPclient.getCustomization(source))
	TriggerEvent('dpn_tattoo:setPedServer',source)
	TriggerEvent('vrp_barber:setPedServer',source)
    vRP.removeCloak(source)
end)
---------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
----------------------------------------------------------------------------------------------------------------------------------------
local cooldown = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- /COBRAR
----------------------------------------------------------------------------------------------------------------------------------------
	local webhookpaypal = ""

	RegisterCommand('cobrar',function(source,args,rawCommand)
		local user_id = vRP.getUserId(source)
		local consulta = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(consulta)
		local resultado = json.decode(consulta) or 0
		local banco = vRP.getBankMoney(nuser_id)
		local identity =  vRP.getUserIdentity(user_id)
		local identityu = vRP.getUserIdentity(nuser_id)
		if cooldown < 1 then
			cooldown = 5
					if vRP.request(consulta,"Deseja pagar <b>$"..vRP.format(parseInt(args[1])).."</b> dolares para <b>"..identity.name.." "..identity.firstname.."</b>?",15) then	
						if banco >= parseInt(args[1]) then
							vRP.setBankMoney(nuser_id,parseInt(banco-args[1]))
							vRP.giveBankMoney(user_id,parseInt(args[1]))
							TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dolares</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
							SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COBROU]: $"..vRP.format(parseInt(args[1])).." \n[DO ID]: "..parseInt(nuser_id).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							local player = vRP.getUserSource(parseInt(args[2]))
							if player == nil then
								return
							else
								local identity = vRP.getUserIdentity(user_id)
								TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>R$"..vRP.format(parseInt(args[1])).." Reais</b> para sua conta.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","A pessoa negou.")	
					end
		else
			TriggerClientEvent("Notify",source,"negado","Espere 5 segundos")
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
		--TriggerClientEvent('carregar',nplayer,source)
		--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
		vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end

			--vRPclient._stopAnim(source,false)
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			--TriggerClientEvent('carregar',nplayer,source)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
		--TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
	end
end)
-- --------------------------------------------------------------
-- ------------------------ BEIJO -------------------------------
-- --------------------------------------------------------------
-- RegisterCommand("beijar",function(source,args,rawCommand)
--     local user_id = vRP.getUserId(source)
--     local nplayer = vRPclient.getNearestPlayer(source,2)
--     if nplayer then
--         local pedido = vRP.request(nplayer,"Deseja iniciar o beijo ?",10)
--         if pedido then
--             vRPclient.playAnim(source,true,{{"mp_ped_interaction","kisses_guy_a"}},false)    
--             vRPclient.playAnim(nplayer,true,{{"mp_ped_interaction","kisses_guy_b"}},false)
--         end
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-------------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	{ ['permissao'] = "bronze.permissao", ['nome'] = "BRONZE", ['payment'] = 3500 },
	{ ['permissao'] = "prata.permissao", ['nome'] = "PRATA", ['payment'] = 5000 },
	{ ['permissao'] = "ouro.permissao", ['nome'] = "OURO", ['payment'] = 8000 },
	{ ['permissao'] = "platina.permissao", ['nome'] = "PLATINA", ['payment'] = 12000 },

	{ ['permissao'] = "juiza.permissao", ['nome'] = "JUIZA", ['payment'] = 10000 },
	{ ['permissao'] = "news.permissao", ['nome'] = "News", ['payment'] = 2300 },

---- | Policia | ----
	{ ['permissao'] = "policiaI.permissao", ['nome'] = "POLICIA", ['payment'] = 4500 },
	{ ['permissao'] = "policiaII.permissao", ['nome'] = "POLICIA", ['payment'] = 5500 },
	{ ['permissao'] = "policiaIII.permissao", ['nome'] = "POLICIA", ['payment'] = 6000 },
	{ ['permissao'] = "policiaIIII.permissao", ['nome'] = "POLICIA", ['payment'] = 6500 },
	{ ['permissao'] = "policiaIIIII.permissao", ['nome'] = "POLICIA", ['payment'] = 7500 },
	{ ['permissao'] = "policiaIC.permissao", ['nome'] = "POLICIA", ['payment'] = 8000 },
	{ ['permissao'] = "policiaIMAJ.permissao", ['nome'] = "POLICIA", ['payment'] = 8500 },
	{ ['permissao'] = "policiaASS.permissao", ['nome'] = "POLICIA", ['payment'] = 9000 },
	{ ['permissao'] = "policiaICH.permissao", ['nome'] = "POLICIA", ['payment'] = 10000 },

---- | Paramedico | ----
    { ['permissao'] = "Estagiario.permissao", ['nome'] = "Hospital", ['payment'] = 2000 },
	{ ['permissao'] = "Enfermagem.permissao", ['nome'] = "Hospital", ['payment'] = 3000 },
	{ ['permissao'] = "Enfermeiro.permissao", ['nome'] = "Hospital", ['payment'] = 3500 },
	{ ['permissao'] = "Medico.permissao", ['nome'] = "Hospital", ['payment'] = 4000 },
	{ ['permissao'] = "Socorrista.permissao", ['nome'] = "Hospital", ['payment'] = 4500 },
	{ ['permissao'] = "Clinico.permissao", ['nome'] = "Hospital", ['payment'] = 5000 },
	{ ['permissao'] = "Cirurgiao.permissao", ['nome'] = "Hospital", ['payment'] = 5500 },
	{ ['permissao'] = "Gerente.permissao", ['nome'] = "Hospital", ['payment'] = 7000 },
	{ ['permissao'] = "Hospital.permissao", ['nome'] = "Hospital", ['payment'] = 9000 },
---- | Mecanico | ----
    { ['permissao'] = "aprendizmecanico.permissao", ['nome'] = "MECANICO", ['payment'] = 2000 },
	{ ['permissao'] = "mecanicosalario.permissao", ['nome'] = "MECANICO", ['payment'] = 3000 },
	{ ['permissao'] = "tunador.permissao", ['nome'] = "MECANICO", ['payment'] = 3500 },
	{ ['permissao'] = "gerentemec.permissao", ['nome'] = "MECANICO", ['payment'] = 5000 },
	{ ['permissao'] = "chefemec.permissao", ['nome'] = "MECANICO", ['payment'] = 6000 },
---------------------
	{ ['permissao'] = "burgershot.permissao", ['nome'] = "BURGERSHOT", ['payment'] = 2000 },
	{ ['permissao'] = "advogadosa.permissao", ['nome'] = "ADVOGADO", ['payment'] = 5000 }
}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"admin.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COR NA ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cor', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao')or vRP.hasPermission(user_id, 'mod.permissao') or vRP.hasPermission(user_id, 'platina.permissao') or vRP.hasPermission(user_id, 'ouro.permissao') or vRP.hasPermission(user_id, 'prata.permissao') then
        TriggerClientEvent('changeWeaponColor', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
  	local identitynu = vRP.getUserIdentity(nuser_id)
	--[[if nuser_id and args[1] and parseInt(args[2]) > 0 then
		for k,v in pairs(itemlist) do
			if args[1] == v.index then
				if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(k)*parseInt(args[2]) <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(args[2])) then
						vRP.giveInventoryItem(nuser_id,k,parseInt(args[2]))
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(args[2])).."x "..v.nome.."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(args[2])).."x "..v.nome.."</b>.",8000)
						SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(args[2])).." "..v.nome.." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end
				end
			end
		end]]
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local weapons = vRPclient.replaceWeapons(source,{})
        local tempog = math.random(2000,6000)
        Citizen.Wait(tempog)
        for k,v in pairs(weapons) do
            vRP.giveInventoryItem(user_id,"wbody|"..k,1)
            if v.ammo > 0 then
                vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
            end
        end
        Citizen.Wait(2000)
        TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local armour = vRPclient.getArmour(source)
        local tempog = math.random(2000,6000)
        Citizen.Wait(tempog)
		if armour == 100 then
			vRPclient.setArmour(source,0)
       		vRP.giveInventoryItem(user_id,"colete",1) 
			TriggerClientEvent("Notify",source,"sucesso","Você guardou seu Colete na mochila.")
        else
			TriggerClientEvent("Notify",source,"sucesso","Seu colete está danificado, não foi possível guardar.")
		end
        Citizen.Wait(2000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia > 0 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if k ~= "identidade" or k ~= "cartaodedebito" then
											if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
												vRP.giveInventoryItem(user_id,k,v.amount)
											end
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveInventoryItem(user_id,"dinheirosujo",nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"sucesso","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Saquear
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("policia.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,20000,"saqueando")
				SetTimeout(20000,function()
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if k ~= "identidade" or k ~= "cartaodedebito" then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
											table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
										end
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: "..1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveInventoryItem(user_id,"dinheirosujo",nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false
		if args[1] == "911" then
			players = vRP.getUsersByPermission("policia.permissao")
			especialidade = "policiais"
		elseif args[1] == "112" then
			players = vRP.getUsersByPermission("paramedico.permissao")
			especialidade = "paramédicos"
		elseif args[1] == "mec" then
			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "mecânicos"
		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("taxista.permissao")
			especialidade = "taxistas"
		elseif args[1] == "heli" then
			players = vRP.getUsersByPermission("pilotochefe.permissao")
			especialidade = "taxiaereo"
		elseif args[1] == "adv" then
			players = vRP.getUsersByPermission("advogado.permissao")
			if players[1] == nil then
				players = vRP.getUsersByPermission("juiza.permissao")	
				especialidade = "juizes"
			else
				especialidade = "advogados"
			end
		--[[	
		elseif args[1] == "juiz" then
			players = vRP.getUsersByPermission("juiza.permissao")	
			especialidade = "juizes"
		]]
		elseif args[1] == "css" then
			players = vRP.getUsersByPermission("conce.permissao")	
			especialidade = "vendedores"
		elseif args[1] == "jornal" then
			players = vRP.getUsersByPermission("news.permissao")	
			especialidade = "jornalistas"
		elseif args[1] == "adm" then
			players = vRP.getUsersByPermission("ticket.permissao")	
			especialidade = "Administradores"
		end
		local adm = ""
		if especialidade == "Administradores" then
			adm = "[ADM] "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		if #players == 0  and especialidade ~= "policiais" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"Central Mecânica",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatMe')
AddEventHandler('ChatMe',function(text)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('DisplayMe',-1,text,source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatRoll')
AddEventHandler('ChatRoll',function(text)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('DisplayRoll',-1,text,source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /card
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)

--[ MASCARA ]----------------------------------------------------------------------------------------------------------------------------

RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)
--[ OCULOS ]-----------------------------------------------------------------------------------------------------------------------------

RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)

--[ CHAPEU ]-----------------------------------------------------------------------------------------------------------------------------

RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("staff",function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatstaff.permissao"
		if vRP.hasPermission(user_id,permission) then
			local populacao = vRP.getUsersByPermission(permission)
			for l,w in pairs(populacao) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,140,0},string.sub(rawCommand,6))
						--TriggerClientEvent('chatMessage',-1,"[STAFF] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{255,140,0},rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS ON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('players',function(source,args,rawCommand)
	local onlinePlayers = GetNumPlayerIndices()
	TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Jogadores Online: "..onlinePlayers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'policia.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage',-1,"[911] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{65,130,255},rawCommand:sub(4))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MECANICO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'mecanico.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		--if user_id then
			TriggerClientEvent('chatMessage',-1,"[MEC] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{237, 153, 0},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LAWYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('law',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,"[Jurídico] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{150,75,0},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'paramedico.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage',-1,"[112] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{255,70,135},rawCommand:sub(4))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Concessionária
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('coc',function(source,args,rawCommand)
-- 	if args[1] then
-- 		local user_id = vRP.getUserId(source)
-- 		local identity = vRP.getUserIdentity(user_id)
-- 		if user_id then
-- 			TriggerClientEvent('chatMessage',-1,"[COC] "..identity.name.." "..identity.firstname,{105,89,205},rawCommand:sub(4))
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- tw
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tw',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,"[Twitter] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{0,206,206},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ILEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ilegal', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[Anônimo]", {000, 000, 000}, rawCommand:sub(7))
		SendWebhookMessage(log_ilegal,"```css\n[ILEGAL]\n[ID]"..user_id.."\n[DISSE]:"..rawCommand:sub(6).."```")
	end
end)
--[[
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORA RP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('frp', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[Fora RP] ".. GetPlayerName(source) .." ("..user_id..") ", {25, 102, 25}, rawCommand:sub(4))
		CancelEvent()
	end
end)
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- OLX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('olx', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[OLX] ".. GetPlayerName(source) .." ("..user_id..") ", {180, 0, 150}, rawCommand:sub(4))
		CancelEvent()
	end
end)