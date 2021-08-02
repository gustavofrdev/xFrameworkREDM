--[[
! Módulo MySQL propietário da xFramework
* Todas as funções de SQL serão inseridas nesse módulo
? _Framework
? Exemplo de código usando o módulo
? local MySQL = _Framework
? local query = MySQL.SQLExecute(sql, {["t"] = a})
]]

local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
_Framework = {}
Proxy.addInterface("_xFramework",_Framework)
t_Framework = {}
Tunnel.bindInterface("_xFramework",t_Framework)
_Frameworkclient = Tunnel.getInterface("_xFramework")
local API = {}
local query = {}

function _Framework.RegisterFastQuery (query, queryName, queryString, queryArray)
  query[queryName] = {["Function"] = queryString}
end

function _Framework.GetUserName(user_id)
  user_id = tonumber(user_id)
  local result = _Framework.SQLExecute("SELECT name FROM xframework_personagens WHERE id = @id", {["@id"] = user_id })
  name = result[1].name
  return name
end

function _Framework.addVip(vipGroup, userId, source)
  local sourceId = _Framework.GetUserSource(userId)
  local steam = _Framework.GetPlayerActualSteam(sourceId)
  TriggerClientEvent("xFramework:Notify", source, "sucesso", "Se existir, "..steam.. "["..userId.."] Agora faz parte de: "..vipGroup)
  _Framework.SQLExecute("UPDATE xframework_usuarios SET vip = 1 WHERE identifier = @id", {["@id"] = steam})
  _Framework.SetUserGroup(userId, vipGroup, true)
end


function _Framework.removeVip(vipGroup, userId, source)
  local sourceId = _Framework.GetUserSource(userId)
  local steam = _Framework.GetPlayerActualSteam(sourceId)
  TriggerClientEvent("xFramework:Notify", source, "sucesso", "Se existir, "..steam.. "["..userId.."] não fará mais parte de: "..vipGroup)
  _Framework.SQLExecute("UPDATE xframework_usuarios SET vip = 0 WHERE identifier = @id", {["@id"] = steam})
  _Framework.RemoveUserGroup(userId, vipGroup, true)
end

function _Framework.isVipInUserData(hex)
  local isVip = _Framework.SQLExecute("SELECT VIP FROM xframework_usuarios WHERE identifier = @hex", {["@hex"] = hex })
  if isVip and isVip[1] and isVip[1].VIP then 
    if isVip[1].VIP >= 1 then 
      return true 
    else
      return false
    end
  end
end

function _Framework.freeWl(steam, source)
  _Framework.SQLExecute("UPDATE xframework_usuarios SET whitelist = 1 WHERE identifier = @steam", {["@steam"] = steam})
  TriggerClientEvent("xFramework:Notify", source,"sucesso",steam.." adicionado a wl (stts = 1 )",10000)
end
function _Framework.unwl(steam, source)
  _Framework.SQLExecute("UPDATE xframework_usuarios SET whitelist = 0 WHERE identifier = @steam", {["@steam"] = steam})
  TriggerClientEvent("xFramework:Notify", source,"sucesso",steam.." removido da wl (stts = 0 )",10000)
end
function _Framework.Ban(user_id, status, author)
  if status then 
    status = 1
  elseif not status then 
    status = 0 
  end
  -- Found Hex!
  local found = _Framework.SQLExecute("SELECT ownerhex FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
  if found and found[1] and found[1].ownerhex then 
      --> Set ban status -->
      _Framework.SQLExecute("UPDATE xframework_usuarios SET banido = @stts WHERE identifier = @hex", {["@hex"] = found[1].ownerhex, ["@stts"] = tonumber(status)})
      --(41)
      TriggerClientEvent("xFramework:Notify", author,"sucesso","Player banido/desbanido",10000)
      if _Framework.IsPlayerOnline(user_id) and status == 1 then 
        --(44)
        DropPlayer(_Framework.GetUserSource(tonumber(user_id)),"Você foi banido do nosso servidor e portanto não poderá voltar ao menos que seja desbanido por alguém autorizado.")
          --(_Framework.GetUserSource(tonumber(user_id)))
          TriggerClientEvent("xFramework:Notify", author,"sucesso","Player está online --Expulso",10000)
      end
  end
end

function _Framework.PlayerExists(id)
  local exists = _Framework.SQLExecute("SELECT ownerhex FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(id)})
  if exists and exists[1] and exists[1].ownerhex then
    return true
  else
    return false
  end
end
function _Framework.CheckWhitelist (hex)
  local is = nil
  exports.ghmattimysql:execute("SELECT whitelist FROM xframework_usuarios WHERE identifier = @id", {["@id"] = hex }, function(w)
  is = w[1].whitelist
  -- print(is)
  end)
  while is == nil do Wait(0) end
    return tonumber(is)
  end
  function _Framework.HasHexID (giveHex)
    local id = nil
    exports.ghmattimysql:execute("SELECT hexid FROM xframework_usuarios WHERE @identifier = identifier", {["@identifier"] = giveHex}, function(r)
    if r[1] then
      if r[1].hexid then

        id = r[1].hexid
      else
        id = false
      end
    else
      id = false
    end
    end)
    while id == nil do Wait(0) end
      return id
    end
    function _Framework.SQLExecute(a,b)
      local resposta = nil
      exports.ghmattimysql:execute(a, b, function(resposta1)
      resposta = resposta1
      end)
      local counter = 0
      while resposta == nil do
        if counter == 1000 then return {} end counter = counter+1 Wait(0)end

        return resposta
      end

      function _Framework.Query(queryString, queryArray)
        local queryCommand = query[queryString]["Function"]
        _Framework.SQLExecute(queryCommand, queryArray)
      end
      function _Framework.GenerateNewUser  ( hex )
        exports.ghmattimysql:execute("INSERT INTO xframework_usuarios(identifier,banido,whitelist) VALUES(@hex,0,0)", {["@hex"] = hex}, function(r)
        return r
        end)
      end
