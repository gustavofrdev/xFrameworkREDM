local function wbh(m)
  TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866423993006555156/kWyUlaeBohRSZs3PhJZ22WVKNUeT8H340wznfbWFrw1oTYlrh_LAsrW9OW37IdNBrlro", m)
end

local ConfigFile = _Framework.GroupsConfig()
local API = {}
-- print(ConfigFile)
function _Framework.GetUserGroups (user_id)
  local tolerancia = 5000
  local t_ac = 0 
  local MySQL = _Framework
  local grupos = MySQL.SQLExecute('SELECT grupos FROM xframework_personagens WHERE id = @id', {['@id'] = user_id})
  while grupos == 0 do 
    t_ac = t_ac + 1 
    if t_ac >= tolerancia then 
      break; 
    end 
    Wait(0)
  end
  if grupos == 0 then
    return {}
  end

  return json.decode(grupos[1].grupos)
end




function _Framework.GetUserGroupByType (user_id, verify)
  local MySQL = _Framework
  local todosGrupos =
  MySQL.SQLExecute('SELECT grupos FROM xframework_personagens WHERE id = @id', {['@id'] = user_id})
  if todosGrupos == 0 then
    return {}
  end
  local table = todosGrupos[1].grupos
  table = json.decode(table)
  for k, v in pairs(table) do
    local type = ConfigFile.Grupos[k].tipo
    if type == verify then
      return k
    end
  end
end


function _Framework.GetGroupName (group)
  return ConfigFile.Grupos[group].nome
end



function _Framework.SetUserGroup (user_id, group, logs)
  if ConfigFile.Grupos[group] then
    wbh(user_id.. " Recebeu o grupo "..group.. "")
    local MySQL = _Framework
    local source =   _Framework.GetUserSource(user_id)
    local newGroupType = ConfigFile.Grupos[group].tipo
    local actualGroupTypes = _Framework.GetUserGroups(user_id)
    actualGroupTypes = json.encode(actualGroupTypes)
    if actualGroupTypes ~= nil and actualGroupTypes ~= '[]' then
      actualGroupTypes = json.decode(actualGroupTypes)
      for k, v in pairs(actualGroupTypes) do
        if ConfigFile.Grupos[k].tipo == newGroupType and newGroupType ~= 'multiplo' then
          if not logs then 
            TriggerClientEvent('xFramework:Notify',  source, "negado",' O Jogador tem outro grupo do mesmo tipo setado. Sete um grupo com a característica SUPERIOR ou MULTIPLO',10000 )
              break
            end
          break
        else
          -- print(47)
          actualGroupTypes[group] = true
          actualGroupTypes = json.encode(actualGroupTypes)
          -- print(actualGroupTypes)
          MySQL.SQLExecute('UPDATE xframework_personagens SET grupos = @grupos_s WHERE id = @id', {['@grupos_s'] = actualGroupTypes, ['@id'] = user_id} )
          if not logs then 
            TriggerClientEvent('xFramework:Notify', source, "sucesso",' Operação efetuada', 10000)
          end
        end
      end
    else
      local grupos = {}
      grupos[group] = true
      grupos = json.encode(grupos)
      MySQL.SQLExecute('UPDATE xframework_personagens SET grupos = @grupos_s WHERE id = @id', {['@grupos_s'] = grupos, ['@id'] = user_id})
    end
  else
    local source =   _Framework.GetUserSource(user_id)
    if not logs then 
    TriggerClientEvent('xFramework:Notify', source, "negado",' Grupo inexistente ', 10000)
    end
  end
end

function _Framework.RemoveUserGroup (user_id, group, logs)
  local source =   _Framework.GetUserSource(user_id)
  local MySQL = _Framework
  if _Framework.HasGroup(user_id, group) or ConfigFile.Grupos[group] then
    wbh(user_id.. " Perdeu o grupo "..group.. "")
    local playerGroups = _Framework.GetUserGroups(user_id)
    playerGroups[group] = nil
    playerGroups = json.encode(playerGroups)
    MySQL.SQLExecute('UPDATE xframework_personagens SET grupos = @grupos_s WHERE id = @id', {['@grupos_s'] = playerGroups, ['@id'] = user_id} )
    if not logs then 
    TriggerClientEvent('xFramework:Notify', source, "sucesso",' Operação efetuada ', 10000)
    end
  else
    if not logs then 
    TriggerClientEvent('xFramework:Notify', source,"negado", ' Grupo inexistente e/ou jogador não o possuí ', 10000)
    end
  end
end

-- permissao = v2 = _ = 4;


function _Framework.HasPermission (user_id, permissao)

  local hasPermissionSolicited = false
  local playerGroups = _Framework.GetUserGroups(user_id)
  -- playerGroups = json.decode(playerGroups)
  wbh(user_id.. " [Check de permissões]: "..permissao.. "")
  for k, v in pairs(playerGroups) do
    if not ConfigFile.Grupos[k] then
      TriggerClientEvent('xFramework:Notify', _Framework.GetUserSource(user_id),"negado", 'FATAL ERROR: VOCÊ ESTÁ COM UM GRUPO, QUE AGORA, É INEXISTENTE NO ARQUIVO DE CONFIGURAÇÃO DE '..GetCurrentResourceName().. ". CONTATE UM DESENVOLVEDOR OU DONO PARA CORRIGIR ESSE PROBLEMA. string_error: [fail group >> " ..k.. "]", 10000)
      print("fail group >> " ..k)
      break
    end
    local permissoes_this_group = ConfigFile.Grupos[k].permissoes
    for k2, v2 in pairs(permissoes_this_group) do
      if v2 == '*' then return true end;
      if permissao == v2 then
        hasPermissionSolicited = true
      end
    end
  end
  return hasPermissionSolicited
end


function _Framework.HasGroup (user_id, group)

  local hasGroup = false
  local kv = _Framework.GetUserGroups(user_id)
  for k, v in pairs(kv) do
    if not ConfigFile.Grupos[group] then
      break
    end
    if k == group then
      hasGroup = true
    end
  end
  return hasGroup
end

function _Framework.NewCharacter (id, logs)
  local source =   _Framework.GetUserSource(id)
  _Framework.GenerateNewTablesForPlayer(id)
  for k, v in pairs(ConfigFile.StartIDS) do
    -- print(k, id)
    if tonumber(k) == tonumber(id) then
      _Framework.SetUserGroup(id, v[1])
      if not logs then 
      TriggerClientEvent('xFramework:Notify',source,"aviso",' Você é um dos IDs primários, portanto, foi setado o grupo ' .. v[1] .. ' a este personagem',10000)
      end
    end
  end
end

function _Framework.GetUsersByPermission(perm)
  local r = {}
  local _, dec = _Framework.IDSOnline()
  for _, id in pairs(dec) do
    if _Framework.HasPermission(id,  perm) then 
      table.insert(r, id)
       end
    end
    return r
end

function _Framework.GetGroupItemBonus (group)
  return ConfigFile.Grupos[group].BonusItem
end

--> Salário <--
local gSalary = function()
  while true do
      Citizen.Wait(ConfigFile.salaryRecieveTime *60000)
      local _,dec = _Framework.IDSOnline()
      for grupo, groupData in pairs(ConfigFile.Grupos) do
          for _, user_id in pairs(dec) do
              if groupData.salario.ativo then
                  if _Framework.HasGroup(user_id, grupo) then
                    wbh(user_id.. " Recebeu o salário: "..groupData.salario.valor.. " cargo: "..grupo)
                      TriggerClientEvent("xFramework:Notify", _Framework.GetUserSource(user_id), "sucesso", "Você está recebendo seu salário de $".. groupData.salario.valor.. " pelo seu cargo "..grupo.. " Obrigado pelo seus serviços.")
                      _Framework.AddBankMoneyToUser(user_id, groupData.salario.valor)
                 end
              end
          end
      end
   end
end

Citizen.CreateThread(gSalary)