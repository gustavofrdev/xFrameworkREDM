--[[
! Modulo do Inventário propietário da bitnetwork/xframework
? _Framework.Framework().func()
]]
local function wbh(m)
  TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866425277336387631/mmBF1QYy5Nhoud5WiHYrl_2fAdiXRsepC6W9D7QZjlizhpCH-CXugcvxAfash7Msgd4a", m)
end
local API = {}
local Item_F = {}
-- ! [[! Function Decrapted]] ! --
-- function _Framework.RegisterItemFunction(idname, tfunction)
--     print(type(tfunction))
--     if type(tfunction) == "table" then
--     print("^1function " .. json.encode(tfunction) .. " registreada para ".. idname )
--     Item_F[idname] = tfunction
--     else
--         error("O Valor não é uma função. Verifique se "..idname.." está com uma função válida do tipo FUNÇÃO. Função: linha_init 11, function REGISTERITEMFUNCTIONS")
--     end
-- end

local w = {}
local function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
  end

  return false
end

function _Framework.RemoteCreateInventoryItem(item, table)
  print("Criando item remotamente: "..item)
  local InventoryCFG = _Framework.InventoryConfig()
  if not InventoryCFG.Itens[item] then 
    -- wbh("Novo item remoto criado pela framework: ["..item.."]")
    InventoryCFG.Itens[item] = table
    _Framework.UpdateConfig(InventoryCFG)
  end 
end

function _Framework.checkLimitsWithAcressItem(itemname, itemquantidade)
  local user_id = _Framework.GetUserId(source)
  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.inventory then
    -- --(159)
    if userData.PesoMaximo - _Framework.GetInventoryUsingWeight(tonumber(user_id))>= InventoryCFG.Itens[itemname].Peso * tonumber(itemquantidade) then
      return true 
    end
  end
  return false 
end

function _Framework.GetItemPhotoPath(item)
  if string.find(item, "_0x") then
    return "carta_0x"
  end
  local InventoryCFG = _Framework.InventoryConfig()
  if InventoryCFG.Itens[item] and not InventoryCFG.Itens[item].Foto then 
    return item 
  elseif InventoryCFG.Itens[item] and InventoryCFG.Itens[item].Foto then
    return InventoryCFG.Itens[item].Foto
  elseif not InventoryCFG.Itens[item] then 
    return "noitem" 
  end
end

function _Framework.UseInventoryItem(idname, user_id, qnt)
  local InventoryCFG = _Framework.InventoryConfig()
  if InventoryCFG.Itens[idname] then
    local this_item = InventoryCFG.Itens[idname]
    if this_item.Tipo == "Usar" then
      if not string.find(idname, "weapon_") and not string.find(idname, "ammo_") then 
        TriggerEvent(InventoryCFG.Defaults.Item_Event_Prefix_Default..idname,user_id)
      else 
        if string.find(idname, "weapon_") then 
          if idname == "weapon_melee_torch" then _Frameworkclient.useWeapon(_Framework.GetUserSource(user_id), idname) return end
          if _Framework.TryGetInventoryItem(user_id, idname, 1) then 
            _Frameworkclient.useWeapon(_Framework.GetUserSource(user_id), idname)
            local old = _Framework.SQLExecute("SELECT armas_equipadas FROM xframework_personagens WHERE id = @id", {["@id"] =user_id})
            if old[1].armas_equipadas and old[1].armas_equipadas ~= nil and old[1].armas_equipadas ~= "[]" then 
              old = old[1].armas_equipadas
              old = json.decode(old)
              if not has_value(old, idname) then 
                table.insert(old, idname)
              end
              _Framework.SQLExecute("UPDATE xframework_personagens SET armas_equipadas = @bbb WHERE id = @id", {["@bbb"] = json.encode(old), ["@id"] = user_id})
            else 
              local a = {}
              table.insert(a, idname)
              _Framework.SQLExecute("UPDATE xframework_personagens SET armas_equipadas = @bbb WHERE id = @id", {["@bbb"] = json.encode(a), ["@id"] = user_id})
            end
          end
        elseif string.find(string.lower(idname), "ammo_") then 
          if _Framework.TryGetInventoryItem(user_id, idname, qnt) then 
            local userData = _Framework.GetUserData(tonumber(user_id))
            if userData.ammo then 
              if userData.ammo[string.lower(idname)] then 
                userData.ammo[string.lower(idname)] = userData.ammo[string.lower(idname)] + qnt
                _Frameworkclient.giveAmmoByType_2(_Framework.GetUserSource(user_id),string.lower(idname), qnt)
              else 
                userData.ammo[string.lower(idname)] = qnt
                _Frameworkclient.giveAmmoByType_2(_Framework.GetUserSource(user_id),string.lower(idname), qnt)
              end
            else 
              userData.ammo = {}
              userData.ammo[string.lower(idname)] = qnt 
              _Frameworkclient.giveAmmoByType_2(_Framework.GetUserSource(user_id),string.lower(idname), qnt)
            end
          end
          print(json.encode(userData))
        end
      end
    end
  end
end
exports("UseInventoryItem", function(idname)
  return _Framework.UseInventoryItem(idname)
end)


function _Framework.GetItemLabel(idname)
  if string.find(idname, "_0x") then
    idname = idname:match("(.*_0x)")
  end
  local InventoryCFG = _Framework.InventoryConfig()
  return InventoryCFG.Itens[idname].Label
end
exports("GetItemLabel", function(idname)
  return _Framework.GetItemLabel(idname)
end)


function _Framework.GetItemWeight(idname)
  if string.find(idname, "_0x") then
    idname = idname:match("(.*_0x)")
  end
  local InventoryCFG = _Framework.InventoryConfig()
  return InventoryCFG.Itens[idname].Peso
end
exports("GetItemWeight", function(idname)
  return _Framework.GetItemWeight(idname)
end)


function _Framework.GetItemLimit(idname)
  if string.find(idname, "_0x") then
    idname = idname:match("(.*_0x)")
  end
  local InventoryCFG = _Framework.InventoryConfig()
  return InventoryCFG.Itens[idname].Limite
end
exports("GetItemLimit", function(idname)
  return _Framework.GetItemLimit(idname)
end)


function _Framework.GetItemType(idname)
  if string.find(idname, "_0x") then
    idname = idname:match("(.*_0x)")
  end
  local InventoryCFG = _Framework.InventoryConfig()
  return InventoryCFG.Itens[idname].Tipo
end
exports("GetItemType", function(idname)
  return _Framework.GetItemLimit(idname)
end)


function _Framework.GetItemDesc(idname)
  if string.find(idname, "_0x") then
    idname = idname:match("(.*_0x)")
  end
  local InventoryCFG = _Framework.InventoryConfig()
  return InventoryCFG.Itens[idname].Descricao
end
exports("GetItemDesc", function(idname)
  return _Framework.GetItemLimit(idname)
end)


function _Framework.TryGetInventoryItem(user_id, itemname, quantidade)


  local source = _Framework.GetUserSource(user_id)
  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.inventory then
    if not userData.inventory[itemname] then
      return false
    end
    if tonumber(userData.inventory[itemname].amount) >= tonumber(quantidade) then
      userData.inventory[itemname].amount = userData.inventory[itemname].amount - quantidade
  
      local visual = itemname
      if string.find(visual, "_0x") then
        visual = visual:match("(.*_0x)")
        visual = string.gsub(visual, '_0x', "")    
      TriggerClientEvent("xFramework:Notify", source,"aviso","- x"..quantidade.. " "..visual,10000)
      else 
        if itemname ~= "dinheiro" then 
          TriggerClientEvent("xFramework:Notify", source,"aviso","- x"..quantidade.. " ".._Framework.GetItemLabel(itemname),10000)
        else
          TriggerClientEvent("xFramework:Notify", source,"aviso","Você pagou US$"..quantidade,10000)
        end
      end
      if userData.inventory[itemname].amount <= 0 then
        userData.inventory[itemname] = nil
      end
      return true
    else
      return false
    end
  end
end
exports("TryGetInventoryItem", function(user_id, itemname, quantidade)
  return _Framework.TryGetInventoryItem(user_id, itemname, quantidade)
end)

function _Framework.GetInventoryItemAmount(user_id, itemname)
  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.inventory then
    if userData.inventory[itemname] then
      return userData.inventory[itemname].amount or 0
    else return 0
    end
  end
end

exports("GetInventoryItemAmount", function(user_id, itemname)
  return _Framework.GetInventoryItemAmount(user_id, itemname)
end)
function _Framework.GetInventory(user_id)
  return _Framework.GetUserData(tonumber(user_id)).inventory
end
exports("GetInventory", function(user_id)
  return _Framework.GetInventory(user_id)
end)
function _Framework.GetInventoryUsingWeight(user_id)
  local InventoryCFG = _Framework.InventoryConfig().Itens
  local value_total = 0
  for k,v in pairs(_Framework.GetInventory(user_id)) do
    if string.find(k, "_0x") then
      k = k:match("(.*_0x)")
    end
    value_total = value_total + InventoryCFG[k].Peso * v.amount
  end
  return value_total
end
exports("GetInventoryUsingWeight", function(user_id)
  return _Framework.GetInventoryUsingWeight(user_id)
end)

function _Framework.ClearInventory(user_id)

  local source = _Framework.GetUserSource(user_id)
  local userData = _Framework.GetUserData(tonumber(user_id))
  TriggerClientEvent("xFramework:Notify", source,"aviso"," Seu inventário foi resetado",10000)
   wbh(user_id.. " teve seu inventário limpo.")
  userData.inventory = {}
end
exports("ClearInventory", function(user_id)
  return _Framework.ClearInventory(user_id)
end)


function _Framework.SetInventoryMaxWeight(user_id, pesoMaximo)

  local source = _Framework.GetUserSource(user_id)

  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.PesoMaximo then
    userData.PesoMaximo = tonumber(pesoMaximo)
  else
    userData.PesoMaximo = {}
    userData.PesoMaximo = tonumber(pesoMaximo)
  end
end
exports("SetInventoryMaxWeight", function(user_id, pesoMaximo)
  return _Framework.SetInventoryMaxWeight(user_id, pesoMaximo)
end)

function _Framework.AddInventoryWeightBonus(user_id, Bonus)

  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.PesoMaximo then
    userData.PesoMaximo = tonumber(userData.PesoMaximo+Bonus)
  end
end
function _Framework.GetInventoryMaxWeight(user_id)

  local userData = _Framework.GetUserData(tonumber(user_id))
  if userData.PesoMaximo then
    return tonumber(math.ceil(userData.PesoMaximo))
  else
    return 0
  end
end
exports("GetInventoryMaxWeight", function(user_id)
  return _Framework.GetInventoryMaxWeight(user_id)
end)


function _Framework.GiveInventoryItem(user_id, itemname, itemquantidade, ignoreLimits)
  local variable_item = false
  local maybe_original_name = itemname
  if string.find(itemname, "_0x") then
    itemname = itemname:match("(.*_0x)")
  end
  if ignoreLimits == nil or not ignoreLimits then ignoreLimits = false end;

  --(itemname)
  local source = _Framework.GetUserSource(user_id)
  -- ("src:", source)
  local userData = _Framework.GetUserData(tonumber(user_id))
  -- (user_id, itemname, itemquantidade, userData.inventory["maconha"])
  local InventoryCFG = _Framework.InventoryConfig()
  if InventoryCFG.Itens[itemname] then
    if userData.inventory then
      -- --(159)
      if ignoreLimits or userData.PesoMaximo - _Framework.GetInventoryUsingWeight(tonumber(user_id))>= InventoryCFG.Itens[itemname].Peso * tonumber(itemquantidade) then
        if userData.inventory[maybe_original_name] then
          if InventoryCFG.Itens[itemname].Limite == -1 then 
            InventoryCFG.Itens[itemname].Limite = 999999999999999999
          end
          if userData.inventory[maybe_original_name].amount + tonumber(itemquantidade) <= InventoryCFG.Itens[itemname].Limite then

            userData.inventory[maybe_original_name].amount = userData.inventory[maybe_original_name].amount + tonumber(itemquantidade)
            wbh(user_id.. " recebeu x "..itemquantidade.. " de "..itemname)
            if itemname ~= "dinheiro" then 
              TriggerClientEvent("xFramework:Notify", source,"aviso","+ x"..itemquantidade.. " ".._Framework.GetItemLabel(itemname),10000)
            else
              TriggerClientEvent("xFramework:Notify", source,"aviso","Você recebeu US$"..itemquantidade,10000)
            end
          else
            TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode adicionar tantos ".._Framework.GetItemLabel(itemname).. " ao seu inventário. O limite para este item é de ".._Framework.GetItemLimit(itemname).. " Você iria obter, no total, "..userData.inventory[maybe_original_name].amount + tonumber(itemquantidade),10000)
            return "fail"
          end
        else
          userData.inventory[maybe_original_name] = {["amount"] = tonumber(itemquantidade)}
          local visual = itemname
          if string.find(visual, "_0x") then
            visual = visual:match("(.*_0x)")
            visual = string.gsub(visual, '_0x', "")
            wbh(user_id.. " recebeu x "..itemquantidade.. " de "..itemname)
            TriggerClientEvent("xFramework:Notify", source,"aviso","+ x"..itemquantidade.. " "..visual,10000)
          else 
            wbh(user_id.. " recebeu x "..itemquantidade.. " de "..itemname)
            if itemname ~= "dinheiro" then 
              TriggerClientEvent("xFramework:Notify", source,"aviso","+ x"..itemquantidade.. " ".._Framework.GetItemLabel(itemname),10000)
            else
              TriggerClientEvent("xFramework:Notify", source,"aviso","Você recebeu US$"..itemquantidade,10000)
            end
          end
        end
      else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você passou do seu peso limite do inventário",10000)
          return "fail"

      end
    else
      -- --(172)
      if ignoreLimits or userData.PesoMaximo - _Framework.GetInventoryUsingWeight(tonumber(user_id)) >= InventoryCFG.Itens[itemname].Peso * tonumber(itemquantidade) then
        if InventoryCFG.Itens[itemname].Limite == -1 then 
          InventoryCFG.Itens[itemname].Limite = 999999999999999999999999
        end
        if ignoreLimits or tonumber(itemquantidade) < InventoryCFG.Itens[itemname].Limite then
          userData.inventory = {}
          userData.inventory[maybe_original_name] = {["amount"] = tonumber(itemquantidade)}
        else
          TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode adicionar tantos "..itemname.. " ao seu inventário. O limite para este item é de ".._Framework.GetItemLimit(itemname).. " Você iria obter, no total, "..tonumber(itemquantidade),10000)
          return "fail"
        end
      else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você passou do seu peso limite do inventário",10000)
          return "fail"
      end
    end
  else
    TriggerClientEvent("xFramework:Notify", source,"negado"," O item requisitado para ser inserido no seu inventário não existe. 0x150",10000)
  end
end

exports("GiveInventoryItem", function(user_id, itemname, itemquantidade)
  return _Framework.GiveInventoryItem(user_id, itemname, itemquantidade)
end)
