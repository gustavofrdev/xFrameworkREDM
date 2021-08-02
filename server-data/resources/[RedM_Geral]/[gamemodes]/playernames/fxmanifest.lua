-- add scripts
client_script 'playernames__Framework.lua'
server_script 'playernames__Framework.lua'

client_script 'playernames_cl.lua'
server_script 'playernames_sv.lua'

-- make exports
local exportList = {
    'setComponentColor',
    'setComponentAlpha',
    'setComponentVisibility',
    'setWantedLevel',
    'setHealthBarColor',
    'setNameTemplate'
}

exports(exportList)
server_exports(exportList)

-- add files
files {
    'template/template.lua'
}

-- support the latest resource manifest
fx_version 'adamant'
game 'gta5'