
function t_Framework.GetHPMaxTime()
	return _Framework.LoginConfig().Survival.TempoHP
  end
  
  
  function t_Framework.GetSpawnLocation()
  
	return _Framework.LoginConfig().Survival.SpawnLocation
  end

  function t_Framework.newPSpawnPos()
	return _Framework.LoginConfig().NewPlayerSpawnPosition
  end
  
  function t_Framework.HasMap()
	local user_id = _Framework.GetUserId(source)
	return _Framework.GetInventoryItemAmount(user_id, "mapa") >= 1
  end
  
  AddEventHandler("xFramework:PlayerLogin", function(source, user_id)
  
  local __player = _Framework.GetUserData(tonumber(user_id))
  if not __player.Fome then
	__player.Fome = 0
  end
  if not __player.Sede then
	__player.Sede = 0
  end
  
  TriggerClientEvent("___mMMMMMhhhhhSSSSsssQQQqqqqqQQQQQQ", source, __player.Fome, __player.Sede)
  end)
    
  function _Framework.getFome(user_id)
	local __player = _Framework.GetUserData(tonumber(user_id))
	return __player.Fome
  end
  
  function _Framework.getSede(user_id)
	local __player = _Framework.GetUserData(tonumber(user_id))
	return __player.Sede
  end
  
  
  function _Framework.varySede(user_id, variation)
	local data = _Framework.GetUserData(user_id)
	if data then
	  local was_Sedey = data.Sede >= 100
	  data.Sede = data.Sede + variation
	  local is_Sedey = data.Sede >= 100
  
	  -- apply overflow as damage
	  local overflow = data.Sede - 100

	--   if overflow > 0 then
	-- 	_Frameworkclient._varyHealth(_Framework.GetUserSource(user_id), -overflow * 0.5)
	--   end
  
	  if data.Sede < 0 then
		data.Sede = 0
	  elseif data.Sede > 100 then
		data.Sede = 100
	  end
	end
  end
RegisterServerEvent("--> ++beber++ <--")
AddEventHandler("--> ++beber++ <--", function(i)
  _Framework.varySede(_Framework.GetUserId(source), -i)
end)
  
  function _Framework.varyFome(user_id, variation)
	-- print("varyFome: ", variation, user_id)
	local data = _Framework.GetUserData(user_id)
	if data then
	  local was_starving = data.Fome >= 100
	  data.Fome = data.Fome + variation
	  local is_starving = data.Fome >= 100
  
	  -- apply overflow as damage
	  local overflow = data.Fome - 100
	--   if overflow > 0 then
	-- 	_Frameworkclient._varyHealth(_Framework.GetUserSource(user_id), -overflow * 1)
	--   end
  
	  if data.Fome < 0 then
		data.Fome = 0
	  elseif data.Fome > 100 then
		data.Fome = 100
	  end
	end
  end
  
  AddEventHandler("xFramework:PlayerLogin", function(src, user_id)
  local data = _Framework.GetUserData(user_id)
  if data.Sede == nil then
	data.Sede = 0
	data.Fome = 0
  end
  end)
