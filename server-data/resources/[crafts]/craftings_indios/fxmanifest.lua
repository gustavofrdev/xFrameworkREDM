resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}

ui_page 'nui/index.html'

client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
	'client.lua'
}

server_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
    "server.lua"
}

files {
	'nui/index.html',
	'nui/script.js',
    'nui/style.css',
	'nui/inv/*.png'
}
