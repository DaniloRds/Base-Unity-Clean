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

	--
		
}

cfg.users = { -- MUDE CASO NÃO QUEIRA QUE O CARGO OWNER SEJA SETADO AUTOMATICAMENTE ATÉ O ID 3
	[1] = { "owner" },
	[2] = { "owner" },
	[3] = { "owner" }
}

cfg.selectors = {}

return cfg