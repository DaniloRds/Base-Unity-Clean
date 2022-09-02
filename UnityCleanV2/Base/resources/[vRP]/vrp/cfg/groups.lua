local cfg = {}

cfg.groups = {
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
	["PaisanaOwner"] = {
		_config = {
			title = "PaisanaOwner",
			gtype = "owner"
		},
		"paisanaowner.permissao",
	},
	["Admin"] = {
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
	["PaisanaAdmin"] = {
		_config = {
			title = "PaisanaAdmin",
			gtype = "admin"
		},
		"paisanadmin.permissao",
	},
	["Mod"] = {
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
	["PaisanaMod"] = {
		_config = {
			title = "PaisanaMod",
			gtype = "mod"
		},
		"paisanamod.permissao",
	},
	["Suporte"] = {
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
	["PaisanaSuporte"] = {
		_config = {
			title = "PaisanaSuporte",
			gtype = "suporte"
		},
		"paisanasuporte.permissao",
	},
	
	["Blips"] = {
		"blips.permissao"
	},
		
}

cfg.users = {
	[1] = { "owner" },
	[2] = { "owner" },
	[3] = { "owner" }
}

cfg.selectors = {}

return cfg