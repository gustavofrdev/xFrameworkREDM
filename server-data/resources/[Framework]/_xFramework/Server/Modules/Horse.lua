--[[

!     HorseAPI
TODO:  Gere a questão de cavalos do servidor
? local Horse = Framework METOD

]]

local function wbh(m)
  TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866424803498131517/BqrojF8hAInmCajrJUbm6i5cyanwDdDm1PRKyPyvyIrwUbZ--F0nrXa8LRCvXmW_aaDC", m)
end


local API = {}
local InternalHorseTable
local _Cache = {}

local function verifyIfExistsAnyHorseWithSameNameForUserId(user_id, horseName)
  user_id = tonumber(user_id)
  local resposta_calculada = true
  local userHorseTable = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @id", {['@id'] = tonumber(user_id)})
  if userHorseTable[1] == nil then return true end
  if json.encode(userHorseTable[1].horses) ~= '[]' then
    userHorseTable = json.decode(userHorseTable[1].horses)
    for k, v in pairs(userHorseTable) do
      local names = v["name"]
      -- print( names, horseName)
      -- print(names == horseName)
      if v["name"] == horseName then
        resposta_calculada = false
      end
    end
  else
    resposta_calculada = true
  end
  if (resposta_calculada == false) then
    TriggerClientEvent("xFramework:Notify", _Framework.GetUserSource(user_id), "negado", "Você já possuí um cavalo com exatamente o mesmo nome!")
  end
  return resposta_calculada
end

function verifyIfExistsAnyHorseWithVehicleNameForUserId(user_id, horseName)
  user_id = tonumber(user_id)
  local resposta_calculada = true
  local userHorseTable = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @id", {['@id'] = tonumber(user_id)})
  if json.encode(userHorseTable[1].vehicles) ~= '[]' then
    userHorseTable = json.decode(userHorseTable[1].vehicles)
    for k, v in pairs(userHorseTable) do
      local names = v["name"]
      if v["name"] == horseName then
        resposta_calculada = false
      end
    end
  else
    resposta_calculada = true
  end
  if (resposta_calculada == false) then
    TriggerClientEvent("Notify", _Framework.GetUserSource(user_id), "negado", "Você já possuí um cavalo com exatamente o mesmo nome!")
  end
  return resposta_calculada
end

function _Framework.BuyNewHorse (user_id, horse, horseName, horseIndex)
  local hT = {}
  local source= _Framework.GetUserSource(tonumber(user_id))
  local config= _Framework.HorseConfig()
  -- print(json.encode(config.cavalos[horseIndex]))
  if verifyIfExistsAnyHorseWithSameNameForUserId(user_id, horseName) then
    if config.cavalos[horseIndex].name == horse then
      wbh(user_id .. " comprou o cavalo "..horse.. "[INDEX="..horseIndex.."] por ".. config.cavalos[horseIndex].preco)
      hT.horsePrice     = config.cavalos[horseIndex].preco
      hT.player   = tonumber(user_id)
      hT.requirepermission    = config.cavalos[horseIndex].permission
      hT.requirepermissionCondition = false
      if (hT.requirepermission == "nenhum") then
        hT.requirepermission = false
        hT.requirepermissionCondition = true
      else
        hT.requirepermission = true
        hT.requirepermissionCondition = _Framework.HasPermission(user_id, hT.requirepermission)
      end
      if hT.requirepermissionCondition then
        local userHorseTable = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @id", {['@id'] = tonumber(user_id)})
        if _Framework.TryPayment(tonumber(user_id), tonumber(hT.horsePrice))  then
          if userHorseTable and json.encode(userHorseTable[1].horses) ~= '[]' then
            userHorseTable = json.decode(userHorseTable[1].horses)
            if not userHorseTable[horse] then
              userHorseTable[horse] = {['name'] = horseName, ['inventario'] = {}, userStaminaTimes = 0}
              userHorseTable = json.encode(userHorseTable)
              _Framework.SQLExecute("UPDATE xframework_cavalos SET horses = @horses WHERE id = @id", {["@horses"] = userHorseTable, ["@id"] = tonumber(user_id)})
              TriggerClientEvent("xFramework:Notify", source,"sucesso", "[38]Você comprou um novo cavalo. O Nome dele(a) é: "..horseName,10000)
            else
              TriggerClientEvent("xFramework:Notify", source,"negado", "Você já tem este cavalo",10000)
              _Framework.GiveMoney(tonumber(user_id), tonumber(hT.horsePrice) )
            end
          else
            local n = {}
            n[horse] = {['name'] = horseName, ["upgrades"] = {}, ['inventario'] = {}}
            n = json.encode(n)
            _Framework.SQLExecute("INSERT INTO xframework_cavalos(id,horses) VALUES(@id,@horses)", {["@horses"] = n, ["@id"] = tonumber(user_id), ["@horsedata"] = {}})
            TriggerClientEvent("xFramework:Notify", source,"sucesso", "[45]Você comprou um novo cavalo. O Nome dele(a) é: "..horseName,10000)
          end
        else
          TriggerClientEvent("xFramework:Notify", source,"negado", " Você não tem dinheiro suficiente para comprar este cavalo ",10000)
        end
      else
        TriggerClientEvent("xFramework:Notify",source,"negado", " Esse cavalo é própio para alguma permissão/VIP específico ",10000)
      end
    else
      TriggerClientEvent("xFramework:Notify", source, 'negado', "Por algum motivo, esse cavalo não foi encontrado na lista do servidor, reporte o problema juntamente com o print do cavalo selecionado. Obrigado.",10000)
    end
  end
end

function _Framework.DeleteHorse(user_id, horseName)

end

function _Framework.BuyNewVehicle (user_id, vehicle, vehicleName, vehicleIndex)
  local hT = {}
  local source= _Framework.GetUserSource(tonumber(user_id))
  local config= _Framework.HorseConfig()
  if verifyIfExistsAnyHorseWithVehicleNameForUserId(user_id, vehicleName) then
    -- print(json.encode(config.carrocas[vehicleIndex]))
    if config.carrocas[vehicleIndex].name == vehicle then
      wbh(user_id .. " comprou a carroça "..vehicle.. "[INDEX="..vehicleIndex.."] por ".. config.carrocas[vehicleIndex].preco)
      hT.vehiclePrice     = config.carrocas[vehicleIndex].preco
      hT.player   = tonumber(user_id)
      hT.requirepermission    = config.carrocas[vehicleIndex].permission
      hT.requirepermissionCondition = false
      if (hT.requirepermission == "nenhum") then
        hT.requirepermission = false
        hT.requirepermissionCondition = true
      else
        hT.requirepermission = true
        hT.requirepermissionCondition = _Framework.HasPermission(user_id, hT.requirepermission)
      end
      if hT.requirepermissionCondition then
        local uservehicleTable = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @id", {['@id'] = tonumber(user_id)})
        if _Framework.TryPayment(tonumber(user_id), tonumber(hT.vehiclePrice))  then
          if uservehicleTable and json.encode(uservehicleTable[1].vehicles) ~= '[]' then
            uservehicleTable = json.decode(uservehicleTable[1].vehicles)
            if not uservehicleTable[vehicle] then
              uservehicleTable[vehicle] = {['name'] = vehicleName, ['inventario'] = {}}
              uservehicleTable = json.encode(uservehicleTable)
              _Framework.SQLExecute("UPDATE xframework_cavalos SET vehicles = @vehicles WHERE id = @id", {["@vehicles"] = uservehicleTable, ["@id"] = tonumber(user_id)})
              TriggerClientEvent("xFramework:Notify", source,"sucesso", "[38]Você comprou um novo carroça. O Nome dele(a) é: "..vehicleName,10000)
            else
              TriggerClientEvent("xFramework:Notify", source,"negado", "Você já tem este carroça",10000)
              _Framework.GiveMoney(tonumber(user_id), tonumber(hT.vehiclePrice) )
            end
          else
            local n = {}
            n[vehicle] = {['name'] = vehicleName, ['inventario'] = {}}
            n = json.encode(n)
            _Framework.SQLExecute("INSERT INTO xframework_cavalos(id,vehicles) VALUES(@id,@vehicles)", {["@vehicles"] = n, ["@id"] = tonumber(user_id), ["@vehicledata"] = {}})
            TriggerClientEvent("xFramework:Notify", source,"sucesso", "[45]Você comprou um novo carroça. O Nome dele(a) é: "..vehicleName,10000)
          end
        else
          TriggerClientEvent("xFramework:Notify", source,"negado", " Você não tem dinheiro suficiente para comprar este carroça ",10000)
        end
      else
        TriggerClientEvent("xFramework:Notify",source,"negado", " Esse carroça é própio para alguma permissão/VIP específico ",10000)
      end
    else
      TriggerClientEvent("xFramework:Notify", source, 'negado', "Por algum motivo, esse carroça não foi encontrado na lista do servidor, reporte o problema juntamente com o print do carroça selecionado. Obrigado.",10000)
    end
  end
end

function _Framework.GetHorseUpgrades(user_id, horse_name)
  local userHorseTable = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @id", {['@id'] = tonumber(user_id)})
  local userHorseTable = json.decode(userHorseTable[1].horses)
  local selectedhorse = ''
  local selectedhorseupgrades = ''
  if(userHorseTable)then
    for k, v in pairs(userHorseTable) do
      if v["name"] == horse_name then
        selectedhorse = k
        selectedhorseupgrades = v["upgrades"] or false
      end
    end
  end
  return selectedhorseupgrades
end
function _Framework.GetUserHorses(user_id)
  if user_id then
    local cavalos = {}
    local user_horses = _Framework.SQLExecute("SELECT * FROM xframework_cavalos WHERE id = @user_id", {["@user_id"] = user_id})
    user_horses = json.decode(user_horses[1].horses)
    for k, v in pairs(user_horses) do
      -- print(k)
      table.insert(cavalos, k)
    end
    -- print(json.encode(cavalos))
    return cavalos
  end
end

function _Framework.TransferHorse (ownerID, toID, Horse, HorseName, horseIndex)
  if _Framework.IsPlayerOnline(tonumber(toID)) then
    local hT = {}
    local source   = _Framework.GetUserSource(tonumber(ownerID))
    local config   = _Framework.HorseConfig()
    hT.horsePrice  = config.cavalos[horseIndex].preco
    hT.player= tonumber(user_id)
    hT.requirepermission = config.cavalos[horseIndex].permission
    hT.ownerID_data      = _Framework.GetUserData(tonumber(ownerID))
    hT.toID_data         = _Framework.GetUserData(tonumber(toID))
    hT.requirepermissionCondition = false
    if hT.ownerID_data.cavalos then
      if hT.ownerID_data.cavalos[horseIndex] then
        local horseRequirepermission = config.cavalos[horseIndex].permission
        if horseRequirepermission == "nenhum" then
          horseRequirepermission = false
        end
        hT.permissionCondition = false
        if horseRequirepermission then
          if _Framework.HasPermission(tonumber(toID), hT.requirepermission) then
            hT.permissionCondition = true
          else
            hT.permissionCondition = false
          end
        end
        if hT.permissionCondition then
          if tonumber(ownerID) ~= tonumber(toID)  then
            _Cache[ownerID] = {hT.ownerID_data.cavalos[horseIndex].extrastamina, hT.ownerID_data.cavalos[horseIndex].horseId}
            hT.ownerID_data.cavalos[horseIndex] = nil
            hT.toID_data.cavalos[horseIndex]    = {_Cache[ownerID][1], _Cache[ownerID][2]}
            _Cache[ownerID] = nil
          else
            TriggerClientEvent("xFramework:Notify",source,"negado", "Você não pode transferir o cavalo para sí mesmo",10000)
          end
        else
          TriggerClientEvent("xFramework:Notify",source, "negado"," Esse cavalo é própio para alguma permissão/VIP específico  "..toID.. " Não pode receber o cavalo.",10000)
        end
      else
        TriggerClientEvent("xFramework:Notify",source, "negado"," O jogador que deseja transferir o cavalo não tem o cavalo solicitado. ",10000)
      end
    else
      TriggerClientEvent("xFramework:Notify",source, "negado"," O jogador que deseja transferir o cavalo não tem o cavalo solicitado. ",10000)
    end
  else
    local source   = _Framework.GetUserSource(tonumber(ownerID))
    TriggerClientEvent("xFramework:Notify",source, "negado",toID.. " ausente",10000)
  end
end


function _Framework.GetUserHorses(user_id)


end



