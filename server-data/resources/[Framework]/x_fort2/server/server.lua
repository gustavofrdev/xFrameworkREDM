local FrameworkSV = module('Server/CallBack/Callback_Proxy').getInterface('_xFramework')

RegisterServerEvent('AT_bountyhunting:AddSomeMoney')
AddEventHandler('AT_bountyhunting:AddSomeMoney', function()
  local source = source
  local price = Config.Price
  FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), price)
end)
