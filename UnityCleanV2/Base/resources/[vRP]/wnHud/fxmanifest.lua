
fx_version 'adamant'
game 'gta5'

ui_page "nui/index.html"
client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua",
	"config/config.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"config/config.lua"
}

files {
	"nui/*.html",
	"nui/*.js",
	"nui/*.css",
	"nui/bibs/loading-bar.css",
	"nui/bibs/loading-bar.js",
	"nui/svgs/*.svg",
	"nui/svgs/*.png",
}


                            