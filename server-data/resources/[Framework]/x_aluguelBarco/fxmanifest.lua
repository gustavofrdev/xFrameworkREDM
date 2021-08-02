
fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}

client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    'warmenu.lua',
    'client.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    'config.lua',
    'server.lua',
}
