fx_version 'adamant'
game 'gta5'

ui_page "nui/index.html"

server_scripts {
	"@vrp/lib/utils.lua",
	"config_server.lua",
	"server.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"config_client.lua",
	"client.lua"
}

files {
	"nui/*.*",
	"nui/font/*.*",
	"nui/imagem/*.*",
	"nui/tatuagens/**/**/*.*"
}