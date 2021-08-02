resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "client/client.lua",
	'client/mp_male.lua',
	'client/mp_female.lua',
    'config.lua',
    'client/warmenu.lua'
}

server_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
    "server/server.lua"
}
