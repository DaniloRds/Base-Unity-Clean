local cfg = {}

cfg.groups = {

	-- [ADMINISTRAÇÃO ] --
	["owner"] = {
		_config = {
			title = "Owner",
			gtype = "owner"
		},
		"owner.permissao",
		"admin.permissao",
		"easytime.permissao",
		"mochila.permissao",
		"ticket.permissao",
		"preset.permissao",
		"chatstaff.permissao",
		"polpar.permissao",
		"reviver.permissao",
		"suporte.permissao"
	},
	["paisana_owner"] = {
		_config = {
			title = "PaisanaOwner",
			gtype = "owner"
		},
		"paisanaowner.permissao",
	},
	["admin"] = {
		_config = {
			title = "Admin",
			gtype = "admin"
		},
		"admin.permissao",
		"adminpoderes.permissao",
		"polpar.permissao",
		"easytime.permissao",
		"reviver.permissao",
		"chatstaff.permissao",
		"mochila.permissao",
		"preset.permissao",
		"ticket.permissao",
		"mod.permissao"
	},
	["paisana_admin"] = {
		_config = {
			title = "PaisanaAdmin",
			gtype = "admin"
		},
		"paisanadmin.permissao",
	},
	["mod"] = {
		_config = {
			title = "Mod",
			gtype = "mod"
		},
		"mod.permissao",
		"modpoderes.permissao",
		"chatstaff.permissao",
		"polpar.permissao",
		"mochila.permissao",
		"preset.permissao",
		"ticket.permissao",
		"reviver.permissao"
	},
	["paisana_mod"] = {
		_config = {
			title = "PaisanaMod",
			gtype = "mod"
		},
		"paisanamod.permissao",
	},
	["suporte"] = {
		_config = {
			title = "Suporte",
			gtype = "suporte"
		},
		"suporte.permissao",
		"suportepoderes.permissao",
		"chatstaff.permissao",
		"preset.permissao",
		"reviver.permissao",
		"ticket.permissao"
	},
	["paisana_suporte"] = {
		_config = {
			title = "PaisanaSuporte",
			gtype = "suporte"
		},
		"paisanasuporte.permissao",
	},
	
	["blips"] = {
		"blips.permissao"
	},

	-- [EMPREGOS] --
	["burguer1"] = {
		_config = {
			title = "Dono do Burguershot",
			gtype = "job"
		},
		"dono.burguershot",
		"burguershot.permissao"
	},
	["burguer"] = {
		_config = {
			title = "Funcionário Burguershot",
			gtype = "job"
		},
		"burguershot.permissao",
		"servico.burguershot"
	},
	["burguer1-off"] = {
		_config = {
			title = "Burguershot: Fora de Serviço",
			gtype = "job"
		},
		"burguershotdono.foradeservico"
	},
	["burguer-off"] = {
		_config = {
			title = "Burguershot: Fora de Serviço",
			gtype = "job"
		},
		"burguershot.foradeservico"
	},

	-- [VIP] --
	["standart"] = {
		_config = {
			title = "standart",
			gtype = "vip",
			dias = 30, -- Dias de VIP
			coins = 0, -- Coins que ganha na ativação
			dinheiro = 100000, -- Dinheiro que ganha na ativação
			mochila = true, -- Se quando morrer a mochila fica (espaço na mochila)
			garagem = 2 -- Garagem ADICIONAL
		},
		"standart.permissao",
		"cor.permissao"
	},

	["premium"] = {
		_config = {
			title = "premium",
			gtype = "vip",
			dias = 30,
			coins = 10,
			dinheiro = 250000,
			mochila = true,
			garagem = 4,
			itens = { -- Itens que ganha na ativação
				{item = "cafe", quantidade = 1},
				{item = "agua", quantidade = 3}
			},
			carros = { -- Carros que ganha na ativação
				{car = "brioso"}
			}
		},
		"premium.permissao",
		"cor.permissao"
	},

	["elite"] = {
		_config = {
			title = "elite",
			gtype = "vip",
			dias = 30,
			coins = 25,
			dinheiro = 500000,
			mochila = true,
			garagem = 6,
			itens = {
				{item = "cafe", quantidade = 1},
				{item = "agua", quantidade = 3}
			},
			carros = { -- Carros que ganha na ativação
				{car = "brioso"}
			}
		},
		"elite.permissao",
		"cor.permissao"
	},

	["ultimate"] = {
		_config = {
			title = "ultimate",
			gtype = "vip",
			dias = 35,
			coins = 50,
			dinheiro = 1000000,
			mochila = true,
			garagem = 10,
			itens = {
				{item = "cafe", quantidade = 1},
				{item = "agua", quantidade = 3}
			},
			carros = { -- Carros que ganha na ativação
				{car = "brioso"},
				{car = "sentinel"}
			}
		},
		"ultimate.permissao",
		"cor.permissao"
	},

	["mochila"] = { -- Não mexer deletar ou remover
		"mochila.permissao"
	},
		
}

cfg.users = { -- MUDE CASO NÃO QUEIRA QUE O CARGO OWNER SEJA SETADO AUTOMATICAMENTE ATÉ O ID 3
	[1] = { "owner" },
	[2] = { "owner" },
	[3] = { "owner" }
}

cfg.selectors = {}

return cfg