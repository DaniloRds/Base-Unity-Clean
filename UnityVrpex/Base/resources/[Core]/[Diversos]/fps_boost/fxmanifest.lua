fx_version 'bodacious'
game { 'gta5' }

lua54 "yes"

ui_page 'nui/index.html'
ui_page_preload "yes"

client_script 'client/client.lua'

shared_scripts {
	'@vrp/lib/utils.lua',
	'general.lua'
}

files {
	'nui/**',
}