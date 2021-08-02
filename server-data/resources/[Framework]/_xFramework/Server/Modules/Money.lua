local API = {}
-- wbh(user_id.. " recebeu x "..itemquantidade.. " de "..itemname)

local function wbh(m)
  TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866426003638190170/KJLFmlPg7fEga5fW0TyM7YWz-soWUgsVsI7UWrm3QiPdTOMg8bnNynF0BWD2BVVEcmIn", m)
end
function _Framework.GetUserMoney (user_id)
  return _Framework.GetInventoryItemAmount(user_id, "dinheiro")
end

function _Framework.TryPayment (user_id, quantidade)
  if _Framework.GetUserMoney(tonumber(user_id)) >= tonumber(quantidade) then
    _Framework.TryGetInventoryItem(user_id, "dinheiro", tonumber(quantidade))
    wbh(user_id.. " pagou $"..quantidade.. " para algum outro sistema.")
    return true
  else
    return false
  end
end
function _Framework.GiveMoney (user_id, quantidade)
  _Framework.GiveInventoryItem(user_id, "dinheiro", tonumber(quantidade))
  wbh(user_id.. " recebeu $"..quantidade.. " de dinheiro")
end


-- bank money -==


function _Framework.GetBankMoney(user_id)
    local _query = _Framework.SQLExecute("SELECT * FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
    local bVal = _query[1].banco
    return tonumber(bVal);
end 

function _Framework.TryDeposit(user_id, value)
    if _Framework.GetUserMoney(user_id) >= value and _Framework.TryPayment(user_id, value) then 
       local old_bank_value = _Framework.GetBankMoney(user_id)
       local newValue = old_bank_value + value;
       if newValue < 0 then newValue = 0 end;
       wbh(user_id.. " Depositou $"..value.. " de dinheiro")
       _Framework.SQLExecute("UPDATE xframework_personagens SET banco = @val WHERE id = @id", {["@val"] = newValue, ["@id"] = user_id})
       return true
    end
    return false
end



function  _Framework.TryWithdraw(user_id, value)
  if _Framework.GetBankMoney(user_id) >= value then 
    local old_bank_value = _Framework.GetBankMoney(user_id)
    local newValue = old_bank_value - value;
    if newValue < 0 then newValue = 0 end;
    wbh(user_id.. " Sacou $"..value.. " de dinheiro")
    _Framework.SQLExecute("UPDATE xframework_personagens SET banco = @val WHERE id = @id", {["@val"] = newValue, ["@id"] = user_id})
    _Framework.GiveMoney(user_id, value)
    return true
 end
 return false
end

function _Framework.AddBankMoneyToUser(user_id, value)
    local old_bank_value = _Framework.GetBankMoney(user_id)
    local newValue = old_bank_value + value;
    if newValue < 0 then newValue = 0 end;
    wbh(user_id.. " Recebeu $"..value.. " de dinheiro na conta bancária")
    _Framework.SQLExecute("UPDATE xframework_personagens SET banco = @val WHERE id = @id", {["@val"] = newValue, ["@id"] = user_id})
end

function _Framework.RemoveBankMoneyFromUser(user_id, value)
  local old_bank_value = _Framework.GetBankMoney(user_id)
  local newValue = old_bank_value - value;
  if newValue < 0 then newValue = 0 end;
  wbh(user_id.. " Perdeu $"..value.. " de dinheiro da conta bancária")
  _Framework.SQLExecute("UPDATE xframework_personagens SET banco = @val WHERE id = @id", {["@val"] = newValue, ["@id"] = user_id})
end