local cfg = module("cfg/inventory")

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucasa = ""
local webhookbaustatic = ""
local webhookbaustaticpolicia = ""
local webhookbauvagos = ""
local webhookbaugroove = ""
local webhookbauballas = ""
local webhookbaumafia = ""
local webhookbauserpentes = ""
local webhookbaumc = ""
local webhookbaucosanostra = ""
local webhookbaubratva = ""
local webhookbauflanela = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local itemlist = {
	["dinheiroespecie"] = { index = "dinheiroespecie", nome = "Dinheiro em Espécie", type = "usar" },
	["semi-identidade"] = { index = "semi-identidade", nome = "Identidade Sem Plástico", type = "usar" },
	["plastico"] = { index = "plastico", nome = "Plástico", type = "usar" },
	["insumos"] = { index = "insumos", nome = "Insumos Alimentícios", type = "usar" },
	["valefone"] = { index = "valefone", nome = "Vale Troca Número", type = "usar" },
	["valeplaca"] = { index = "valeplaca", nome = "Vale Troca Placa", type = "usar" },
	["valemansao"] = { index = "valemansao", nome = "Vale Mansão", type = "usar" },
	["laranja"] = { index = "laranja", nome = "Laranja", type = "usar" },
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta", type = "usar" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda", type = "usar" },
	["colete"] = { index = "colete", nome = "Colete", type = "usar" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo", type = "usar" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia", type = "usar" },
    ["receita-medica"] = { index = "receita-medica", nome = "Receita Médica", type = "usar" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite", type = "usar" },
	["relatorio"] = { index = "relatorio", nome = "Relatório", type = "usar" },
	["tora"] = { index = "tora", nome = "Tora de Madeira", type = "usar" },
	["cartaodedebito"] = { index = "cartaodedebito", nome = "Cartão de Débito", type = "usar" }, 
	["alianca"] = { index = "alianca", nome = "Aliança", type = "usar" },
	["maquininha"] = { index = "maquininha", nome = "Maquininha", type = "usar" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem", type = "usar" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex", type = "usar" },
	["alvejante"] = { index = "alvejante", nome = "Alvejante", type = "usar" },
	["borrifador"] = { index = "borrifador", nome = "Borrifador", type = "usar" },
	["caixa-vazia"] = { index = "caixa-vazia", nome = "Caixa Vazia", type = "usar" },
	["omeprazol"] = { index = "omeprazol", nome = "Omeprazol", type = "usar" },
	["dipirona"] = { index = "dipirona", nome = "Dipirona", type = "usar" },
	["gelol"] = { index = "gelol", nome = "Gelol", type = "usar" },
	["paracetamol"] = { index = "paracetamol", nome = "Paracetamol", type = "usar" },
	["decupramim"] = { index = "decupramim", nome = "Decupramim", type = "usar" },
	["buscopan"] = { index = "buscopan", nome = "Buscopan", type = "usar" },
	["novalgina"] = { index = "novalgina", nome = "Novalgina", type = "usar" },
	["alivium"] = { index = "alivium", nome = "Alivium", type = "usar" },
	["agua-oxigenada"] = { index = "agua-oxigenada", nome = "Agua-Oxigenada", type = "usar" },
	["nokusin"] = { index = "nokusin", nome = "Nokusin", type = "usar" },
	["sidelnafila"] = { index = "sidelnafila", nome = "Sidelnafila", type = "usar" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja", type = "usar" },
	["tequila"] = { index = "tequila", nome = "Tequila", type = "usar" },
	["vodka"] = { index = "vodka", nome = "Vodka", type = "usar" },
	["whisky"] = { index = "whisky", nome = "Whisky", type = "usar" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque", type = "usar" },
	["absinto"] = { index = "absinto", nome = "Absinto", type = "usar" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo", type = "usar" },
	["celular"] = { index = "celular", nome = "Celular", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["morfina"] = { index = "morfina", nome = "Morfina", type = "usar" },
	["placa"] = { index = "placa", nome = "Placa", type = "usar" },
	["algemas"] = { index = "algemas", nome = "Algemas", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["identidade"] = { index = "identidade", nome = "Identidade", type = "usar" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick", type = "usar" },
	["militec"] = { index = "militec", nome = "Militec-1", type = "usar" },
	["pneus"] = { index = "pneus", nome = "Pneus", type = "usar" },
	["rebite"] = { index = "rebite", nome = "Rebite", type = "usar" },
	["notebook"] = { index = "notebook", nome = "Notebook", type = "usar" },
	["roupas"] = { index = "roupas", nome = "Roupas", type = "usar" },
	["carnedecormorao"] = { index = "carnedecormorao", nome = "Carne de Cormorão", type = "usar" },
	["carnedecorvo"] = { index = "carnedecorvo", nome = "Carne de Corvo", type = "usar" },
	["carnedeaguia"] = { index = "carnedeaguia", nome = "Carne de Águia", type = "usar" },
	["carnedecervo"] = { index = "carnedecervo", nome = "Carne de Cervo", type = "usar" },
	["carnedecoelho"] = { index = "carnedecoelho", nome = "Carne de Coelho", type = "usar" },
	["carnedecoyote"] = { index = "carnedecoyote", nome = "Carne de Coyote", type = "usar" },
	["carnedelobo"] = { index = "carnedelobo", nome = "Carne de Lobo", type = "usar" },
	["carnedepuma"] = { index = "carnedepuma", nome = "Carne de Puma", type = "usar" },
	["carnedejavali"] = { index = "carnedejavali", nome = "Carne de Javali", type = "usar" },
	["isca"] = { index = "isca", nome = "Isca", type = "usar" },
	["dourado"] = { index = "dourado", nome = "Dourado", type = "usar" },
	["corvina"] = { index = "corvina", nome = "Corvina", type = "usar" },
	["salmao"] = { index = "salmao", nome = "Salmão", type = "usar" },
	["pacu"] = { index = "pacu", nome = "Pacu", type = "usar" },
	["pintado"] = { index = "pintado", nome = "Pintado", type = "usar" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu", type = "usar" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia", type = "usar" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré", type = "usar" },
	["lambari"] = { index = "lambari", nome = "Lambari", type = "usar" },
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar" },
	["mochila"] = { index = "mochila", nome = "Mochila", type = "usar" },
	["maconha"] = { index = "maconha", nome = "Maconha", type = "usar" },
	["adubo"] = { index = "adubo", nome = "Adubo", type = "usar" },
	["fertilizante"] = { index = "fertilizante", nome = "Fertilizante", type = "usar" },
	["capsula"] = { index = "capsula", nome = "Cápsula", type = "usar" },
	["polvora"] = { index = "polvora", nome = "Pólvora", type = "usar" },
	["orgao"] = { index = "orgao", nome = "Órgão", type = "usar" },
	["etiqueta"] = { index = "etiqueta", nome = "Etiqueta", type = "usar" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive", type = "usar" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado", type = "usar" },
	["pulseiraroubada"] = { index = "pulseiraroubada", nome = "Pulseira Roubada", type = "usar" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado", type = "usar" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado", type = "usar" },
	["brincoroubado"] = { index = "brincoroubado", nome = "Brinco Roubado", type = "usar" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada", type = "usar" },
	["cartaoclonado"] = { index = "cartaoclonado", nome = "Cartão Clonado", type = "usar" },
	["heroin"] = { index = "heroin", nome = "Heroina", type = "usar" },
	["eter"] = { index = "eter", nome = "Eter", type = "usar" },
	["cloroformio"] = { index = "cloroformio", nome = "Cloroformio", type = "usar" },
	["cartaodecredito"] = { index = "cartaodecredito", nome = "Cartão de Crédito", type = "usar" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado", type = "usar" },
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado", type = "usar" },
	["folhadecoca"] = { index = "folhadecoca", nome = "Folha de Coca", type = "usar" },
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Coca", type = "usar" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína", type = "usar" },
	["fungo"] = { index = "fungo", nome = "Fungo", type = "usar" },
    ["dietilamina"] = { index = "dietilamina", nome = "Dietilamina", type = "usar" },
    ["lsd"] = { index = "lsd", nome = "LSD", type = "usar" },
	["acidobateria"] = { index = "acidobateria", nome = "Ácido de Bateria", type = "usar" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina", type = "usar" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina", type = "usar" },
	["armacaodearma"] = { index = "armacaodearma", nome = "Armação de Arma", type = "usar" },
	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma", type = "usar" },
	["logsinvasao"] = { index = "logsinvasao", nome = "L. Inv. Banco", type = "usar" },
	["keysinvasao"] = { index = "keysinvasao", nome = "K. Inv. Banco", type = "usar" },
	["pendriveinformacoes"] = { index = "pendriveinformacoes", nome = "P. Info.", type = "usar" },
	["acessodeepweb"] = { index = "acessodeepweb", nome = "P. DeepWeb", type = "usar" },
	["diamante"] = { index = "diamante", nome = "Min. Diamante", type = "usar" },
	["ouro"] = { index = "ouro", nome = "Min. Ouro", type = "usar" },
	["bronze"] = { index = "bronze", nome = "Min. Bronze", type = "usar" },
	["malote"] = { index = "malote", nome = "Malote", type = "usar" },
	["cedula"] = { index = "cedula", nome = "Cédula", type = "usar" },
	["raceticket"] = { index = "raceticket", nome = "Race Ticket", type = "usar" },
	--[ Drinks ]-------------------------------------------------------------------------------------------------------
	
	["agua"] = { index = "agua", nome = "Água", type = "usar" },
	["leite"] = { index = "leite", nome = "Leite", type = "usar" },
	["cafe"] = { index = "cafe", nome = "Café", type = "usar" },
	["cafecleite"] = { index = "cafecleite", nome = "Café com Leite", type = "usar" },
	["cafeexpresso"] = { index = "cafeexpresso", nome = "Café Expresso", type = "usar" },
	["capuccino"] = { index = "capuccino", nome = "Capuccino", type = "usar" },
	["frappuccino"] = { index = "frappuccino", nome = "Frapuccino", type = "usar" },
	["cha"] = { index = "cha", nome = "Chá", type = "usar" },
	["icecha"] = { index = "icecha", nome = "Chá Gelado", type = "usar" },
	["sprunk"] = { index = "sprunk", nome = "Sprunk", type = "usar" },
	["cola"] = { index = "cola", nome = "Cola", type = "usar" },

	--[ Vinho ]-------------------------------------------------------------------------------------------------------
	
	["uva"] = { index = "uva", nome = "Uva", type = "usar" },
	["uvafermentada"] = { index = "uvafermentada", nome = "Uva Fermentada", type = "usar" },
	["vinhobranco"] = { index = "vinhobranco", nome = "Vinho Branco", type = "usar" },
	["vinhorose"] = { index = "vinhorose", nome = "Vinho Rose", type = "usar" },
	["vinhotinto"] = { index = "vinhotinto", nome = "Vinho Tinto", type = "usar" },

	--[ FastFoods ]----------------------------------------------------------------------------------------------------
	
	["sanduiche"] = { index = "sanduiche", nome = "Sanduíche", type = "usar" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha", type = "usar" },
	["hotdog"] = { index = "hotdog", nome = "HotDog", type = "usar" },
	["xburguer"] = { index = "xburguer", nome = "xBurguer", type = "usar" },
	["chips"] = { index = "chips", nome = "Batata Chips", type = "usar" },
	["batataf"] = { index = "batataf", nome = "Batata Frita", type = "usar" },
	["pizza"] = { index = "pizza", nome = "Pedaço de Pizza", type = "usar" },
	["frango"] = { index = "frango", nome = "Frango Frito", type = "usar" },
	["bcereal"] = { index = "bcereal", nome = "Barra de Cereal", type = "usar" },
	["bchocolate"] = { index = "bchocolate", nome = "Barra de Chocolate", type = "usar" },
	["taco"] = { index = "taco", nome = "Taco", type = "usar" },

	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Tecidos ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["tecido"] = { index = "tecido", nome = "Tecido", type = "usar" },
	["tecidor"] = { index = "tecidor", nome = "Tecido Reforçado", type = "usar" },
	["agulha"] = { index = "agulha", nome = "Agulha", type = "usar" },
	

	["ferro"] = { index = "ferro", nome = "Min. Ferro", type = "usar" },
	["rubi"] = { index = "rubi", nome = "Min. Rubi", type = "usar" },
	["esmeralda"] = { index = "esmeralda", nome = "Min. Esmeralda", type = "usar" },
	["safira"] = { index = "safira", nome = "Min. Safira", type = "usar" },
	["topazio"] = { index = "topazio", nome = "Min. Topazio", type = "usar" },
	["ametista"] = { index = "ametista", nome = "Min. Ametista", type = "usar" },
	["diamante2"] = { index = "diamante2", nome = "Diamante", type = "usar" },
	["ouro2"] = { index = "ouro2", nome = "Ouro", type = "usar" },
	["bronze2"] = { index = "bronze2", nome = "Bronze", type = "usar" },
	["ferro2"] = { index = "ferro2", nome = "Ferro", type = "usar" },
	["radio"] = { index = "radio", nome = "Radio", type = "usar" },
	["c4"] = { index = "c4", nome = "C4", type = "usar" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira", type = "usar" },
	["serra"] = { index = "serra", nome = "Serra", type = "usar" },
	["rubi2"] = { index = "rubi2", nome = "Rubi", type = "usar" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Esmeralda", type = "usar" },
	["safira2"] = { index = "safira2", nome = "Safira", type = "usar" },
	["topazio2"] = { index = "topazio2", nome = "Topazio", type = "usar" },
	["ametista2"] = { index = "ametista2", nome = "Ametista", type = "usar" },
	["graos"] = { index = "graos", nome = "Graos", type = "usar" },
	["graosimpuros"] = { index = "graosimpuros", nome = "Graos Impuros", type = "usar" },
	["keycard"] = { index = "keycard", nome = "Keycard", type = "usar" },
	["xerelto"] = { index = "xerelto", nome = "Xerelto", type = "usar" },
	["coumadin"] = { index = "coumadin", nome = "Coumadin", type = "usar" },
	["aneldecompromisso"] = { index = "aneldecompromisso", nome = "Anel de Compromisso", type = "usar" },
	["aneldecompromissodasam"] = { index = "aneldecompromissodasam", nome = "Anel de Compromisso da Sam", type = "usar" },
	["sugar"] = { index = "sugar", nome = "Açúcar", type = "usar" },
	["algodaodoce"] = { index = "algodaodoce", nome = "Algodão Doce", type = "usar" },
	["colardeperolas"] = { index = "colardeperolas", nome = "Colar de Pérolas", type = "usar" },
	["pulseiradeouro"] = { index = "pulseiradeouro", nome = "Pulseira de Ouro", type = "usar" },
	["chocolate"] = { index = "chocolate", nome = "Chocolate", type = "usar" },
	["pirulito"] = { index = "pirulito", nome = "Pirulito", type = "usar" },
	["buque"] = { index = "buque", nome = "Buquê de Flores", type = "usar" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês", type = "equipar" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra", type = "equipar" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven", type = "equipar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10", type = "equipar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922", type = "equipar" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44", type = "equipar" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357", type = "equipar" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22", type = "equipar" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador", type = "equipar" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas", type = "equipar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a1", nome = "M4A1", type = "equipar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21", type = "equipar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer MPX", type = "equipar" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "ia2", nome = "IA2", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103", type = "equipar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina", type = "equipar" },	
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson", type = "equipar" },		
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS", type = "equipar" },
	["wbody|WEAPON_SMG"] = { index = "mpx", nome = "MPX", type = "equipar" }, -- "WEAPON_PISTOL50","WEAPON_APPISTOL",
	["wbody|WEAPON_PISTOL50"] = { index = "pistol50", nome = "PISTOL50", type = "equipar" },
	["wbody|WEAPON_APPISTOL"] = { index = "appistol", nome = "APPISTOL", type = "equipar" },
	["wammo|WEAPON_PISTOL50"] = { index = "m-pistol50", nome = "M.PISTOL50", type = "recarregar" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-appistol", nome = "M.APPISTOL", type = "recarregar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M.M1911", type = "recarregar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "M.HK P7M10", type = "recarregar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "M.M1922", type = "recarregar" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "M.Magnum 44", type = "recarregar" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.Magnum 357", type = "recarregar" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22", type = "recarregar" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador", type = "recarregar" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas", type = "recarregar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor", type = "recarregar" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.Uzi", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a1", nome = "M.M4A1", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "M.MTAR-21", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "M.Sig Sauer MPX", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-shotgun", nome = "M.Shotgun", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-ia2", nome = "M.IA2", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "M.AK-103", type = "recarregar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M.Thompson", type = "recarregar" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.Tec-9", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS", type = "recarregar" },
	["wammo|WEAPON_SMG"] = { index = "m-mpx", nome = "M.MPX", type = "recarregar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível", type = "recarregar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

local maxItens = {
}

function vRP.giveInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(user_id)
    local amount = parseInt(amount)
    local data = vRP.getInventory(user_id)
    if data and amount > 0 then
        local entry = data[idname]
        if entry then
            entry.amount = entry.amount + amount
        else
            data[idname] = { amount = amount }
        end

        if maxItens[idname] then
            if data[idname].amount > maxItens[idname] then
                data[idname].amount = maxItens[idname]
            end
        end
        TriggerClientEvent("itensNotify",source,"sucesso",""..amount.." "..idname.."",idname)
    end
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(user_id)
    local amount = parseInt(amount)
    local data = vRP.getInventory(user_id)
    if data and amount > 0 then
        local entry = data[idname]
        if entry and entry.amount >= amount then
            entry.amount = entry.amount - amount

            if entry.amount <= 0 then
                data[idname] = nil
            end
            
            TriggerClientEvent("itensNotify",source,"negado",""..amount.." "..idname.."",idname)
            return true
        end
    end
    return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        if not vRP.hasPermission(user_id,"mochila.permissao") then
            vRP.setExp(user_id,"physical","strength",20)
        end
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local chests = {}
local function build_itemlist_menu(name,items,cb)
	local menu = { name = name }
	local kitems = {}

	local choose = function(player,choice)
		local idname = kitems[choice]
		if idname then
			cb(idname)
		end
	end

	for k,v in pairs(items) do 
		local name,weight = vRP.getItemDefinition(k)
		if name then
			kitems[name] = k
			menu[name] = { choose,"<text01>Quantidade:</text01> <text02>"..v.amount.."</text02><text01>Peso:</text01> <text02>"..string.format("%.2f",weight).."kg</text02>" }
		end
	end

	return menu
end

function vRP.openChest(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					if parseInt(amount) > 0 and parseInt(amount) <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*parseInt(amount)
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,parseInt(amount))
								if name == "static:1" then
									SendWebhookMessage(webhookbaustaticpolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Policia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<@&628630606649098276>")
								elseif name == "static:2" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaumc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:3" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Marabunta "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:4" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:5" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:6" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:7" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaumafia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:8" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaubratva,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:9" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:10" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauflanela,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:11" then
									-- Colocar depois
								elseif name == "static:12" then
									--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Corleone "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:13" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:14" then
									--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Concessionaria "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								elseif name == "static:15" then
									SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end
							citem.amount = citem.amount - parseInt(amount)

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.",8000)
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					if string.match(idname,"identidade") then
						TriggerClientEvent("Notify",source,"importante","Não pode guardar a <b>Identidade</b> em veículos.",8000)
						return
					end

					local amount = vRP.prompt(source,"Quantidade:","")
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*parseInt(amount)
					if new_weight <= max_weight then
						if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,idname,parseInt(amount)) then
							
							if name == "static:1" then
								SendWebhookMessage(webhookbaustaticpolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Policia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:2" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaumc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:3" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Marabunta "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:4" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Ballas "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:5" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Vagos "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:6" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Families "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:7" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaumafia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Mafia "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:8" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaubratva,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Bratva "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:9" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Motoclub "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:10" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauflanela,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Flanela "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:11" then
								-- Colocar depois
							elseif name == "static:12" then
								--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Corleone "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:13" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Serpentes "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:14" then
								--SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Concessionaria "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif name == "static:15" then
								SendWebhookMessage(webhookbaustatic,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: Cosanostra "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + parseInt(amount)
							else
								chest.items[idname] = { amount = parseInt(amount) }
							end

							if cb_in then
								cb_in(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.",8000)
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","Está sendo utilizado no momento.",8000)
			end
		end
	end
end

local function build_client_static_chests(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.static_chests) do
			local mtype,x,y,z = table.unpack(v)
			local schest = cfg.static_chest_types[mtype]

			if schest then
				local function schest_enter(source)
					local user_id = vRP.getUserId(source)
					if user_id and vRP.hasPermissions(user_id,schest.permissions or {}) then
						vRP.openChest(source,"static:"..k,schest.weight or 0)
					end
				end

				local function schest_leave(source)
					vRP.closeMenu(source)
				end

				vRP.setArea(source,"vRP:static_chest:"..k,x,y,z,1,1,schest_enter,schest_leave)
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_static_chests(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	["blista"] = { ['name'] = "Blista", ['price'] = 60000, ['tipo'] = "carros" },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 40000, ['tipo'] = "carros" },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 50000, ['tipo'] = "carros" },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 50000, ['tipo'] = "carros" },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 60000, ['tipo'] = "carros" },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 200000, ['tipo'] = "carros" },
	["panto"] = { ['name'] = "Panto", ['price'] = 8000, ['tipo'] = "carros" },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 1000, ['tipo'] = "carros" },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 10000, ['tipo'] = "carros" },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 130000, ['tipo'] = "carros" },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 80000, ['tipo'] = "carros" },
	["f620"] = { ['name'] = "F620", ['price'] = 55000, ['tipo'] = "carros" },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "carros" },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 160000, ['tipo'] = "carros" },
	["jackal"] = { ['name'] = "Jackal", ['price'] = 60000, ['tipo'] = "carros" },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 60000, ['tipo'] = "carros" },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 80000, ['tipo'] = "carros" },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 50000, ['tipo'] = "carros" },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 60000, ['tipo'] = "carros" },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "carros" },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 170000, ['tipo'] = "carros" },
	["zion"] = { ['name'] = "Zion", ['price'] = 50000, ['tipo'] = "carros" },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 60000, ['tipo'] = "carros" },
	["blade"] = { ['name'] = "Blade", ['price'] = 110000, ['tipo'] = "carros" },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 130000, ['tipo'] = "carros" },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 260000, ['tipo'] = "carros" },
	["primo"] = { ['name'] = "Primo", ['price'] = 130000, ['tipo'] = "carros" },
	["chino"] = { ['name'] = "Chino", ['price'] = 100000, ['tipo'] = "carros" },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 195000, ['tipo'] = "carros" },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 150000, ['tipo'] = "carros" },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "carros" },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "carros" },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 165000, ['tipo'] = "carros" },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "carros" },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "carros" },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "carros" },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "carros" },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "carros" },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "carros" },
	["picador"] = { ['name'] = "Picador", ['price'] = 150000, ['tipo'] = "carros" },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 150000, ['tipo'] = "carros" },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 260000, ['tipo'] = "carros" },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 150000, ['tipo'] = "carros" },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 180000, ['tipo'] = "carros" },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 230000, ['tipo'] = "carros" },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "carros" },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "carros" },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 170000, ['tipo'] = "carros" },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 170000, ['tipo'] = "carros" },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 150000, ['tipo'] = "carros" },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 250000, ['tipo'] = "carros" },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "carros" },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 220000, ['tipo'] = "carros" },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 220000, ['tipo'] = "carros" },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "carros" },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "carros" },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 190000, ['tipo'] = "carros" },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "carros" },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "carros" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "carros" },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "carros" },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 300000, ['tipo'] = "carros" },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 200000, ['tipo'] = "carros" },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 220000, ['tipo'] = "carros" },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "carros" },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "carros" },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "carros" },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "carros" },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 370000, ['tipo'] = "carros" },
	["baller"] = { ['name'] = "Baller", ['price'] = 150000, ['tipo'] = "carros" },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 160000, ['tipo'] = "carros" },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 175000, ['tipo'] = "carros" },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 185000, ['tipo'] = "carros" },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 270000, ['tipo'] = "carros" },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 280000, ['tipo'] = "carros" },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 130000, ['tipo'] = "carros" },
	["contender"] = { ['name'] = "Contender", ['price'] = 300000, ['tipo'] = "carros" },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 210000, ['tipo'] = "carros" },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 240000, ['tipo'] = "carros" },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "carros" },
	["granger"] = { ['name'] = "Granger", ['price'] = 345000, ['tipo'] = "carros" },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "carros" },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 110000, ['tipo'] = "carros" },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 110000, ['tipo'] = "carros" },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 150000, ['tipo'] = "carros" },
	["xls"] = { ['name'] = "Xls", ['price'] = 150000, ['tipo'] = "carros" },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 350000, ['tipo'] = "carros" },
	["asea"] = { ['name'] = "Asea", ['price'] = 55000, ['tipo'] = "carros" },
	["asterope"] = { ['name'] = "Asterope", ['price'] = 65000, ['tipo'] = "carros" },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 400000, ['tipo'] = "carros" },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 280000, ['tipo'] = "carros" },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 400000, ['tipo'] = "carros" },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 105000, ['tipo'] = "carros" },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 90000, ['tipo'] = "carros" },
	["surge"] = { ['name'] = "Surge", ['price'] = 110000, ['tipo'] = "carros" },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "carros" },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "carros" },
	["washington"] = { ['name'] = "Washington", ['price'] = 130000, ['tipo'] = "carros" },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 230000, ['tipo'] = "carros" },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 300000, ['tipo'] = "carros" },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 290000, ['tipo'] = "carros" },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "carros" },
	["blista3"] = { ['name'] = "Blista3", ['price'] = 80000, ['tipo'] = "carros" },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 300000, ['tipo'] = "carros" },
	["buffalo2"] = { ['name'] = "Buffalo2", ['price'] = 300000, ['tipo'] = "carros" },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "carros" },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 290000, ['tipo'] = "carros" },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 250000, ['tipo'] = "carros" },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 290000, ['tipo'] = "carros" },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 300000, ['tipo'] = "carros" },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 250000, ['tipo'] = "carros" },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 350000, ['tipo'] = "carros" },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 355000, ['tipo'] = "carros" },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 255000, ['tipo'] = "carros" },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 290000, ['tipo'] = "carros" },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "carros" },
	["futo"] = { ['name'] = "Futo", ['price'] = 170000, ['tipo'] = "carros" },
	["jester"] = { ['name'] = "Jester", ['price'] = 150000, ['tipo'] = "carros" },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 210000, ['tipo'] = "carros" },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 330000, ['tipo'] = "carros" },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 330000, ['tipo'] = "carros" },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 330000, ['tipo'] = "carros" },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 290000, ['tipo'] = "carros" },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 290000, ['tipo'] = "carros" },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "carros" },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 500000, ['tipo'] = "carros" },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 150000, ['tipo'] = "carros" },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 240000, ['tipo'] = "carros" },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 250000, ['tipo'] = "carros" },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 300000, ['tipo'] = "carros" },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 370000, ['tipo'] = "carros" },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 275000, ['tipo'] = "carros" },
	["schafter2"] = { ['name'] = "schafter2", ['price'] = 45000, ['tipo'] = "carros" },
	["schafter4"] = { ['name'] = "Schafter4", ['price'] = 420000, ['tipo'] = "carros" },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 275000, ['tipo'] = "carros" },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 170000, ['tipo'] = "carros" },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 230000, ['tipo'] = "carros" },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 370000, ['tipo'] = "carros" },
	["specter"] = { ['name'] = "Specter", ['price'] = 320000, ['tipo'] = "carros" },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 355000, ['tipo'] = "carros" },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "carros" },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 210000, ['tipo'] = "carros" },
	["surano"] = { ['name'] = "Surano", ['price'] = 310000, ['tipo'] = "carros" },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 200000, ['tipo'] = "carros" },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 170000, ['tipo'] = "carros" },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 380000, ['tipo'] = "carros" },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "carros" },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 390000, ['tipo'] = "carros" },
	["casco"] = { ['name'] = "Casco", ['price'] = 355000, ['tipo'] = "carros" },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 425000, ['tipo'] = "carros" },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 285000, ['tipo'] = "carros" },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "carros" },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 250000, ['tipo'] = "carros" },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 250000, ['tipo'] = "carros" },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 220000, ['tipo'] = "carros" },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 300000, ['tipo'] = "carros" },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "carros" },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 260000, ['tipo'] = "carros" },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "carros" },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 250000, ['tipo'] = "carros" },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 220000, ['tipo'] = "carros" },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 150000, ['tipo'] = "carros" },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 220000, ['tipo'] = "carros" },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "carros" },
	["torero"] = { ['name'] = "Torero", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 150000, ['tipo'] = "carros" },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 250000, ['tipo'] = "carros" },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 250000, ['tipo'] = "carros" },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 400000, ['tipo'] = "carros" },
	["adder"] = { ['name'] = "Adder", ['price'] = 620000, ['tipo'] = "carros" },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "carros" },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 370000, ['tipo'] = "carros" },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 400000, ['tipo'] = "carros" },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "carros" },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 460000, ['tipo'] = "carros" },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 520000, ['tipo'] = "carros" },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 495000, ['tipo'] = "carros" },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 470000, ['tipo'] = "carros" },
	["nero"] = { ['name'] = "Nero", ['price'] = 450000, ['tipo'] = "carros" },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 480000, ['tipo'] = "carros" },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 460000, ['tipo'] = "carros" },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 480000, ['tipo'] = "carros" },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 530000, ['tipo'] = "carros" },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 620000, ['tipo'] = "carros" },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 495000, ['tipo'] = "carros" },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 450000, ['tipo'] = "carros" },
	["t20"] = { ['name'] = "T20", ['price'] = 670000, ['tipo'] = "carros" },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 600000, ['tipo'] = "carros" },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 620000, ['tipo'] = "carros" },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 620000, ['tipo'] = "carros" },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 620000, ['tipo'] = "carros" },
	["visione"] = { ['name'] = "Visione", ['price'] = 690000, ['tipo'] = "carros" },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "carros" },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 920000, ['tipo'] = "carros" },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 180000, ['tipo'] = "carros" },
	["bison"] = { ['name'] = "Bison", ['price'] = 220000, ['tipo'] = "carros" },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 180000, ['tipo'] = "carros" },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "import" },
	["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["mule4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["rallytruck"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "carros" },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "carros" },
	["pony"] = { ['name'] = "Pony", ['price'] = 260000, ['tipo'] = "carros" },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo"] = { ['name'] = "Rumpo", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 350000, ['tipo'] = "carros" },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 55000, ['tipo'] = "carros" },
	["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "carros" },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 110000, ['tipo'] = "carros" },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 130000, ['tipo'] = "carros" },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 90000, ['tipo'] = "carros" },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 250000, ['tipo'] = "carros" },
	["radi"] = { ['name'] = "Radi", ['price'] = 110000, ['tipo'] = "carros" },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 110000, ['tipo'] = "carros" },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 690000, ['tipo'] = "carros" },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 550000, ['tipo'] = "carros" },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 170000, ['tipo'] = "carros" },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 300000, ['tipo'] = "carros" },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 345000, ['tipo'] = "carros" },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 370000, ['tipo'] = "carros" },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 320000, ['tipo'] = "carros" },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 160000, ['tipo'] = "carros" },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 320000, ['tipo'] = "carros" },
	["stromberg"] = { ['name'] = "stromberg", ['price'] = 77000, ['tipo'] = "carros" },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 230000, ['tipo'] = "carros" },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 230000, ['tipo'] = "carros" },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 370000, ['tipo'] = "carros" },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "carros" },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 620000, ['tipo'] = "carros" },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 195000, ['tipo'] = "carros" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 520000, ['tipo'] = "carros" },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 540000, ['tipo'] = "carros" },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 460000, ['tipo'] = "carros" },
	["neon"] = { ['name'] = "Neon", ['price'] = 370000, ['tipo'] = "carros" },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 920000, ['tipo'] = "carros" },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 600000, ['tipo'] = "carros" },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 610000, ['tipo'] = "carros" },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 680000, ['tipo'] = "carros" },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 630000, ['tipo'] = "carros" },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "carros" },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 1030000, ['tipo'] = "carros" },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 550000, ['tipo'] = "carros" },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 250000, ['tipo'] = "carros" },
	["clique"] = { ['name'] = "Clique", ['price'] = 360000, ['tipo'] = "carros" },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 920000, ['tipo'] = "carros" },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 370000, ['tipo'] = "carros" },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 320000, ['tipo'] = "carros" },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 800000, ['tipo'] = "carros" },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 690000, ['tipo'] = "carros" },
	["toros"] = { ['name'] = "Toros", ['price'] = 600000, ['tipo'] = "carros" },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 320000, ['tipo'] = "carros" },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "carros" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 350000, ['tipo'] = "carros" },
	["fugitive"] = { ['name'] = "Fugitive", ['price'] = 50000, ['tipo'] = "carros" },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 70000, ['tipo'] = "carros" },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 60000, ['tipo'] = "carros" },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 700000, ['tipo'] = "carros" },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "carros" },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 370000, ['tipo'] = "carros" },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 250000, ['tipo'] = "carros" },
	["premier"] = { ['name'] = "Premier", ['price'] = 35000, ['tipo'] = "carros" },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 300000, ['tipo'] = "carros" },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 700000, ['tipo'] = "carros" },
	["z190"] = { ['name'] = "Z190", ['price'] = 350000, ['tipo'] = "carros" },
	["camper"] = { ['name'] = "camper", ['price'] = 60000, ['tipo'] = "carros" },
	["journey"] = { ['name'] = "journey", ['price'] = 40000, ['tipo'] = "carros" },
	["ratloader2"] = { ['name'] = "ratloader2", ['price'] = 18000, ['tipo'] = "carros" },
	["regina"] = { ['name'] = "regina", ['price'] = 22500, ['tipo'] = "carros" },
	["revolter"] = { ['name'] = "revolter", ['price'] = 200000, ['tipo'] = "carros" },
	["savestra"] = { ['name'] = "savestra", ['price'] = 85000, ['tipo'] = "carros" },
	["viseris"] = { ['name'] = "viseris", ['price'] = 200000, ['tipo'] = "carros" },

	--MOTOS
	
	["akuma"] = { ['name'] = "Akuma", ['price'] = 500000, ['tipo'] = "motos" },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos" },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos" },
	["bati"] = { ['name'] = "Bati", ['price'] = 370000, ['tipo'] = "motos" },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 300000, ['tipo'] = "motos" },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 320000, ['tipo'] = "motos" },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 370000, ['tipo'] = "motos" },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 345000, ['tipo'] = "motos" },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 310000, ['tipo'] = "motos" },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 240000, ['tipo'] = "motos" },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 460000, ['tipo'] = "motos" },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 430000, ['tipo'] = "motos" },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 460000, ['tipo'] = "motos" },
	["double"] = { ['name'] = "Double", ['price'] = 370000, ['tipo'] = "motos" },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 195000, ['tipo'] = "motos" },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 320000, ['tipo'] = "motos" },
	["faggio"] = { ['name'] = "Faggio", ['price'] = 4000, ['tipo'] = "motos" },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 5000, ['tipo'] = "motos" },
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 5000, ['tipo'] = "motos" },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 390000, ['tipo'] = "motos" },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 390000, ['tipo'] = "motos" },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 345000, ['tipo'] = "motos" },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 380000, ['tipo'] = "motos" },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 550000, ['tipo'] = "motos" },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos" },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 250000, ['tipo'] = "motos" },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 380000, ['tipo'] = "motos" },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 355000, ['tipo'] = "motos" },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 345000, ['tipo'] = "motos" },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 415000, ['tipo'] = "motos" },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 230000, ['tipo'] = "motos" },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 345000, ['tipo'] = "motos" },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 185000, ['tipo'] = "motos" },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 185000, ['tipo'] = "motos" },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 285000, ['tipo'] = "motos" },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos" },
	["vader"] = { ['name'] = "Vader", ['price'] = 345000, ['tipo'] = "motos" },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos" },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 375000, ['tipo'] = "motos" },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 290000, ['tipo'] = "motos" },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 290000, ['tipo'] = "motos" },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 300000, ['tipo'] = "motos" },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "motos" },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos" },

	--TRABALHO
	["youga2"] = { ['name'] = "Youga2", ['price'] = 1000, ['tipo'] = "work" },
	["felon2"] = { ['name'] = "Felon2", ['price'] = 1000, ['tipo'] = "work" },
	["pbus"] = { ['name'] = "PBus", ['price'] = 1000, ['tipo'] = "work" },
	["policiacharger2018"] = { ['name'] = "Dodge Charger 2018", ['price'] = 1000, ['tipo'] = "work" },
	["policiamustanggt"] = { ['name'] = "Mustang GT", ['price'] = 1000, ['tipo'] = "work" },
	["policiacapricesid"] = { ['name'] = "GM Caprice SID", ['price'] = 1000, ['tipo'] = "work" },
	["policiaschaftersid"] = { ['name'] = "GM Schafter SID", ['price'] = 1000, ['tipo'] = "work" },
	["policiasilverado"] = { ['name'] = "Chevrolet Silverado", ['price'] = 1000, ['tipo'] = "work" },
	["policiatahoe"] = { ['name'] = "Chevrolet Tahoe", ['price'] = 1000, ['tipo'] = "work" },
	["policiaexplorer"] = { ['name'] = "Ford Explorer", ['price'] = 1000, ['tipo'] = "work" },
	["policiataurus"] = { ['name'] = "Ford Taurus", ['price'] = 1000, ['tipo'] = "work" },
	["policiavictoria"] = { ['name'] = "Ford Victoria", ['price'] = 1000, ['tipo'] = "work" },
	["policiabmwr1200"] = { ['name'] = "BMW R1200", ['price'] = 1000, ['tipo'] = "work" },
	["policiaheli"] = { ['name'] = "Policia Helicóptero", ['price'] = 1000, ['tipo'] = "work" },
	["fbi2"] = { ['name'] = "Granger SOG", ['price'] = 1000, ['tipo'] = "work" },
	["policeb"] = { ['name'] = "Harley Davidson", ['price'] = 1000, ['tipo'] = "work" },
	["riot"] = { ['name'] = "Blindado", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicoambu"] = { ['name'] = "Ambulância", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicocharger2014"] = { ['name'] = "Dodge Charger 2014", ['price'] = 1000, ['tipo'] = "work" },
	["paramedicoheli"] = { ['name'] = "Paramédico Helicóptero", ['price'] = 1000, ['tipo'] = "work" },
	["20blazer2"] = { ['name'] = "Trail Blazer 2021 Policia", ['price'] = 1000, ['tipo'] = "work" },
	["mercedespolicia"] = { ['name'] = "Mercedes-AMG C63 Policia", ['price'] = 1000, ['tipo'] = "work" },
	["jeeppolicia"] = { ['name'] = "Jeep Policia", ['price'] = 1000, ['tipo'] = "work" },
	["chevypolicia"] = { ['name'] = "Chevrolet Chevy Policia", ['price'] = 1000, ['tipo'] = "work" },
	["xre2019"] = { ['name'] = "XRE Policia", ['price'] = 1000, ['tipo'] = "work" },
	["tug"] = { ['name'] = "Barco de Pescador", ['price'] = 1000, ['tipo'] = "work" },
	["priustaxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work" },
	["pounder2"] = { ['name'] = "Caminhao", ['price'] = 1000, ['tipo'] = "work" }, 
	["f450towtruk"] = { ['name'] = "F450 Da Mecânica", ['price'] = 1000, ['tipo'] = "work" }, 
	["pranger"] = { ['name'] = "Pranger", ['price'] = 1000, ['tipo'] = "work" }, 
	["paradise"] = { ['name'] = "Paradise", ['price'] = 1000, ['tipo'] = "work" },


	["seasparrow"] = { ['name'] = "Paramédico Helicóptero Água", ['price'] = 1000, ['tipo'] = "work" },
	["coach"] = { ['name'] = "Coach", ['price'] = 1000, ['tipo'] = "work" },
	["bus"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed"] = { ['name'] = "Reboque", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck"] = { ['name'] = "Towtruck", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work" },
	["rwnoader"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["rwnoader2"] = { ['name'] = "Rwnoader2", ['price'] = 1000, ['tipo'] = "work" },
	["rubble"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work" },
	["boxville4"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work" },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work" },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work" },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work" },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work" },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work" },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work" },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work" },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work" },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work" },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work" },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work" },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work" },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work" },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work" },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work" },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work" },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work" },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work" },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work" },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work" },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work" },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work" },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work" },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work" },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000, ['tipo'] = "work" },
	["maverick"] = { ['name'] = "Maverick", ['price'] = 100000, ['tipo'] = "work" },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work" },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work" },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work" },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work" },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work" },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 200000, ['tipo'] = "work" },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 250000, ['tipo'] = "work" },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 200000, ['tipo'] = "work" },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 200000, ['tipo'] = "work" },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work" },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "work" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work" },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 200000, ['tipo'] = "work" },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 200000, ['tipo'] = "work" },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work" },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work" },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work" },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work" },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed3"] = { ['name'] = "flatbed3", ['price'] = 1000, ['tipo'] = "work" },
	["cargobob2"] = { ['name'] = "Cargo Bob 2", ['price'] = 1000000, ['tipo'] = "work" },		
	["av-nc7"] = { ['name'] = "Honda NX500", ['price'] = 1000, ['tipo'] = "work" },
	["av-ghibli"] = { ['name'] = "Maserati Ghibi", ['price'] = 1000, ['tipo'] = "work" },
	["police2"] = { ['name'] = "Porsche 718 Caymans", ['price'] = 1000, ['tipo'] = "work" },
	["trans_mbxclass"] = { ['name'] = "Mercedes-Benz X-Class", ['price'] = 1000, ['tipo'] = "work" },
	["av-levante"] = { ['name'] = "Maserati Levante", ['price'] = 1000, ['tipo'] = "work" },
	["av-amarok"] = { ['name'] = "Amarok da Mecânica", ['price'] = 1000, ['tipo'] = "work" },
	["stockade"] = { ['name'] = "Carro Forte", ['price'] = 1000, ['tipo'] = "work" }, 
	["av-m8"] = { ['name'] = "BMW M8", ['price'] = 1000, ['tipo'] = "work" }, 
	["swift"] = { ['name'] = "Swift", ['price'] = 999999999, ['tipo'] = "work" },

	["cargobob"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["havok"] = { ['name'] = "Havok", ['price'] = 999999999, ['tipo'] = "exclusive" },
	["swift2"] = { ['name'] = "Swift2", ['price'] = 999999999, ['tipo'] = "exclusive" },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 1000000, ['tipo'] = "exclusive" },	


	--CARROS VIP 1

	["audirs6"] = { ['name'] = "Audi RS6", ['price'] = 500000,['price2'] = 380, ['tipo'] = "carrosvip1" },
	["audirs7"] = { ['name'] = "Audi RS7", ['price'] = 500000,['price2'] = 450, ['tipo'] = "carrosvip1" },
	["bmwm3f80"] = { ['name'] = "BMW M3 F80", ['price'] = 500000,['price2'] = 460, ['tipo'] = "carrosvip1" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 9", ['price'] = 500000,['price2'] = 490, ['tipo'] = "carrosvip1" },
	["nissan370z"] = { ['name'] = "Nissan 370Z", ['price'] = 500000,['price2'] = 600, ['tipo'] = "carrosvip1" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 500000,['price2'] = 630, ['tipo'] = "carrosvip1" },
	["eclipse"] = { ['name'] = "Mitsubishi Eclipse", ['price'] = 500000,['price2'] = 400, ['tipo'] = "carrosvip1" },
	["amggtr"] = { ['name'] = "Mercedes AMG", ['price'] = 500000,['price2'] = 470, ['tipo'] = "carrosvip1" },
	["focusrs"] = { ['name'] = "Focus RS", ['price'] = 500000,['price2'] = 430, ['tipo'] = "carrosvip1" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 500000,['price2'] = 590, ['tipo'] = "carrosvip1" },
	["bme6tun"] = { ['name'] = "BMW M5", ['price'] = 500000,['price2'] = 510, ['tipo'] = "carrosvip1" },
	["18macan"] = { ['name'] = "Porsche Macan", ['price'] = 500000,['price2'] = 390, ['tipo'] = "carrosvip1" },
	["mazdarx7"] = { ['name'] = "Mazda RX7", ['price'] = 500000,['price2'] = 430, ['tipo'] = "carrosvip1" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 500000,['price2'] = 460, ['tipo'] = "carrosvip1" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 500000,['price2'] = 470, ['tipo'] = "carrosvip1" },

	--CARROS VIP 2

	["dodgechargersrt"] = { ['name'] = "Dodge Charger SRT", ['price'] = 500000,['price2'] = 1120, ['tipo'] = "carrosvip2" },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 500000,['price2'] = 950, ['tipo'] = "carrosvip2" },
	["fordmustang"] = { ['name'] = "Ford Mustang", ['price'] = 500000,['price2'] = 1170, ['tipo'] = "carrosvip2" },
	["mercedesa45"] = { ['name'] = "Mercedes A45", ['price'] = 500000,['price2'] = 990, ['tipo'] = "carrosvip2" },
	["mustangmach1"] = { ['name'] = "Mustang Mach 1", ['price'] = 500000,['price2'] = 1030, ['tipo'] = "carrosvip2" },
	["nissangtr"] = { ['name'] = "Nissan GTR", ['price'] = 500000,['price2'] = 1140, ['tipo'] = "carrosvip2" },
	["70camarofn"] = { ['name'] = "camaro Z28 1970", ['price'] = 500000,['price2'] = 1040, ['tipo'] = "carrosvip2" },
	["g65amg"] = { ['name'] = "Mercedes G65", ['price'] = 500000,['price2'] = 870, ['tipo'] = "carrosvip2" },
	["m6e63"] = { ['name'] = "BMW M6 E63", ['price'] = 500000,['price2'] = 1050, ['tipo'] = "carrosvip2" },
	["fc15"] = { ['name'] = "Ferrari California", ['price'] = 500000,['price2'] = 1180, ['tipo'] = "carrosvip2" },
	["71gtx"] = { ['name'] = "Plymouth 71 GTX", ['price'] = 500000,['price2'] = 880, ['tipo'] = "carrosvip2" },
	["19ftype"] = { ['name'] = "Jaguar F-Type", ['price'] = 500000,['price2'] = 930, ['tipo'] = "carrosvip2" },
	["s15"] = { ['name'] = "Nissan Silvia S15", ['price'] = 500000,['price2'] = 890, ['tipo'] = "carrosvip2" },
	["bc"] = { ['name'] = "Pagani Huayra", ['price'] = 500000,['price2'] = 1090, ['tipo'] = "carrosvip2" },
	["palameila"] = { ['name'] = "Porsche Panamera", ['price'] = 500000,['price2'] = 1020, ['tipo'] = "carrosvip2" },
	["hondafk8"] = { ['name'] = "Honda FK8", ['price'] = 500000,['price2'] = 1100, ['tipo'] = "carrosvip2" },
	["porsche930"] = { ['name'] = "Porsche 930", ['price'] = 500000,['price2'] = 920, ['tipo'] = "carrosvip2" },
	["2018zl1"] = { ['name'] = "Camaro ZL1", ['price'] = 500000,['price2'] = 1160, ['tipo'] = "carrosvip2" },
	["filthynsx"] = { ['name'] = "Honda NSX", ['price'] = 500000,['price2'] = 1150, ['tipo'] = "carrosvip2" },

	--CARROS VIP 3

	["ferrariitalia"] = { ['name'] = "Ferrari Italia 478", ['price'] = 500000,['price2'] = 1850, ['tipo'] = "carrosvip3" },
	["rmodamgc63"] = { ['name'] = "Mercedes AMG C63", ['price'] = 500000,['price2'] = 1480, ['tipo'] = "carrosvip3" },
	["veneno"] = { ['name'] = "Lamborghini Veneno", ['price'] = 500000,['price2'] = 1890, ['tipo'] = "carrosvip3" },
	["p1"] = { ['name'] = "Mclaren P1", ['price'] = 500000,['price2'] = 1930, ['tipo'] = "carrosvip3" },
	["488gtb"] = { ['name'] = "Ferrari 488 GTB", ['price'] = 500000,['price2'] = 1780, ['tipo'] = "carrosvip3" },
	["911r"] = { ['name'] = "Porsche 911R", ['price'] = 500000,['price2'] = 1950, ['tipo'] = "carrosvip3" },
	["i8"] = { ['name'] = "BMW i8", ['price'] = 500000,['price2'] = 1640, ['tipo'] = "carrosvip3" },
	["fxxkevo"] = { ['name'] = "Ferrari FXXK Evo", ['price'] = 500000,['price2'] = 2000, ['tipo'] = "carrosvip3" },
	["lp700r"] = { ['name'] = "Lamborghini LP700R", ['price'] = 500000,['price2'] = 1740, ['tipo'] = "carrosvip3" },
	["agerars"] = { ['name'] = "Koenigsegg Agera RS", ['price'] = 1000000,['price2'] = 2000, ['tipo'] = "carrosvip3" },
	["180sx"] = { ['name'] = "Nissan 180SX", ['price'] = 500000,['price2'] = 1530, ['tipo'] = "carrosvip3" },
	["amarok"] = { ['name'] = "VW Amarok", ['price'] = 500000,['price2'] = 1480, ['tipo'] = "carrosvip3" },
	["defiant"] = { ['name'] = "AMC Javelin 72", ['price'] = 500000,['price2'] = 1430, ['tipo'] = "carrosvip3" },
	["eleanor"] = { ['name'] = "Mustang Eleanor", ['price'] = 500000,['price2'] = 1500, ['tipo'] = "carrosvip3" },
	["slsamg"] = { ['name'] = "Mercedes SLS", ['price'] = 500000,['price2'] = 1570, ['tipo'] = "carrosvip3" },
	["urus2018"] = { ['name'] = "Lamborghini Urus 2018", ['price'] = 500000,['price2'] = 1450, ['tipo'] = "carrosvip3" },
	["nissantitan17"] = { ['name'] = "Nissan Titan 2017", ['price'] = 500000,['price2'] = 3050, ['tipo'] = "carrosvip3" },
	["porsche992"] = { ['name'] = "Porsche 992", ['price'] = 500000,['price2'] = 1690, ['tipo'] = "carrosvip3" },

	-- MOTOS VIP
	
	["africat"] = { ['name'] = "Honda CRF 1000", ['price'] = 500000,['price2'] = 1630, ['tipo'] = "motosvip" },
	["r1250"] = { ['name'] = "BMW R1250", ['price'] = 500000,['price2'] = 1980, ['tipo'] = "motosvip" },
	["mt03"] = { ['name'] = "Yamaha MT-03", ['price'] = 500000,['price2'] = 620, ['tipo'] = "motosvip" },
	["500x"] = { ['name'] = "Honda CB 500 X", ['price'] = 500000,['price2'] = 1030, ['tipo'] = "motosvip" },
	["cb500f"] = { ['name'] = "CB500F 2020", ['price'] = 500000,['price2'] = 1100, ['tipo'] = "motosvip" },
	["hornet"] = { ['name'] = "Honda Cb600f", ['price'] = 500000,['price2'] = 1640, ['tipo'] = "motosvip" },
	["fz07"] = { ['name'] = "Yamaha MT-07", ['price'] = 500000,['price2'] = 1720,  ['tipo'] = "motosvip" },
	["cb650r"] = { ['name'] = "HONDA CB650R 2021", ['price'] = 500000,['price2'] = 1700, ['tipo'] = "motosvip" },
	["yzfr6"] = { ['name'] = "Yamaha R6", ['price'] = 500000,['price2'] = 1930, ['tipo'] = "motosvip" },
	["hvrod"] = { ['name'] = "Harley-Davidson", ['price'] = 500000,['price2'] = 1520, ['tipo'] = "motosvip" },
	["z1000"] = { ['name'] = "Kawasaki Z1000", ['price'] = 500000,['price2'] = 2030, ['tipo'] = "motosvip" },
	["sxr"] = { ['name'] = "BMW 1000r SXR", ['price'] = 500000,['price2'] = 2100, ['tipo'] = "motosvip" },
	["zx10"] = { ['name'] = "Kawasaki Ninja ZX 10", ['price'] = 500000,['price2'] = 2540, ['tipo'] = "motosvip" },
	["nh2r"] = { ['name'] = "Kawasaki Ninja H2 R", ['price'] = 500000,['price2'] = 3050, ['tipo'] = "motosvip" },
	

	-- ADICIONAIS VIP 

	["packMoney1"] = { ['name'] = "100 Mil Dólares", ['price'] = 100000,['price2'] = 150, ['tipo'] = "adicionaisvip" },
	["packMoney2"] = { ['name'] = "300 Mil Dólares", ['price'] = 300000,['price2'] = 400, ['tipo'] = "adicionaisvip" },
	["packMoney3"] = { ['name'] = "500 Mil Dólares", ['price'] = 500000,['price2'] = 600, ['tipo'] = "adicionaisvip" },
	["valemansao"] = { ['name'] = "Vale Mansão", ['price2'] = 350, ['tipo'] = "adicionaisvip" },
	["valeplaca"] = { ['name'] = "Vale Troca Placa", ['price2'] = 600, ['tipo'] = "adicionaisvip" },
	["valefone"] = { ['name'] = "Vale Troca Número", ['price2'] = 600, ['tipo'] = "adicionaisvip" },

	-- PACOTES VIPS

	["pacoteVip1"] = { ['name'] = "1 - VIP STANDARD",['price2'] = 750, ['tipo'] = "pkgvips" },
	["pacoteVip2"] = { ['name'] = "2 - VIP PREMIUM",['price2'] = 1300, ['tipo'] = "pkgvips" },
	["pacoteVip3"] = { ['name'] = "3 - VIP ELITE",['price2'] = 2100, ['tipo'] = "pkgvips" },
	["pacoteVip4"] = { ['name'] = "4 - VIP ULTIMATE",['price2'] = 3100, ['tipo'] = "pkgvips" },

	--IMPORTADOS

	["type263"] = { ['name'] = "Kombi 63", ['price'] = 500000, ['tipo'] = "import" },
	["beetle74"] = { ['name'] = "Fusca 74", ['price'] = 500000, ['tipo'] = "import" },
	["fe86"] = { ['name'] = "Escorte", ['price'] = 500000, ['tipo'] = "import" },		
	["18velar"] = { ['name'] = "Range Rover Velar", ['price'] = 500000, ['tipo'] = "import" },

	--EXCLUSIVE 
	["raptor2017"] = { ['name'] = "Ford Raptor 2017", ['price'] = 500000,['tipo'] = "exclusive" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 500000, ['tipo'] = "exclusive" },
	["tractor"] = { ['name'] = "Tractor", ['price'] = 9999999999, ['tipo'] = "exclusive" },	
	["Y1700MAX"] = { ['name'] = "Yamaha 1700 V-MAX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["goldwing"] = { ['name'] = "Honda GoldWing 1800", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["nissangtrnismo"] = { ['name'] = "Nissan GTR Nismo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["m2"] = { ['name'] = "BMW M2", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["aperta"] = { ['name'] = "La Ferrari", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bettle"] = { ['name'] = "New Bettle", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["senna"] = { ['name'] = "Mclaren Senna", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodx6"] = { ['name'] = "BMW X6", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bnteam"] = { ['name'] = "Bentley", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rmodlp770"] = { ['name'] = "Lamborghini Centenario", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["divo"] = { ['name'] = "Buggati Divo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lamtmc"] = { ['name'] = "Lamborghini Terzo", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["vantage"] = { ['name'] = "Aston Martin Vantage", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["urus"] = { ['name'] = "Lamborghini Urus", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["celta"] = { ['name'] = "Celta Paredão", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["rsvr16"] = { ['name'] = "Ranger Rover", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f4rr"] = { ['name'] = "Augusta", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["db11"] = { ['name'] = "Aston Martin DB11", ['price'] = 500000,['tipo'] = "exclusive" },
	["rcbandito"] = { ['name'] = "RC", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ghispo3"] = { ['name'] = "Ghispo Xeriff", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r1custom"] = { ['name'] = "R1 Xeriff", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["polsrt10"] = { ['name'] = "Xeriff SRT10", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["tr22"] = { ['name'] = "Tesla", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["kuruma2"] = { ['name'] = "Kuruma do Torres", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["18jeep"] = { ['name'] = "Jeep Xerife", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["polgt500"] = { ['name'] = "GT 500 Xerife", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["17raptorpd"] = { ['name'] = "Raptor 17 Xerife", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["can"] = { ['name'] = "Can", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["cam8tun"] = { ['name'] = "Toyota XSE", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmws"] = { ['name'] = "Augusta", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ghispo2"] = { ['name'] = "Maserati", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["polgs350"] = { ['name'] = "GS350", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmpos8"] = { ['name'] = "BMW OS8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["z419"] = { ['name'] = "BMW Z4", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["r8ppi"] = { ['name'] = "Audi R8", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["zondar"] = { ['name'] = "Pagani Zonda R", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["sspres"] = { ['name'] = "Suburban", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["laferrari17"] = { ['name'] = "LaFerrari", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["2020silv"] = { ['name'] = "Silverado2020", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["19ramdonk"] = { ['name'] = "Dodge Ram Donk", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["silv86"] = { ['name'] = "Silverado Donk", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["ninjah2"] = { ['name'] = "Ninja H2", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["regera"] = { ['name'] = "Koenigsegg Regera", ['price'] = 500000,['price2'] = 300, ['tipo'] = "exclusive" },
	["msohs"] = { ['name'] = "Mclaren 688 HS", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["gt17"] = { ['name'] = "Ford GT 17", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bbentayga"] = { ['name'] = "Bentley Bentayga", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["trr"] = { ['name'] = "KTM TRR", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bmws"] = { ['name'] = "BMW S1000", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["hcbr17"] = { ['name'] = "Honda CBR17", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["f12tdf"] = { ['name'] = "Ferrari F12 TDF", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["lykan"] = { ['name'] = "Plymouth 71 GTX", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["SVR14"] = { ['name'] = "Ranger Rover", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["evoque"] = { ['name'] = "Ranger Rover Evoque", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["Bimota"] = { ['name'] = "Ducati Bimota", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["20r1"] = { ['name'] = "Yamaha YZF R1", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["yzfr125"] = { ['name'] = "Yamaha YZF R125", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["pistas"] = { ['name'] = "Ferrari Pista", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bobbes2"] = { ['name'] = "Harley D. Bobber S", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["bobber"] = { ['name'] = "Harley D. Bobber ", ['price'] = 1000000, ['tipo'] = "exclusive" },
	["911tbs"] = { ['name'] = "Porsche 911S", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["rc"] = { ['name'] = "KTM RC", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	--["zx10r"] = { ['name'] = "Kawasaki ZX10R", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["fox600lt"] = { ['name'] = "McLaren 600LT", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxbent1"] = { ['name'] = "Bentley Liter 1931", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxevo"] = { ['name'] = "Lamborghini EVO", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["jeepg"] = { ['name'] = "Jeep Gladiator", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxharley1"] = { ['name'] = "Harley-Davidson Softail F.B.", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxharley2"] = { ['name'] = "2016 Harley-Davidson Road Glide", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxleggera"] = { ['name'] = "Aston Martin Leggera", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxrossa"] = { ['name'] = "Ferrari Rossa", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxshelby"] = { ['name'] = "Ford Shelby GT500", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxsian"] = { ['name'] = "Lamborghini Sian", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxsterrato"] = { ['name'] = "Lamborghini Sterrato", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["foxsupra"] = { ['name'] = "Toyota Supra", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["m6x6"] = { ['name'] = "Mercedes Benz 6x6", ['price'] = 1000000, ['tipo'] = "exclusive" },	
	["faction2"] = { ['name'] = "Faction2", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["m6gt3"] = { ['name'] = "BMW M6 GT3", ['price'] = 1000000, ['tipo'] = "exclusive" },		
	["w900"] = { ['name'] = "Kenworth W900", ['price'] = 1000000, ['tipo'] = "exclusive" }		
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE2
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice2(vname)
	return vehglobal[vname].price2
end
-----
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[vname].tipo
end

function vRP.openChest2(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					if amount > 0 and amount <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,amount)
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							citem.amount = citem.amount - amount

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,amount)
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.")
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
					if new_weight <= max_weight then
						if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + amount
							else
								chest.items[idname] = { amount = amount }
							end

							if cb_in then
								cb_in(idname,amount)
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.")
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count+1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","O baú está sendo utilizado no momento.")
			end
		end
	end
end