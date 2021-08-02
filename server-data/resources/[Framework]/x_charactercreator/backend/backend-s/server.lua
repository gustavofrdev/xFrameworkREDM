local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
_Framework = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
CharacterCreator = Tunnel.getInterface("x_charactercreator")
_Tunnel = {}
Tunnel.bindInterface("x_charactercreator", _Tunnel)

--------------------------------------------------------------------
-- functions <> --
--------------------------------------------------------------------
function _Tunnel.sendCharacterMode(characterMode, user_id, nome, idade)
  local source = source
  nome = string.lower(nome);
  local Sucess = FrameworkSV.SQLExecute("UPDATE xframework_personagens SET characterdata = @chardata WHERE id = @user_id", {["@chardata"] = characterMode, ["@user_id"] = user_id})
  Wait(300)
  local Sucess2 = FrameworkSV.SQLExecute("UPDATE xframework_personagens SET name = @nome WHERE id = @user_id", {["@nome"] = nome, ["@user_id"] = user_id})
  Wait(300)
  local Sucess3 = FrameworkSV.SQLExecute("UPDATE xframework_personagens SET idade = @idade WHERE id = @user_id", {["@idade"] = tonumber(idade), ["@user_id"] = user_id})
  while not Sucess and not Sucess2 and not Sucess3 do Wait(0) end
    _Framework.Ready(source)
    _Framework.ReviveGod(source)
    TriggerClientEvent("incriacaostatuts", source, false)
    Wait(10)
    TriggerClientEvent("load::Clothes", source)
    FrameworkSV.AddBankMoneyToUser(user_id, 1000)
  end
