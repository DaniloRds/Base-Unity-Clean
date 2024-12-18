----------------------- [ Unity ] -----------------------
-- GitHub: https://github.com/DaniloRds
-- Discord: https://discord.gg/pbT5wVp8e9
-- Nome: LOJA VIP
-- Versão: 1.1.0
-- Contato: 'unitystorefivem@gmail.com'
----------------------- [ Unity ] -----------------------
fx_version 'bodacious'
game 'gta5'

ui_page "nui_loja/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui_loja/index.html",
	"nui_loja/inicio.html",
	"nui_loja/carrosVip2.html",
	"nui_loja/carrosVip3.html",
	"nui_loja/motosVip.html",
	"nui_loja/adicionaisVip.html",
	"nui_loja/pacotesVip.html",
	"nui_loja/possuidosVip.html",
	"nui_loja/jquery.js",
	"nui_loja/css.css"
}