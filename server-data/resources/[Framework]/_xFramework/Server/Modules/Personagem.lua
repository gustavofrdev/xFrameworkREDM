local API = {}
local PlayerData = {}
local ids_online = {}
local Players = {}
local Tick = 60000
local PlayerCount = 0

local function wbh(m)
  TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/867127481755238410/Dd6CB6OehGiTiusT9-fCXVa2M17pRBSGkfXx0IZQWJH-izTtxwhKWaZDfVQMz-07AmhA", m)
end
Citizen.CreateThread(function()
wbh("> Servidor ligado & Módulo inicializado")
end )
function _Framework.IdLoad (source, user_id)
  PlayerCount = PlayerCount + 1
  table.insert(ids_online, user_id)
  wbh(user_id.. " Logou no servidor")
  -- Inserir toda a informação do novo user_id que logou no servidor
  _Frameworkclient.mHHHHHhhhhHH(tonumber(source), _Framework.LoginConfig().Survival.VidaMaxima)
  Players[source] = {user_id = user_id}
  local pd =  _Framework.SQLExecute("SELECT data FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
  if pd ~= nil and pd ~= "[]" then
    PlayerData[user_id] = json.decode(pd[1].data)
  end
  local c = _Framework.IDRenderConfig() 
  for k, v in pairs(ids_online) do 
    if v then 
      if _Framework.HasPermission(v, c.perm) then
          _Frameworkclient.InsertData(-1, _Framework.GetUserSource(v), v, true)
      else
          _Frameworkclient.InsertData(-1, _Framework.GetUserSource(v), v, false)
      end
    end
  end
  TriggerEvent("xFramework:PlayerLogin", source, user_id)
end

function task_update()
  for k, v in pairs(Players) do
    _Framework.varyFome(v.user_id, 1.00)
    _Framework.varySede(v.user_id, 1.00)
  end

  SetTimeout(120000, task_update)
end


async(function()
task_update()
end)

function table_invert(t)
  local u = { }
  for k, v in pairs(t) do u[v] = k end
  return u
end



function _Framework.GenerateNewTablesForPlayer(user_id)
  PlayerData[user_id].inventory = {}
  PlayerData[user_id].PesoMaximo = 50
  wbh(user_id.. " teve suas tabelas iniciais geradas pelo modulo")
  --!  Prencher a tabela parente a database inicial * xframework_cavalos * com valores padrões -- !
  _Framework.SQLExecute("INSERT INTO `xframework_cavalos`(`id`) VALUES (@id)", {["@id"] = tonumber(user_id)}) --+ .genarar.bar
end

function _Framework.RemovePlayer(source)
  if Players[source] then
    local user_id = Players[source].user_id
    _Framework.SQLExecute("UPDATE xframework_personagens SET data = @data WHERE id = @id", {["@data"] = json.encode(PlayerData[user_id]), ["@id"] = user_id})
    Wait(50)
    Players[source] = nil
    PlayerData[user_id] = nil
    TriggerEvent("xFramework:PlayerDisconnected", source, user_id)
    wbh(user_id.. " se desconectou")
    _Frameworkclient.RemoveData(-1, user_id)
    PlayerCount = PlayerCount - 1
    local inverted = table_invert(ids_online)
    local key = inverted[user_id]

    table.remove(ids_online, key)
  end
end

function _Framework.GetPlayers ()
  return Players
end
-- FrameworkSV.SetBulletFor(tolower(type_string), bullets)
function t_Framework.SetBulletFor(type, qnt)
  local user_id = _Framework.GetUserId(source)
  if user_id then 
    if PlayerData[user_id]["ammo"] then
      PlayerData[user_id]["ammo"][type] =  qnt
    end
  end
end

function _Framework.GetUserId (source)
  for k, v in pairs(Players) do
    if k == source then
      return v.user_id
    end
  end
end
exports("GetUserId", function(source)
  return _Framework.GetUserId(source)
end)

function _Framework.GetUserSource (user_id)
  for k, v in pairs(Players) do
    if user_id == v.user_id then
      return k
    end
  end
end
exports("GetUserSource", function(user_id, quantidade)
  return _Framework.GetUserSource(user_id)
end)
-- Client API
function _Framework.GetPlayerActualSteam (source)
  return Identifier('steam', source)
end

function _Framework.InsertNewPlayerData (dataname, datavalue)
  local source = source
  local user_id = Players[source].user_id
  PlayerData[user_id].dataname = datavalue
end
function t_Framework.getAmountOfBulletsByTypeForPlayer(type)
  local user_id = _Framework.GetUserId(source)
  if user_id then 
    return PlayerData[user_id]["ammo"][type]
  end
end

function t_Framework.backAmmo(ammo, qnt)
  local user_id = _Framework.GetUserId(source)
    if user_id then
      _Framework.GiveInventoryItem(user_id, string.lower(ammo), qnt, true)
      PlayerData[user_id]["ammo"][string.lower(ammo)] = 0
  end
end

function t_Framework.backGun(gun)
  local user_id = _Framework.GetUserId(source)
    if user_id then
  local canaddinvitem = _Framework.GiveInventoryItem(user_id, gun, 1, true )
  local old = _Framework.SQLExecute("SELECT armas_equipadas FROM xframework_personagens WHERE id = @id", {["@id"] =user_id})
      if old[1].armas_equipadas and old[1].armas_equipadas ~= nil and old[1].armas_equipadas ~= "[]" then 
        old = old[1].armas_equipadas
        old = json.decode(old)
        local bc = table_invert(old)
        local key = bc[gun]
        print(key)
        table.remove(old, key)
        _Framework.SQLExecute("UPDATE xframework_personagens SET armas_equipadas = @bbb WHERE id = @id", {["@bbb"] = json.encode(old), ["@id"] = user_id})
      end
  end
end

function _Framework.RemovePlayerData (dataname)
  local source = source

  local user_id = Players[source].user_id
  PlayerData[user_id].dataname = nil
end

--[[
  local armas = _Framework.SQLExecute("SELECT armas_equipadas FROM xframework_personagens WHERE id = @id", {["@id"] =user_id})
  if armas[1].armas_equipadas and armas[1].armas_equipadas ~= nil and armas[1].armas_equipadas ~= "[]" then 
    armas = armas[1].armas_equipadas
    armas = json.decode(armas)
    _Frameworkclient.useWeapon_2(source, armas)
  end
]]
-- Para o client atualizar determinados valores. O RESTO APENAS SV
function _Framework.SpawnInLastLoc (user_id)
  local source = _Framework.GetUserSource(user_id)
  local pd =  _Framework.SQLExecute("SELECT data FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
  pd = json.decode(pd[1].data)
  if PlayerData[user_id]["ammo"] then 
    _Frameworkclient.giveAmmoByType(source, PlayerData[user_id]["ammo"])
  end
  local armas = _Framework.SQLExecute("SELECT armas_equipadas FROM xframework_personagens WHERE id = @id", {["@id"] =user_id})
  if armas[1].armas_equipadas and armas[1].armas_equipadas ~= nil and armas[1].armas_equipadas ~= "[]" then 
    armas = armas[1].armas_equipadas
    armas = json.decode(armas)
    _Frameworkclient.useWeapon_2(source, armas)
  end
  local inLife = pd.vida or 100
  if not pd.position then
    local CFG_INITIAL_POSITION = _Framework.LoginConfig().NewPlayerSpawnPosition
    _Frameworkclient.TeleportPlayer(source, CFG_INITIAL_POSITION.x, CFG_INITIAL_POSITION.y, CFG_INITIAL_POSITION.z)

    _Frameworkclient.Ready(source, inLife)
    return
  end
  local lastLoc = pd.position
  _Frameworkclient.TeleportPlayer(source, lastLoc.x, lastLoc.y, lastLoc.z)
  _Frameworkclient.Ready(source, inLife)
end
function _Framework.IsPlayerOnline (user_id)
  local found = false
  for _, ID in pairs(Players) do
    if ID.user_id == user_id then
      found = true
    end
  end
  return found
end

function _Framework.GetUserData(user_id)
  return PlayerData[user_id]
end

function _Framework.NumberOnline ()
  return PlayerCount

end
string = ''
function _Framework.IDSOnline ()
  return json.encode(ids_online), ids_online
end

function _Framework.ForceSave()
  local salvou2 = false
  for _source, _ in pairs(Players) do
    local salvou = _Framework.SQLExecute("UPDATE xframework_personagens SET data = @data WHERE id = @id", {["@data"] = json.encode(PlayerData[Players[_source].user_id]), ["@id"] = Players[_source].user_id})
  end
  return salvou2
end
function  t_Framework.UpdatePlayerLastPosition (x, y, z )
  local source = source
  local user_id = Players[source].user_id
  PlayerData[user_id].position = {x=x, y=y, z=z}
end
function  t_Framework.UpdatePlayerLife (lifeValue)
  local source = source
  local user_id = Players[source].user_id
  PlayerData[user_id].vida = lifeValue
end



function Identifier(type, id)
  local identifiers = {}
  local numIdentifiers = GetNumPlayerIdentifiers(id)

  for a = 0, numIdentifiers do
    table.insert(identifiers, GetPlayerIdentifier(id, a))
  end

  for b = 1, #identifiers do
    if string.find(identifiers[b], type, 1) then
      return identifiers[b]
    end
  end
  return false
end



-- Update personagem data
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Tick)
    for _source, _ in pairs(Players) do
      _Framework.SQLExecute("UPDATE xframework_personagens SET data = @data WHERE id = @id", {["@data"] = json.encode(PlayerData[Players[_source].user_id]), ["@id"] = Players[_source].user_id})
    end
  end
end)

-- Dedectar player dropped

AddEventHandler('playerDropped', function ()
_Framework.RemovePlayer(source)
end)