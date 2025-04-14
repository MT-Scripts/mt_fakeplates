fx_version 'cerulean'
game 'gta5'
author 'Marttins'
description 'Shitty fake plates script'
lua54 'yes'

shared_script '@ox_lib/init.lua'

client_scripts {
    'resource/client.lua',
    'modules/**/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/server.lua',
    'modules/**/server.lua'
}

files {
    'config/*.lua',
    'locales/*.json'
}