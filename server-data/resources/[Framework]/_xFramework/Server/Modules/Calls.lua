-- local Proxy = module("Server/CallBack/Callback_Proxy")
-- x_medicosSv = Proxy.getInterface("x_medicos")
-- x_policiaSv = Proxy.getInterface("x_policia")
RegisterCommand("chamar", function(source, args)
    local c = _Framework.CallConfig()
    if args[1] == "medico" then 
        -- if x_medicosSv.any() then TriggerClientEvent("xFramework:Notify", source, "negado", "Já há um chamado ativo. Tente novamente em alguns segundos ") return end
        local r = os.time()
        local n = _Framework.GetUserName(_Framework.GetUserId(source))
        local id =  _Framework.GetUserId(source)
        TriggerClientEvent(c.EventSintax..":medico", -1, n, id, r)
    elseif args[1] == "policia" then 
    --     if x_policiaSv.any() then TriggerClientEvent("xFramework:Notify", source, "negado", "Já há um chamado ativo. Tente novamente em alguns segundos ") return end
        local r = os.time()
        local n = _Framework.GetUserName(_Framework.GetUserId(source))
        local id =  _Framework.GetUserId(source)
        TriggerClientEvent(c.EventSintax..":policia", -1, n, id, r)
    elseif args[1] == "chofer" then
        local r = os.time()
        local n = _Framework.GetUserName(_Framework.GetUserId(source))
        local id =  _Framework.GetUserId(source)
        TriggerClientEvent(c.EventSintax..":chofer", -1, n, id, r)
    end
end)

