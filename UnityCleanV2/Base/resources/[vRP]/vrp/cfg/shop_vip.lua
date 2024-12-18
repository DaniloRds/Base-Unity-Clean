local cfg = {}

cfg.itemsVip = {
	-- ADICIONAIS VIP 
	["packMoney1"] = { ['name'] = "100 Mil Dólares", ['preco'] = 150, ['preco2'] = 100000, ['tipo'] = "adicionaisvip" }, -- preco (valor pago em moedas)
	["packMoney3"] = { ['name'] = "500 Mil Dólares", ['preco'] = 600, ['preco2'] = 500000, ['tipo'] = "adicionaisvip" }, -- preco2 (valor que o player vai receber em dinheiro)

	["valemansao"] = { ['name'] = "Vale Mansão", ['preco'] = 350, ['tipo'] = "adicionaisvip" },
	["valeplaca"] = { ['name'] = "Vale Troca Placa", ['preco'] = 600, ['tipo'] = "adicionaisvip" },
	["valefone"] = { ['name'] = "Vale Troca Número", ['preco'] = 600, ['tipo'] = "adicionaisvip" },

	-- PACOTES VIPS
	["pacoteVip1"] = { ['name'] = "1 - VIP STANDARD", ['preco'] = 750, ['tipo'] = "pkgvips" },
	["pacoteVip2"] = { ['name'] = "2 - VIP PREMIUM", ['preco'] = 1300, ['tipo'] = "pkgvips" },
	["pacoteVip3"] = { ['name'] = "3 - VIP ELITE", ['preco'] = 2100, ['tipo'] = "pkgvips" },
	["pacoteVip4"] = { ['name'] = "4 - VIP ULTIMATE", ['preco'] = 3100, ['tipo'] = "pkgvips" },
}

return cfg