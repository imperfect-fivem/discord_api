fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version "0.0.2"
author "m-imperfect <owner@m-imperfect.net>"
description "Lua based Discord API."

server_only 'yes'

dependency 'ox_lib'
server_script '@ox_lib/init.lua'

server_scripts {
	'src/init.lua',
	'src/modules/**.lua',
	'init.lua',
	'src/checks.lua',
	-- 'examples.lua',
}
