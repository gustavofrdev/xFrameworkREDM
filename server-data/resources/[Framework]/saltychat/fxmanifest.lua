fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page "NUI/SaltyWebSocket.html"

client_scripts {
    "SaltyClient/bin/Debug/SaltyClient.net.dll"
}

server_scripts {
    "SaltyServer/bin/Debug/netstandard2.0/SaltyServer.net.dll"
}

files {
    "NUI/SaltyWebSocket.html",
    "Newtonsoft.Json.dll",
}

exports {
    "EstablishCall",
    "EndCall",

    "SetPlayerRadioSpeaker",
    "SetPlayerRadioChannel",
    "RemovePlayerRadioChannel",
    "SetRadioTowers"
}

VoiceEnabled "true"
ServerUniqueIdentifier "izgBSHeWbRU40RxM4WSpKNhIuGI="
RequiredUpdateBranch ""
MinimumPluginVersion ""
SoundPack "default"
IngameChannelId "69655"
IngameChannelPassword "iajdijsaidjasidjaisdjiasdjiadjiadjiajd"
SwissChannelIds "61,62"
