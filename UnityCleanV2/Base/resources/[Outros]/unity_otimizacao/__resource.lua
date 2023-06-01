resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"@vrp/lib/utils.lua",
	-- Player --
	--"/player/client.lua",
	-- Diagonostico --
	"/diago/client.lua", 
	-- ItemDrop --
	"/itemdrop/client.lua", 
	-- Animacoes --
	--"/anim/client.lua", 
	-- Policia --
	"/policia/client.lua", 
	-- identidade --
	"/identidade/client.lua",
	-- admin --
	"admin_client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	-- Diagonostico --
	"/diago/server.lua",
	-- Policia --
	"/policia/server.lua",
	-- Player -- 
	"/itemdrop/server.lua",
	-- identidade --
	"/identidade/server.lua",
	-- Admin --
	"admin_server.lua"
}
