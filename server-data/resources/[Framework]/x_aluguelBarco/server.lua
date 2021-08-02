dev = module('Server/CallBack/Callback_Proxy').getInterface('_xFramework')
RegisterServerEvent('elrp:buyboat')
AddEventHandler( 'elrp:buyboat', function ( args )

    local _src   = source
    local _price = args['Price']
    local _level = args['Level']
    local _model = args['Model']

    if not dev.TryPayment(dev.GetUserId(source), _price) then
        TriggerClientEvent("xFramework:Notify", _src,  "negado", "Você não tem dinheiro para isso.")
        return
    end
    local result = dev.SQLExecute( "SELECT * FROM x_barcos WHERE id = @id",{["@id"] = dev.GetUserId(_src)})
        if #result > 0 then
            dev.SQLExecute("UPDATE x_barcos SET boat = @boat WHERE id = @id ", {["@id"] = dev.GetUserId(_src), ["@boat"] = _model})
            TriggerClientEvent("xFramework:Notify", _src,  "sucesso", "Compra efetuada.")
        else
            dev.SQLExecute("INSERT INTO x_barcos ( `id`, `boat` ) VALUES ( @id, @boat )", {["@id"] = dev.GetUserId(_src), ["@boat"] = _model})
            TriggerClientEvent("xFramework:Notify", _src,  "sucesso", "Compra efetuada.")
        end
end)

RegisterServerEvent( 'elrp:dropboat' )
AddEventHandler( 'elrp:dropboat', function ( )

    local _src = source
    local Hasx_barcos = dev.SQLExecute( "SELECT * FROM x_barcos WHERE id = @id", {["@id"] = dev.GetUserId(_src)} )
    if Hasx_barcos[1] then
        local boat = Hasx_barcos[1].boat
        TriggerClientEvent("elrp:spawnBoat", _src, boat)
    end
--end

end )
