dev = module('Server/CallBack/Callback_Proxy').getInterface('_xFramework')
local valores = {
    {item = 'cerveja', compra = 15, _p = 'cerveja'},
    {item = 'whisky', compra = 15, _p = 'whisky'}
}
RegisterServerEvent('nativeui_bebidas:comprar')
AddEventHandler('nativeui_bebidas:comprar',function(item)
    local source = source
    for _, _v in pairs(valores) do --@
        if item == _v.item then
            if dev.TryPayment(dev.GetUserId(source), _v.compra) then
                local addInv = dev.GiveInventoryItem(dev.GetUserId(source), _v._p, 1)
                if addInv and addInv == "fail" then 
                    dev.GiveMoney(dev.GetUserId(source), _v.compra)
                end
                break
            end
        else
            -- TriggerClientEvent('xFramework:Notify', source, 'aviso', '-você não pode carregar mais itens')
        end
    end
end)


RegisterServerEvent("xFramework_ItemFunction:cerveja")
AddEventHandler("xFramework_ItemFunction:cerveja", function(user_id)
	if dev.TryGetInventoryItem(user_id, "cerveja", 1) then 
		local source = dev.GetUserSource(user_id)
        TriggerClientEvent("cerveja", source)
	end
end)

RegisterServerEvent("xFramework_ItemFunction:whisky")
AddEventHandler("xFramework_ItemFunction:whisky", function(user_id)
	if dev.TryGetInventoryItem(user_id, "whisky", 1) then 
		local source = dev.GetUserSource(user_id)
        TriggerClientEvent("whiskey", source)
	end
end)

