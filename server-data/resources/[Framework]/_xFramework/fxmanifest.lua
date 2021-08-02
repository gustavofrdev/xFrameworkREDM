fx_version 'adamant'
game 'common'

server_scripts {
    "Server/CallBack/Callback_Utils.lua",
    "queue.lua",
    "Server/Modules/MySQL.lua",
    "Server/Modules/Personagem.lua",
    "Configs/GroupsConfig.lua",
    "Configs/InventoryConfig.lua",
    "Configs/CallsConfig.lua",
    "Configs/LoginConfig.lua",
    "Configs/HorsesConfig.lua",
    "Configs/JailSystem.lua",
    "Configs/SkinConfig.lua",
    "Configs/IDRenderConfig.lua",
    "Server/Modules/Calls.lua",
    "Server/Modules/Grupos.lua",
    "Server/Modules/LastPos.lua",
    "Server/Modules/IDRender.lua",
    "Server/Modules/Inventory.lua",
    "Server/Modules/Admin.lua",
    "Server/Modules/Horse.lua",
    "Server/Modules/Money.lua",
    "Server/Modules/Survival.lua",
    "Server/Modules/JailModule.lua",
    "Server/Modules/skinmanager.lua",
    "Server/Modules/DiscordLogSystem.lua",
    "login.lua"
}
client_scripts {
    "Server/CallBack/Callback_Utils.lua",
    "Client/Client.lua",
    "Configs/DataConfig.lua",
    "Client/Modules/Armas.lua",
    "Client/Modules/JailSystem.lua",
    "Client/Modules/IDRender.lua",
    "Client/Modules/Functions.lua",
    "Client/Modules/noclip.lua",
    "Client/Modules/anim.lua",
    "Client/Modules/skinmanager.lua",
    "Client/Modules/sobrevivencia.lua"
}

files{
    "Server/CallBack/Callback_Tunnel.lua",
    "Server/CallBack/Callback_Tools.lua",
    "Server/CallBack/Callback_Proxy.lua",
}
server_exports {
    "GetUserGroups",
    "GetGroupName",
    "SetUserGroup",
    "RemoveUserGroup",
    "GetGroupName",
    "HasPermission",
    "HasGroup",
    "UseInventoryItem",
    "GetItemLabel",
    "GetItemWeight",
    "GetItemLimit",
    "GetItemType",
    "GetItemDesc",
    "TryGetInventoryItem",
    "GetInventoryItemAmount",
    "GetInventory",
    "GetInventoryUsingWeight",
    "ClearInventory",
    "SetInventoryMaxWeight",
    "GetInventoryMaxWeight",
    "GetInventoryItem",
    "GiveMoney",
    "TryPayment",
    "GetUserMoney",
    "GetUserId",
    "GetGroupsConfig",
    "GetUserSource"
  }