----------------------- [ Unity ] -----------------------
-- GitHub: https://github.com/DaniloRds
-- Discord: https://discord.gg/pbT5wVp8e9
-- Autor: Tio Dan#9894
-- Nome: LOJA VIP
-- Versão: 1.0.0
-- Contato: 'unitystorefivem@gmail.com'
----------------------- [ Unity ] -----------------------
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

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
	"nui/inicio.html",
	"nui/carrosVip2.html",
	"nui/carrosVip3.html",
	"nui/motosVip.html",
	"nui/adicionaisVip.html",
	"nui/pacotesVip.html",
	"nui/possuidosVip.html",
	"nui/jquery.js",
	"nui/css.css"
}