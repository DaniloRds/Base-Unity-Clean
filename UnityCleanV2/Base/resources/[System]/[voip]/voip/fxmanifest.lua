shared_script "@ThnAC/native.lua"
shared_script "@ThnAC/natives.lua"
---- Evolution Software Inc

fx_version "adamant"
games {"gta5"}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

ui_page 'html/index.html'

files {	
	'Newtonsoft.Json.dll',
	'html/**/*'	
}

-- dependencies {
-- 	'common'
-- }              