fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
	'config.lua',
	'server/main.lua'
}

client_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
	'config.lua',
	'client/main.lua'
}

exports {
	'IsRobb',
}

-- dependency 'vorp_core'