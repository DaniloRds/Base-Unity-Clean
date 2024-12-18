fx_version 'adamant'
game 'gta5'
developer 'Anderson Fabris#0001'

ui_page "nui/kPT.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

files {
	"nui/*.*",
	"nui/font/*.*",
	"nui/imagens/*.*",
}