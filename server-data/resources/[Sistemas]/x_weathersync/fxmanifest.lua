fx_version 'adamant'

game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RedM Extended Server Sync'

version '1.0.0'

client_scripts {

    'config.lua',
    'client/main.lua'
}

server_scripts {

    'config.lua',
    'server/common.lua',
    'server/objects/time.lua',
    'server/objects/weather.lua',
    'server/main.lua'
}

