fx_version 'bodacious'
game 'gta5'

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/index.html",
	"nui/jquery.js",
	"nui/images/*.jpg",
	"nui/click.ogg",
	"nui/css.css"
}