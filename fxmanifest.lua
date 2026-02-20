fx_version 'cerulean'

game 'gta5'

author 'CoreyJB247'

version '0.1'

shared_script '@ox_lib/init.lua'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'configuration/config.lua',
    'configuration/language.lua'
}