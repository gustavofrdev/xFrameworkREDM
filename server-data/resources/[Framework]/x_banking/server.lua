local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
x_bankingSV = Proxy.getInterface('x_banking')
x_bankingCL = Tunnel.getInterface('x_banking')

FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_banking', Function)
Tunnel.bindInterface('x_banking', Function)

function Function.Withdraw(amount)
    local source = source
    if amount ~= nil then 
        local user_id = FrameworkSV.GetUserId(source)
        if FrameworkSV.TryWithdraw(user_id, amount) then 
            TriggerClientEvent("xFramework:Notify", source, "sucesso", "Saque efetuado")
        end
    end
end

function Function.Deposit(amount)
    local source = source
    if amount ~= nil then 
        local user_id = FrameworkSV.GetUserId(source)
        if FrameworkSV.TryDeposit(user_id, amount) then 
            TriggerClientEvent("xFramework:Notify", source, "sucesso", "Deposito efetuado")
        end
    end
end

function Function.getBalance()
    print(FrameworkSV.GetUserId(source))
    return FrameworkSV.GetBankMoney(FrameworkSV.GetUserId(source));
end

function Function.TransferMoney(amount, id)
    local source = source
    local user_id = FrameworkSV.GetUserId(source)
    if id == user_id then TriggerClientEvent("xFramework:Notify", source,"aviso", "Você não pôde transferir para "..id.. " :: O id do alvo é o mesmo que o seu. <0x0>") return end;
    if not FrameworkSV.PlayerExists(tonumber(id)) then TriggerClientEvent("xFramework:Notify", source,"aviso", "Você não pôde transferir para "..id.. " :: Este jogador não existe. <0x1>") return end;
    if not FrameworkSV.IsPlayerOnline(tonumber(id)) then TriggerClientEvent("xFramework:Notify", source,"aviso", "Você não pôde transferir para "..id.. " :: Jogador offline. <0x2>") return end;
    id = tonumber(id);
    amount = tonumber(amount);
    local userBankMoney = FrameworkSV.GetBankMoney(user_id);
    if userBankMoney >= amount then 
        FrameworkSV.RemoveBankMoneyFromUser(user_id, amount)
        FrameworkSV.AddBankMoneyToUser(id, amount)
        TriggerClientEvent("xFramework:Notify", source,"aviso", "Você enviou $"..amount.. " para "..FrameworkSV.GetUserName(id))
        TriggerClientEvent("xFramework:Notify", FrameworkSV.GetUserSource(id), "aviso", "Você recebeu $"..amount.." de "..FrameworkSV.GetUserName(id))
    end
end

function Function.GetUserName()
    return FrameworkSV.GetUserName(FrameworkSV.GetUserId(source));
end 
