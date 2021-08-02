local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
dev = Proxy.getInterface('_xFramework')
RegisterCommand("devonly", function(source, args)
    if dev.HasPermission(dev.GetUserId(source), "dev.permissao") then 
	    TriggerClientEvent('lto_headbucket:BucketActif', source)
    end 
end )

