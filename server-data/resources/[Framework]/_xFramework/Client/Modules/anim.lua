
-------------------------------------------------------------------------------------
-- BACKSPACE PARA PARAR ANIMAÇÃO
-------------------------------------------------------------------------------------
local cancelando = false 
RegisterNetEvent("cancelando")
AddEventHandler("cancelando", function(s)
  cancelando = s --[[ type: bool ]]
end)
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if (IsControlJustPressed(0,0x156F7119)) and not cancelando  then
        if not IsEntityDead(PlayerPedId()) then
          Wait(100)
          ClearPedTasks(PlayerPedId())
          SetCurrentPedWeapon(GetPlayerPed(), -1569615261, true)
        end
      end
    end
    end)
    
    
    -------------------------------------------------------------------------------------
    -- SUGESTÕES DE ANIMACÕES
    ------------------------------------------------------------------------------------
    Citizen.CreateThread(function()
    
    TriggerEvent('chat:addSuggestion', '/sentar', 'Opções de sentar', {{ name="sentar até sentar11", help="Available types: Blizzard, Clouds, Drizzle, Fog, GroundBlizzard, Hail, HighPressure, Hurricane, Misty, Overcast, OvercastDark, Rain, Sandstorm, shower, sleet, snow, snowclearing, snowlight, sunny, thunder, thunderstorm, and whiteout."}})
    
    end)
    
    Citizen.CreateThread(function()
    
    TriggerEvent('chat:addSuggestion', '/dancar', 'Opções de danças', {{ name="dançar até dançar86", help="Available types: Blizzard, Clouds, Drizzle, Fog, GroundBlizzard, Hail, HighPressure, Hurricane, Misty, Overcast, OvercastDark, Rain, Sandstorm, shower, sleet, snow, snowclearing, snowlight, sunny, thunder, thunderstorm, and whiteout."}})
    
    end)
    
    -------------------------------------------------------------------------------------
    -- ANIMAÇÃO
    ------------------------------------------------------------------------------------
    RegisterCommand('dancar86', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance')
    while not HasAnimDictLoaded('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance', 'dance_bounty_02', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar85', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance')
    while not HasAnimDictLoaded('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance', 'dance_bounty_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar84', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_male', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar83', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem3', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar82', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem2', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar81', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar80', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem0', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar79', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar78', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar77', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar76', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar75', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@old@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@old@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@old@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar74', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@old@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@old@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@old@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar73', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar72', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar71', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar70', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar69', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@a@male@unarmed@full_looped', 'action_alt1_rf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar68', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar67', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full_looped', 'action_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar66', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    
    RegisterCommand('dancar65', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar64', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar63', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_left')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_left') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_left', 'high_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar62', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar61', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@old@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@old@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@old@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar60', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@b@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar59', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@formal@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@formal@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@formal@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar58', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar57', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar56', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar55', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar54', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar53', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'action_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar52', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar51', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar50', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full_looped', 'action_back_fwd', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar49', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full_looped', 'action_alt1_front_bwd', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar48', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full_looped', 'action_alt1_back_fwd', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar47', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'med_02', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar46', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'med_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar45', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'low_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar44', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'high_02', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar43', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'high_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar42', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar41', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar40', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar39', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar38', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt2_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar37', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt1_rf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar36', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt1_rf_back', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar35', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt1_lf_mid', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar34', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt1_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar33', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@formal@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@formal@a@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@formal@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar32', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full', 'fullbody_alt1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar31', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar30', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full', 'fullbody_alt1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar29', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar28', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar27', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar26', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt2_rf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar25', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt2_fl', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar24', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt1_rf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar23', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar22', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@sworddance@act3_p1')
    while not HasAnimDictLoaded('script_shows@sworddance@act3_p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@sworddance@act3_p1', 'dancer_sworddance', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar21', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_male', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar20', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem4', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar19', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem3', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar18', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem2', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar17', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem0', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar16', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar15', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@snakedancer@act1_p1')
    while not HasAnimDictLoaded('script_shows@snakedancer@act1_p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@snakedancer@act1_p1', 'kiss_win_dancer', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar14', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@snakedancer@act1_p1')
    while not HasAnimDictLoaded('script_shows@snakedancer@act1_p1') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@snakedancer@act1_p1', 'dance_dancer', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar13', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@reacts')
    while not HasAnimDictLoaded('script_shows@cancandance@reacts') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@reacts', 'dancer_react_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar12', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_dancing@female_aidle_c')
    while not HasAnimDictLoaded('amb_misc@world_human_dancing@female_aidle_c') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_dancing@female_aidle_c', 'idle_g', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar11', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@base')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@base') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@base', 'base', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar10', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@female@base')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@female@base') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@female@base', 'base', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar9', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_c', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar8', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_a', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar7', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_f', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_e', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_b') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_b', 'idle_e', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_b') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('dancar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_a') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    --- dancas
    
    RegisterCommand('gesticular', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@sworddance@shw_swrd_int')
    while not HasAnimDictLoaded('script_shows@sworddance@shw_swrd_int') do
      Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_shows@sworddance@shw_swrd_int', 'mc_intro', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end, false)
    
    RegisterCommand('martelo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE'), -1, true, false, false, false)
    end)
    
    RegisterCommand('martelo2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_SMALL'), -1, true, false, false, false)
    end)
    
    RegisterCommand('saco', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SACK_OUT_CART_TARP'), -1, true, false, false, false)
    Wait(400)
    ClearPedTasks(PlayerPedId())
    end)
    
    RegisterCommand('saco2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SACK_IN_CART_TARP'), -1, true, false, false, false)
    end)
    
    RegisterCommand('limparcopo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BARTENDER_CLEAN_GLASS'), -1, true, false, false, false)
    end)
    
    RegisterCommand('anotar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false)
    end)
    
    RegisterCommand('varrer', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BROOM_WORKING'), -1, true, false, false, false)
    end)
    ---------------------------
    
    RegisterCommand('violao', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GUITAR_UPBEAT'), -1, true, false, false, false)
    end)
    
    RegisterCommand('violao2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_SEAT_CHAIR_GUITAR'), -1, true, false, false, false)
    end)
    
    RegisterCommand('banjo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_SEAT_CHAIR_BANJO'), -1, true, false, false, false)
    end)
    
    RegisterCommand('deitar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, true, false, false, false)
    end)
    
    RegisterCommand('deitar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_PILLOW'), -1, true, false, false, false)
    end)
    
    RegisterCommand('deitar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_PILLOW_NO_PILLOW'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WASH_DISHES_TABLE_LEFT_GRAB_DISH_FEMALE_A'), -1, true, false, false, false)
    end)
    
    RegisterCommand('rezar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_GRAVE_MOURNING_KNEEL'), -1, true, false, false, false)
    end)
    
    RegisterCommand('rezar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_GRAVE_MOURNING'), -1, true, false, false, false)
    end)
    
    RegisterCommand('mijar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PEE'), -1, true, false, false, false)
    end)
    
    RegisterCommand('esperar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SHOP_BROWSE_COUNTER'), -1, true, false, false, false)
    end)
    
    RegisterCommand('esperar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STAND_WAITING'), -1, true, false, false, false)
    end)
    
    RegisterCommand('cruzarbraco', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STARE_STOIC'), -1, true, false, false, false)
    end)
    
    RegisterCommand('vomitar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_VOMIT_KNEEL'), -1, true, false, false, false)
    end)
    
    RegisterCommand('vomitar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_VOMIT'), -1, true, false, false, false)
    end)
    
    RegisterCommand('trompete', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_TRUMPET'), -1, true, false, false, false)
    end)
    
    RegisterCommand('fumar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SMOKE_CIGAR'), -1, true, false, false, false)
    end)
    
    RegisterCommand('fumar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SMOKE_INTERACTION'), -1, true, false, false, false)
    end)
    
    RegisterCommand('fumar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SMOKE'), -1, true, false, false, false)
    end)
    
    RegisterCommand('leque', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FAN'), -1, true, false, false, false)
    end)
    
    RegisterCommand('leque2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FAN_MALE_SAL1'), -1, true, false, false, false)
    end)
    
    RegisterCommand('observar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BADASS'), -1, true, false, false, false)
    end)
    
    RegisterCommand('observar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STERNGUY_IDLES'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE_BEER'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE_JD'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE_JD'), -1, true, false, false, false)
    end)
    
    RegisterCommand('beber4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_DRINK_FLASK'), -1, true, false, false, false)
    end)
    RegisterCommand('beber5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_DRINK_CHAMPAGNE'), -1, true, false, false, false)
    end)
    RegisterCommand('beber6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_DRINKING'), -1, true, false, false, false)
    end)
    
    RegisterCommand('cafe', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_COFFEE_DRINK'), -1, true, false, false, false)
    end)
    
    RegisterCommand('amolar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WHITTLE'), -1, true, false, false, false)
    end)
    RegisterCommand('amolar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_TABLE_SHARPEN_KNIFE'), -1, true, false, false, false)
    end)
    RegisterCommand('arma', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_CHECK_PISTOL'), -1, true, false, false, false)
    end)
    RegisterCommand('jornal', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BARREL'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_RIGHT'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_RIGHT_HAND_PLANTED'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WALL'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WALL_NO_PROPS'), -1, true, false, false, false)
    end)
    RegisterCommand('encostar6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BAR_DRINK_BARTENDER'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_FENCE_FWD_CHECK_OUT_LIVESTOCK'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_NO_PROPS'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_RAILING_DRINKING'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_LEFT'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_DRINKING'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar7', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_SMOKING'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar8', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_INTERACTION'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar9', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_DYNAMIC'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar10', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_RAILING'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar11', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_WALL_LEFT'), -1, true, false, false, false)
    end)
    RegisterCommand('escorar12', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_WALL_RIGHT'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FIRE_SIT'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_BACK_EXHAUSTED'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_FALL_ASLEEP'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_DRINK'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_DRINK_DRUNK'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar7', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_SMOKE'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar8', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar9', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READING_BOOK_STOW'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar10', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER'), -1, true, false, false, false)
    end)
    RegisterCommand('sentar11', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_WHITTLE'), -1, true, false, false, false)
    end)
    
    RegisterCommand('alimentar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FEED_CHICKEN'), -1, true, false, false, false)
    end)
    
    RegisterCommand('alimentar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FEED_PIGS'), -1, true, false, false, false)
    end)
    
    RegisterCommand('escovar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_HORSE_TEND_BRUSH_LINK'), -1, true, false, false, false)
    end)
    
    RegisterCommand('agua', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_FILL'), -1, true, false, false, false)
    end)
    
    RegisterCommand('agua2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), -1, true, false, false, false)
    end)
    
    RegisterCommand('cesto', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_COTTONBOX_DUMP'), -1, true, false, false, false)
    end)
    
    RegisterCommand('feno', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PITCH_HAY_SCOOP'), -1, true, false, false, false)
    end)
    
    RegisterCommand('feno2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PITCH_HAY_SPREAD'), -1, true, false, false, false)
    end)
    
    RegisterCommand('lenha', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLING_PUT_DOWN'), -1, true, false, false, false)
    end)
    
    RegisterCommand('lenha2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLING_PUT_DOWN_EMPTY'), -1, true, false, false, false)
    end)



    Citizen.CreateThread( function()
      while true do
          Citizen.Wait(0)
          if IsControlJustPressed(0, 0x8CC9CD42) then -- x
              local playerPed = PlayerPedId()
              if not IsEntityDead(playerPed) and not Citizen.InvokeNative(0x9682F850056C9ADE, playerPed) then
                  local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"

                  if not IsEntityPlayingAnim(playerPed, animDict, "hands_up_loop", 3) then
                      if not HasAnimDictLoaded(animDict) then
                          RequestAnimDict(animDict)

                          while not HasAnimDictLoaded(animDict) do
                              Citizen.Wait(0)
                          end
                      end

                      TaskPlayAnim(playerPed, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                      RequestAnimDict(animDict)
                  else
                      ClearPedSecondaryTask(playerPed)
                  end
              end
          end
      end
  end)

Citizen.CreateThread( function()
      while true do
          Citizen.Wait(0)
          if IsControlJustPressed(0, 0xF3830D8E) then -- B
              local playerPed = PlayerPedId()
             -- if not IsEntityDead(playerPed) and not Citizen.InvokeNative(0x9682F850056C9ADE, playerPed) then
                  local animDict = "mech_loco_m@generic@reaction@pointing@unarmed@stand"

                  if not IsEntityPlayingAnim(playerPed, animDict, "point_fwd_0", 3) then
                      if not HasAnimDictLoaded(animDict) then
                          RequestAnimDict(animDict)

                          while not HasAnimDictLoaded(animDict) do
                              Citizen.Wait(100)
                          end
                      end

                      TaskPlayAnim(playerPed, animDict, "point_fwd_0", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                      RequestAnimDict(animDict)
          --Citizen.Wait(1200)
                  else
                      ClearPedSecondaryTask(playerPed)
                  end
            --  end
          end
      end
  end)	


  --> Anim 2


  
----Uncomment to allow placement of a camera prop, change cords to wherever you want, link to coords or usable item, your choice, code all works.



-- -- Citizen.CreateThread(function()
-- -- 	while true do
-- -- 		Citizen.Wait(1)
-- -- 		local coords = GetEntityCoords(PlayerPedId())
-- --     if (Vdist(coords.x, coords.y, coords.z, -286.3942, 796.4553, 118.8803) < 2.0) then
-- --             DrawTxt("Press [~e~G~q~] to Place Camera.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
-- --             if IsControlJustReleased(0, 0x760A9C6F) then -- g
-- --                 TriggerEvent("camera:deploy")
-- --                 --print('openedwarmenu')

-- --             end
-- --         end
-- --     end
-- -- end)

-- function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
--     local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
--    SetTextScale(w, h)
--    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
--    SetTextCentre(centre)
--    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
--    Citizen.InvokeNative(0xADA9255D, 10);
--    DisplayText(str, x, y)
-- end




function FPrompt(text, button, hold)
  Citizen.CreateThread(function()
      proppromptdisplayed=false
      PropPrompt=nil
      local str = text or "Cancelar Animação"
      local buttonhash = button or 0x3B24C470
      local holdbutton = hold or false
      PropPrompt = PromptRegisterBegin()
      PromptSetControlAction(PropPrompt, buttonhash)
      str = CreateVarString(10, 'LITERAL_STRING', str)
      PromptSetText(PropPrompt, str)
      PromptSetEnabled(PropPrompt, false)
      PromptSetVisible(PropPrompt, false)
      PromptSetHoldMode(PropPrompt, holdbutton)
      PromptRegisterEnd(PropPrompt)
  end)
end

function LMPrompt(text, button, hold)
  Citizen.CreateThread(function()
      UsePrompt=nil
      local str = text or "Use"
      local buttonhash = button or 0x07B8BEAF
      local holdbutton = hold or false
      UsePrompt = PromptRegisterBegin()
      PromptSetControlAction(UsePrompt, buttonhash)
      str = CreateVarString(10, 'LITERAL_STRING', str)
      PromptSetText(UsePrompt, str)
      PromptSetEnabled(UsePrompt, false)
      PromptSetVisible(UsePrompt, false)
      PromptSetHoldMode(UsePrompt, holdbutton)
      PromptRegisterEnd(UsePrompt)
  end)
end

function EPrompt(text, button, hold)
  Citizen.CreateThread(function()
      ChangeStance=nil
      local str = text or "Use"
      local buttonhash = button or 0xD51B784F
      local holdbutton = hold or false
      ChangeStance = PromptRegisterBegin()
      PromptSetControlAction(ChangeStance, buttonhash)
      str = CreateVarString(10, 'LITERAL_STRING', str)
      PromptSetText(ChangeStance, str)
      PromptSetEnabled(ChangeStance, false)
      PromptSetVisible(ChangeStance, false)
      PromptSetHoldMode(ChangeStance, holdbutton)
      PromptRegisterEnd(ChangeStance)
  end)
end

--Proximity Prompt for taking down camera
function SetupCameraPrompt()
  Citizen.CreateThread(function()
      cameraprompt=false
      CameraPickup=nil
      local str = 'Take Down Camera'
      CameraPickup = PromptRegisterBegin()
      PromptSetControlAction(CameraPickup, 0x3B24C470)
      str = CreateVarString(10, 'LITERAL_STRING', str)
      PromptSetText(CameraPickup, str)
      PromptSetEnabled(CameraPickup, false)
      PromptSetVisible(CameraPickup, false)
      PromptSetHoldMode(CameraPickup, true)
      PromptRegisterEnd(CameraPickup)
  end)
end

--Places Camera Prop, Triggers Camera Animation, and removes Camera from Inventory
RegisterNetEvent('camera:deploy')
AddEventHandler('camera:deploy', function(source)
  local _source = source
if camera == nil then
  local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), -0.06, 0.75, -1.1))
  camera = CreateObject(GetHashKey("P_CAMERA01X"), x,y,z, true, false, true)
  SetEntityHeading(camera, GetEntityHeading(PlayerPedId())-180)
  Anim(PlayerPedId(),"script_rc@masn@leadout@rc4","idle_base_mason",3500,1)
  ExecuteCommand('close') -- Close the Inventory Window
end
end)

--Allows for pickup of camera: removes prop & adds back into inventory
Citizen.CreateThread(function(source)
local _source = source
local player = PlayerPedId()
  SetupCameraPrompt()
while true do
  Citizen.Wait(1000)
  local coordsf = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.45, 0.0)
      local cameraprop = GetClosestObjectOfType(coordsf, 1.0, GetHashKey("P_CAMERA01X"), false)
      if cameraprop ~= 0 then
    if cameraprompt == false then
      PromptSetEnabled(CameraPickup, true)
      PromptSetVisible(CameraPickup, true)
      cameraprompt = true
    end
    if PromptHasHoldModeCompleted(CameraPickup) then
      PromptSetEnabled(CameraPickup, false)
      PromptSetVisible(CameraPickup, false)
      cameraprompt = false
      DeleteEntity(camera)
      camera = nil
      TriggerServerEvent('prop:camerapickup')
      StopAnim("script_rc@masn@leadout@rc4","idle_base_mason")
    end
  else
    if cameraprompt == true then
        PromptSetEnabled(CameraPickup, false)
        PromptSetVisible(CameraPickup, false)
        cameraprompt = false
    end
          Wait(3000)
  end
end
end)

--Ledger animation
RegisterNetEvent('prop:ledger')
AddEventHandler('prop:ledger', function() 
  FPrompt("Cancelar Animação", 0x3B24C470, false)
  ExecuteCommand('close')
      
  RequestAnimDict("amb_work@world_human_write_notebook@female_a@idle_c")
  while not HasAnimDictLoaded("amb_work@world_human_write_notebook@female_a@idle_c") do
      Citizen.Wait(100)
  end

  if not IsEntityPlayingAnim(ped, "amb_work@world_human_write_notebook@female_a@idle_c", "idle_h", 3) then
      local ped = PlayerPedId()
      local male = IsPedMale(ped)
      local ledger = CreateObject(GetHashKey('P_AMB_CLIPBOARD_01'), x, y, z, true, true, true)
      local pen = CreateObject(GetHashKey('P_PEN01X'), x, y, z, true, true, true)
      local lefthand = GetEntityBoneIndexByName(ped, "SKEL_L_Hand")
      local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Hand")
      Wait(100)
      if male then
          AttachEntityToEntity(pen, ped, righthand, 0.105, 0.055, -0.13, -5.0, 0.0, 0.0, true, true, false, true, 1, true)
          AttachEntityToEntity(ledger, ped, lefthand, 0.17, 0.07, 0.08, 80.0, 160.0, 180.0, true, true, false, true, 1, true)
      else
          AttachEntityToEntity(pen, ped, righthand, 0.095, 0.045, -0.095, -5.0, 0.0, 0.0, true, true, false, true, 1, true)
          AttachEntityToEntity(ledger, ped, lefthand, 0.17, 0.07, 0.08, 70.0, 155.0, 185.0, true, true, false, true, 1, true)
      end
      Anim(PlayerPedId(),"amb_work@world_human_write_notebook@female_a@idle_c","idle_h",-1,31)
      Wait(1000)
    if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      proppromptdisplayed = true
    end

      while IsEntityPlayingAnim(ped, "amb_work@world_human_write_notebook@female_a@idle_c", "idle_h", 3) do
          Wait(1)
      if IsControlJustReleased(0, 0x3B24C470) then
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
        proppromptdisplayed = false
        StopAnimTask(PlayerPedId(), 'amb_work@world_human_write_notebook@female_a@idle_c', "idle_h", 1.0)
        DeleteEntity(ledger)
              DeleteEntity(pen)
        break
      end
      end
      PromptSetEnabled(PropPrompt, false)
  PromptSetVisible(PropPrompt, false)
  proppromptdisplayed = false
  StopAnimTask(PlayerPedId(), 'amb_work@world_human_write_notebook@female_a@idle_c', "idle_h", 1.0)
  DeleteEntity(ledger)
      DeleteEntity(pen)
      RemoveAnimDict("amb_work@world_human_write_notebook@female_a@idle_c")
  end
end)


---Animations for Drinkin Booze, I dont use since i use poke_licor, but might be of use for helpful snippets


-- --Beer drinking animation
-- RegisterNetEvent('prop:beer')
-- AddEventHandler('prop:beer', function() 
--     PlaySoundFrontend("Core_Full", "Consumption_Sounds", true, 0)
-- 	ExecuteCommand('close')
--     FPrompt("Finish Drinking", 0x3B24C470, false)
--     local ped = PlayerPedId()
--     local male = IsPedMale(ped)
--     local x,y,z = table.unpack(GetEntityCoords(ped, true))
--     local beer = CreateObject(GetHashKey('p_bottleBeer01x'), x, y, z + 0.2, true, true, true)
--     local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")
--     if male then
--     if not IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@male_a@idle_a", "idle_a", 3) then
--         Wait(100)
--         Anim(ped,"amb_rest_drunk@world_human_drinking@male_a@idle_a","idle_a",-1,31)
--         AttachEntityToEntity(beer, ped,boneIndex, 0.07, -0.0200, 0.12250, 0.024, -160.0, -40.0, true, true, false, true, 1, true)
--         Wait(1000)
--     end
--     else --if female
--     if not IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@female_a@idle_a", "idle_b", 3) then
--         Wait(100)
--         Anim(ped,"amb_rest_drunk@world_human_drinking@female_a@idle_a","idle_b",-1,31)
--         AttachEntityToEntity(beer, ped,GetEntityBoneIndexByName(ped, "SKEL_R_Hand"), 0.035, -0.03, -0.068, -50.0, 65.0, 0.0, true, true, false, true, 1, true)
--         Wait(1000)
--     end
--     end

--     if proppromptdisplayed == false then
-- 		PromptSetEnabled(PropPrompt, true)
-- 		PromptSetVisible(PropPrompt, true)
-- 		proppromptdisplayed = true
-- 	end

--     while IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@male_a@idle_a", "idle_a", 3)
--        or IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@female_a@idle_a", "idle_b", 3) do
--         Wait(1)
-- 		if IsControlJustReleased(0, 0x3B24C470) then
-- 			PromptSetEnabled(PropPrompt, false)
-- 			PromptSetVisible(PropPrompt, false)
-- 			proppromptdisplayed = false

--             if male then
--                 StopAnimTask(ped, 'amb_rest_drunk@world_human_drinking@male_a@idle_a', "idle_a", 1.0)
--                 Wait(10)
--                 Anim(ped,"amb_wander@upperbody_player_discard_items@whiskey@arthur@trans","whiskey_trans_nodrink",-1, 24)
--                 Wait(5650)
--                 local rx, ry, rz = table.unpack(GetEntityRotation(beer, true))
--                 local facing = math.rad(GetEntityHeading(ped))
--                 DetachEntity(beer, true, true)
--                 SetEntityRotation(beer, rx,ry,rz, 1, true)
--                 SetEntityVelocity(beer, math.cos(facing), math.sin(facing), 1.5)
--             else
--                 StopAnimTask(PlayerPedId(), 'amb_rest_drunk@world_human_drinking@female_a@idle_a', "idle_b", 1.0)
--                 Wait(1000)
--                 DetachEntity(beer, true, true)
--                 ClearPedSecondaryTask(ped)
--             end
-- 			break
-- 		end
--     end
--     PromptSetEnabled(PropPrompt, false)
-- 	PromptSetVisible(PropPrompt, false)
-- 	proppromptdisplayed = false
--     if male then
--         StopAnimTask(ped, 'amb_rest_drunk@world_human_drinking@male_a@idle_a', "idle_a", 1.0)
--         local rx, ry, rz = table.unpack(GetEntityRotation(beer, true))
--         DetachEntity(beer, true, true)
--         ClearPedSecondaryTask(ped)
--         RemoveAnimDict("amb_rest_drunk@world_human_drinking@male_a@idle_a")
--     else
--         StopAnimTask(PlayerPedId(), 'amb_rest_drunk@world_human_drinking@female_a@idle_a', "idle_b", 1.0)
--         DetachEntity(beer, true, true)
--         ClearPedSecondaryTask(ped)
--         RemoveAnimDict("amb_rest_drunk@world_human_drinking@female_a@idle_a")
--     end
-- end)

-- --Whisky drinking animation
-- RegisterNetEvent('prop:whiskey')
-- AddEventHandler('prop:whiskey', function() 
--     PlaySoundFrontend("Core_Full", "Consumption_Sounds", true, 0)
-- 	ExecuteCommand('close')
--     FPrompt("Finish Drinking", 0x3B24C470, false)
--     local ped = PlayerPedId()
--     local male = IsPedMale(ped)
--     local x,y,z = table.unpack(GetEntityCoords(ped, true))
--     local beer = CreateObject(GetHashKey('p_cs_shotglass01x'), x, y, z + 0.2, true, true, true)
--     local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")
--     if male then
--         if not IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@male_a@idle_a", "idle_a", 3) then
--             Wait(100)
--             Anim(ped,"amb_rest_drunk@world_human_drinking@male_a@idle_a","idle_a",-1,31)
--             AttachEntityToEntity(beer, ped,boneIndex, 0.02, -0.0200, 0.02250, 0.024, -160.0, -40.0, true, true, false, true, 1, true)
--             Wait(1000)
--         end
--     else --if female
--         if not IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@female_a@idle_a", "idle_b", 3) then
--             Wait(100)
--             Anim(ped,"amb_rest_drunk@world_human_drinking@female_a@idle_a","idle_b",-1,31)
--             AttachEntityToEntity(beer, ped,GetEntityBoneIndexByName(ped, "SKEL_R_Finger12"), 0.0, -0.05, 0.02, -150.0, 0.0, 0.0, true, true, false, true, 1, true)
--             Wait(1000)
--         end
--     end

--     if proppromptdisplayed == false then
-- 		PromptSetEnabled(PropPrompt, true)
-- 		PromptSetVisible(PropPrompt, true)
-- 		proppromptdisplayed = true
-- 	end

--     while IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@male_a@idle_a", "idle_a", 3)
--        or IsEntityPlayingAnim(ped, "amb_rest_drunk@world_human_drinking@female_a@idle_a", "idle_b", 3) do
--         Wait(1)
-- 		if IsControlJustReleased(0, 0x3B24C470) then
-- 			PromptSetEnabled(PropPrompt, false)
-- 			PromptSetVisible(PropPrompt, false)
-- 			proppromptdisplayed = false

--             if male then
--                 StopAnimTask(ped, 'amb_rest_drunk@world_human_drinking@male_a@idle_a', "idle_a", 1.0)
--                 Wait(10)
--                 Anim(ped,"amb_wander@upperbody_player_discard_items@whiskey@arthur@trans","whiskey_trans_nodrink",-1, 24)
--                 Wait(5650)
--                 local rx, ry, rz = table.unpack(GetEntityRotation(beer, true))
--                 local facing = math.rad(GetEntityHeading(ped))
--                 DetachEntity(beer, true, true)
--                 SetEntityRotation(beer, rx,ry,rz, 1, true)
--                 SetEntityVelocity(beer, math.cos(facing), math.sin(facing), 1.5)
--             else
--                 StopAnimTask(PlayerPedId(), 'amb_rest_drunk@world_human_drinking@female_a@idle_a', "idle_b", 1.0)
--                 Wait(1000)
--                 DetachEntity(beer, true, true)
--                 ClearPedSecondaryTask(ped)
--             end
-- 			break
-- 		end
--     end
--     PromptSetEnabled(PropPrompt, false)
-- 	PromptSetVisible(PropPrompt, false)
-- 	proppromptdisplayed = false
--     if male then
--         StopAnimTask(ped, 'amb_rest_drunk@world_human_drinking@male_a@idle_a', "idle_a", 1.0)
--         local rx, ry, rz = table.unpack(GetEntityRotation(beer, true))
--         DetachEntity(beer, true, true)
--         ClearPedSecondaryTask(ped)
--         RemoveAnimDict("amb_rest_drunk@world_human_drinking@male_a@idle_a")
--     else
--         StopAnimTask(PlayerPedId(), 'amb_rest_drunk@world_human_drinking@female_a@idle_a', "idle_b", 1.0)
--         DetachEntity(beer, true, true)
--         ClearPedSecondaryTask(ped)
--         RemoveAnimDict("amb_rest_drunk@world_human_drinking@female_a@idle_a")
--     end
-- end)

--PocketWatch
RegisterNetEvent('prop:watch')
AddEventHandler('prop:watch', function() 
  RequestAnimDict('mech_inventory@item@pocketwatch@unarmed@base')
FPrompt()
  while (not HasAnimDictLoaded('mech_inventory@item@pocketwatch@unarmed@base')) do
  Citizen.Wait(300)
  end
ExecuteCommand('close')
prop_name = 'S_INV_POCKETWATCH03X'
local ped = PlayerPedId()
local x,y,z = table.unpack(GetEntityCoords(ped, true))
local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Hand")
  if male then
    AttachEntityToEntity(prop, ped,boneIndex, 0.085,0.025,-0.035,  15.0,190.0,-140.0, true, true, false, true, 1, true)
  else
      AttachEntityToEntity(prop, ped,boneIndex, 0.075,0.025,-0.045,  35.0,200.0,-140.0, true, true, false, true, 1, true)
  end
local UnholsterTime = GetAnimDuration('mech_inventory@item@pocketwatch@unarmed@base', "unholster")
Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","unholster",UnholsterTime*1000,0)
  Wait(UnholsterTime*1000)
  Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","inspect_base",-1,31)
  Wait(100)
  if proppromptdisplayed == false then
  PromptSetEnabled(PropPrompt, true)
  PromptSetVisible(PropPrompt, true)
  proppromptdisplayed = true
end
  while IsEntityPlayingAnim(ped, "mech_inventory@item@pocketwatch@unarmed@base", "inspect_base", 3) do
      Wait(1)
  if IsControlJustReleased(0, 0x3B24C470) then
    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    proppromptdisplayed = false
    StopAnimTask(ped, 'mech_inventory@item@pocketwatch@unarmed@base', "inspect_base", 1.0)
    Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","holster",1000,0)
          Citizen.Wait(2000)
    DeleteEntity(prop)
    break
  end
  end
  PromptSetEnabled(PropPrompt, false)
PromptSetVisible(PropPrompt, false)
proppromptdisplayed = false
StopAnimTask(ped, 'mech_inventory@item@pocketwatch@unarmed@base', "inspect_base", 1.0)
DeleteEntity(prop)
end, false)

--Compass
RegisterNetEvent('prop:compass')
AddEventHandler('prop:compass', function() 
  RequestAnimDict('mech_inventory@item@pocketwatch@unarmed@base')
FPrompt()
  while (not HasAnimDictLoaded('mech_inventory@item@pocketwatch@unarmed@base')) do
  Citizen.Wait(300)
  end
ExecuteCommand('close')
prop_name = 's_inv_compass01x'
local ped = PlayerPedId()
local x,y,z = table.unpack(GetEntityCoords(ped, true))
local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Hand")
  if male then
    AttachEntityToEntity(prop, ped,boneIndex, 0.085,0.025,-0.035,  15.0,190.0,-140.0, true, true, false, true, 1, true)
  else
      AttachEntityToEntity(prop, ped,boneIndex, 0.075,0.025,-0.045,  35.0,200.0,-140.0, true, true, false, true, 1, true)
  end
local UnholsterTime = GetAnimDuration('mech_inventory@item@pocketwatch@unarmed@base', "unholster")
Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","unholster",UnholsterTime*1000,0)
  Wait(UnholsterTime*1000)
  Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","inspect_base",-1,31)
  Wait(100)
  if proppromptdisplayed == false then
  PromptSetEnabled(PropPrompt, true)
  PromptSetVisible(PropPrompt, true)
  proppromptdisplayed = true
end
  while IsEntityPlayingAnim(ped, "mech_inventory@item@pocketwatch@unarmed@base", "inspect_base", 3) do
      Wait(1)
  if IsControlJustReleased(0, 0x3B24C470) then
    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    proppromptdisplayed = false
    StopAnimTask(ped, 'mech_inventory@item@pocketwatch@unarmed@base', "inspect_base", 1.0)
    Anim(ped,"mech_inventory@item@pocketwatch@unarmed@base","holster",1000,0)
          Citizen.Wait(2000)
    DeleteEntity(prop)
    break
  end
  end
  PromptSetEnabled(PropPrompt, false)
PromptSetVisible(PropPrompt, false)
proppromptdisplayed = false
StopAnimTask(ped, 'mech_inventory@item@pocketwatch@unarmed@base', "inspect_base", 1.0)
DeleteEntity(prop)
end, false)

--Book
RegisterNetEvent('prop:book')
AddEventHandler('prop:book', function() 
  FPrompt()
  ExecuteCommand('close')
      
  TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_READING_BOOK"), -1, true, "StartScenario", 0, false)
  Wait(1)

if proppromptdisplayed == false then
  PromptSetEnabled(PropPrompt, true)
  PromptSetVisible(PropPrompt, true)
  proppromptdisplayed = true
end

  while IsPedUsingAnyScenario(PlayerPedId()) do
      Wait(1)
  if IsControlJustReleased(0, 0x3B24C470) then
    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    proppromptdisplayed = false
    ClearPedTasks(PlayerPedId())
    break
  end
  end
  PromptSetEnabled(PropPrompt, false)
PromptSetVisible(PropPrompt, false)
proppromptdisplayed = false
  Wait(5000)
  SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
end)

--Cigarette
RegisterNetEvent('prop:cigarettes')
AddEventHandler('prop:cigarettes', function() 
  FPrompt("Finish Smoking", 0x3B24C470, false)
  LMPrompt("Inhale", 0x07B8BEAF, false)
  EPrompt("Change Stance", 0xD51B784F, false)
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local male = IsPedMale(ped)
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local cigarette = CreateObject(GetHashKey('P_CIGARETTE01X'), x, y, z + 0.2, true, true, true)
  local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
  local mouth = GetEntityBoneIndexByName(ped, "skel_head")
  
  if male then
      AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
      Anim(ped,"amb_rest@world_human_smoking@male_c@stand_enter","enter_back_rf",9400,0)
      Wait(1000)
      AttachEntityToEntity(cigarette, ped, righthand, 0.03, -0.01, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)
      Wait(1000)
      AttachEntityToEntity(cigarette, ped, mouth, -0.017, 0.1, -0.01, 0.0, 90.0, -90.0, true, true, false, true, 1, true)
      Wait(3000)
      AttachEntityToEntity(cigarette, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
      Wait(1000)
      Anim(ped,"amb_rest@world_human_smoking@male_c@base","base",-1,30)
      RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
      Wait(1000)
  else --female
      AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
      Anim(ped,"amb_rest@world_human_smoking@female_c@base","base",-1,30)
      Wait(1000)
      AttachEntityToEntity(cigarette, ped, righthand, 0.01, 0.0, 0.01, 0.0, -160.0, -130.0, true, true, false, true, 1, true)
      Wait(2500)
  end

  local stance="c"

  if proppromptdisplayed == false then
  PromptSetEnabled(PropPrompt, true)
  PromptSetVisible(PropPrompt, true)
  PromptSetEnabled(UsePrompt, true)
  PromptSetVisible(UsePrompt, true)
      PromptSetEnabled(ChangeStance, true)
  PromptSetVisible(ChangeStance, true)
  proppromptdisplayed = true
end

  if male then
      while  IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_c@base","base", 3)
          or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base","base", 3)
          or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_d@base","base", 3)
          or IsEntityPlayingAnim(ped, "amb_wander@code_human_smoking_wander@male_a@base","base", 3) do

          Wait(5)
      if IsControlJustReleased(0, 0x3B24C470) then
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
              PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
              PromptSetEnabled(ChangeStance, false)
          PromptSetVisible(ChangeStance, false)
        proppromptdisplayed = false

              ClearPedSecondaryTask(ped)
              Anim(ped, "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
              Wait(2800)
              DetachEntity(cigarette, true, true)
              SetEntityVelocity(cigarette, 0.0,0.0,-1.0)
              Wait(1500)
              ClearPedSecondaryTask(ped)
              ClearPedTasks(ped)
              Wait(10)
      end
          if IsControlJustReleased(0, 0xD51B784F) then
              if stance=="c" then
                  Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30)
                  Wait(1000)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", 3) do
                      Wait(100)
                  end    
                  stance="b"
              elseif stance=="b" then
                  Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30)
                  Wait(1000)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_d@base","base", 3) do
                      Wait(100)
                  end
                  stance="d"
              elseif stance=="d" then
                  Anim(ped, "amb_rest@world_human_smoking@male_d@trans", "d_trans_a", -1, 30)
                  Wait(4000)
                  Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                  while not IsEntityPlayingAnim(ped,"amb_wander@code_human_smoking_wander@male_a@base","base", 3) do
                      Wait(100)
                  end
                  stance="a"
              else --stance=="a"
                  Anim(ped, "amb_rest@world_human_smoking@male_a@trans", "a_trans_c", -1, 30)
                  Wait(4233)
                  Anim(ped,"amb_rest@world_human_smoking@male_c@base","base",-1,30,0)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_c@base","base", 3) do
                      Wait(100)
                  end
                  stance="c"
              end
          end
      
          if stance=="c" then
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a","idle_b", -1, 30, 0)
                      Wait(21166)
                      Anim(ped, "amb_rest@world_human_smoking@male_c@base","base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a","idle_a", -1, 30, 0)
                      Wait(8500)
                      Anim(ped, "amb_rest@world_human_smoking@male_c@base","base", -1, 30, 0)
                      Wait(100)
                  end
              end
          elseif stance=="b" then
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_c","idle_g", -1, 30, 0)
                      Wait(13433)
                      Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a", "idle_a", -1, 30, 0)
                      Wait(3199)
                      Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                      Wait(100)
                  end
              end
          elseif stance=="d" then
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@male_d@idle_a","idle_b", -1, 30, 0)
                      Wait(7366)
                      Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@male_d@idle_c", "idle_g", -1, 30, 0)
                      Wait(7866)
                      Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                      Wait(100)
                  end
              end
          else --stance=="a"
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a", "idle_b", -1, 30, 0)
                      Wait(12533)
                      Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a","idle_a", -1, 30, 0)
                      Wait(8200)
                      Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                      Wait(100)
                  end
              end
          end
      end
  else --if female
      while  IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_c@base", "base", 3) 
          or IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_b@base", "base", 3)
          or IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_a@base", "base", 3)do

          Wait(5)
      if IsControlJustReleased(0, 0x3B24C470) then
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
              PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
              PromptSetEnabled(ChangeStance, false)
          PromptSetVisible(ChangeStance, false)
        proppromptdisplayed = false

              ClearPedSecondaryTask(ped)
              Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_fire_stand_a", -1, 1)
              Wait(3800)
              DetachEntity(cigarette, true, true)
              Wait(800)
              ClearPedSecondaryTask(ped)
              ClearPedTasks(ped)
              Wait(10)
      end
          if IsControlJustReleased(0, 0xD51B784F) then
              if stance=="c" then
                  Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30)
                  Wait(1000)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_b@base", "base", 3) do
                      Wait(100)
                  end    
                  stance="b"
              elseif stance=="b" then
                  Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_a", -1, 30)
                  Wait(5733)
                  Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_a@base","base", 3) do
                      Wait(100)
                  end
                  stance="a"
              else --stance=="a"
                  Anim(ped,"amb_rest@world_human_smoking@female_c@base","base",-1,30)
                  Wait(1000)
                  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@female_c@base","base", 3) do
                      Wait(100)
                  end
                  stance="c"
              end
          end
      
          if stance=="c" then
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@female_c@idle_a","idle_a", -1, 30, 0)
                      Wait(9566)
                      Anim(ped, "amb_rest@world_human_smoking@female_c@base","base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@female_c@idle_b","idle_f", -1, 30, 0)
                      Wait(8133)
                      Anim(ped, "amb_rest@world_human_smoking@female_c@base","base", -1, 30, 0)
                      Wait(100)
                  end
              end
          elseif stance=="b" then
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@female_b@idle_b","idle_f", -1, 30, 0)
                      Wait(8033)
                      Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@female_b@idle_a", "idle_b", -1, 30, 0)
                      Wait(4266)
                      Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30, 0)
                      Wait(100)
                  end
              end
          else --stance=="a"
              if IsControlJustReleased(0, 0x07B8BEAF) then
                  Wait(500)
                  if IsControlPressed(0, 0x07B8BEAF) then
                      Anim(ped, "amb_rest@world_human_smoking@female_a@idle_b", "idle_d", -1, 30, 0)
                      Wait(14566)
                      Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                      Wait(100)
                  else
                      Anim(ped, "amb_rest@world_human_smoking@female_a@idle_a","idle_b", -1, 30, 0)
                      Wait(6100)
                      Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                      Wait(100)
                  end
              end
          end
      end
  end

  PromptSetEnabled(PropPrompt, false)
PromptSetVisible(PropPrompt, false)
  PromptSetEnabled(UsePrompt, false)
PromptSetVisible(UsePrompt, false)
  PromptSetEnabled(ChangeStance, false)
PromptSetVisible(ChangeStance, false)
proppromptdisplayed = false

  DetachEntity(cigarette, true, true)
  ClearPedSecondaryTask(ped)
  RemoveAnimDict("amb_wander@code_human_smoking_wander@male_a@base")
  RemoveAnimDict("amb_rest@world_human_smoking@male_a@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@base")
  RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_g")
  RemoveAnimDict("amb_rest@world_human_smoking@male_c@base")
  RemoveAnimDict("amb_rest@world_human_smoking@male_c@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@male_d@base")
  RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_c")
  RemoveAnimDict("amb_rest@world_human_smoking@male_a@trans")
  RemoveAnimDict("amb_rest@world_human_smoking@male_c@trans")
  RemoveAnimDict("amb_rest@world_human_smoking@male_d@trans")
  RemoveAnimDict("amb_rest@world_human_smoking@female_a@base")
  RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_b")
  RemoveAnimDict("amb_rest@world_human_smoking@female_b@base")
  RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_b")
  RemoveAnimDict("amb_rest@world_human_smoking@female_c@base")
  RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_b")
  RemoveAnimDict("amb_rest@world_human_smoking@female_b@trans")
  Wait(100)
  ClearPedTasks(ped)
end)

--Cigar
RegisterNetEvent('prop:cigar')
AddEventHandler('prop:cigar', function()

  PlaySoundFrontend("Core_Full", "Consumption_Sounds", true, 0)
  ExecuteCommand('close')
  FPrompt('Stop Smoking', 0x3B24C470, false)

  local prop_name = 'P_CIGAR01X'
  local ped = PlayerPedId()
  local dict = 'amb_rest@world_human_smoke_cigar@male_a@idle_b'
  local anim = 'idle_d'
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
  local boneIndex = GetEntityBoneIndexByName(ped, 'SKEL_R_Finger12')
  local smoking = false

  if not IsEntityPlayingAnim(ped, dict, anim, 3) then
  
      local waiting = 0
      RequestAnimDict(dict)
      while not HasAnimDictLoaded(dict) do
          waiting = waiting + 100
          Citizen.Wait(100)
          if waiting > 5000 then
              --'RedM Fucked up this animation')
              break
          end
      end
  
      Wait(100)
      AttachEntityToEntity(prop, ped,boneIndex, 0.01, -0.00500, 0.01550, 0.024, 300.0, -40.0, true, true, false, true, 1, true)
      TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
      Wait(1000)

      if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      proppromptdisplayed = true
      end
      
      smoking = true
      while smoking do
          if IsEntityPlayingAnim(ped, dict, anim, 3) then

              DisableControlAction(0, 0x07CE1E61, true)
              DisableControlAction(0, 0xF84FA74F, true)
              DisableControlAction(0, 0xCEE12B50, true)
              DisableControlAction(0, 0xB2F377E8, true)
              DisableControlAction(0, 0x8FFC75D6, true)
              DisableControlAction(0, 0xD9D0E1C0, true)

              if IsControlPressed(0, 0x3B24C470) then
                  PromptSetEnabled(PropPrompt, false)
                  PromptSetVisible(PropPrompt, false)
                  proppromptdisplayed = false
                  smoking = false
                  ClearPedSecondaryTask(ped)
                  DeleteObject(prop)
                  RemoveAnimDict(dict)
                  break
              end
          else
              TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
          end
          Wait(0)
      end
  end
end)

--Pipe
RegisterNetEvent('prop:pipe')
AddEventHandler('prop:pipe', function() 
  FPrompt("Cancelar Animação", 0x3B24C470, false)
  LMPrompt("Use", 0x07B8BEAF, false)
  EPrompt("Pose", 0xD51B784F, false)
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local male = IsPedMale(ped)
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local pipe = CreateObject(GetHashKey('P_PIPE01X'), x, y, z + 0.2, true, true, true)
  local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
  
  AttachEntityToEntity(pipe, ped, righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
  Anim(ped,"amb_wander@code_human_smoking_wander@male_b@trans","nopipe_trans_pipe",-1,30)
  Wait(9000)
  Anim(ped,"amb_rest@world_human_smoking@male_b@base","base",-1,31)

  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_b@base","base", 3) do
      Wait(100)
  end

  if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      PromptSetEnabled(UsePrompt, true)
      PromptSetVisible(UsePrompt, true)
      PromptSetEnabled(ChangeStance, true)
      PromptSetVisible(ChangeStance, true)
      proppromptdisplayed = true
end

  while IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_b@base","base", 3) do

      Wait(5)
  if IsControlJustReleased(0, 0x3B24C470) then
          PromptSetEnabled(PropPrompt, false)
          PromptSetVisible(PropPrompt, false)
          PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
          PromptSetEnabled(ChangeStance, false)
          PromptSetVisible(ChangeStance, false)
          proppromptdisplayed = false

          Anim(ped, "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
          Wait(6066)
          DeleteEntity(pipe)
          ClearPedSecondaryTask(ped)
          ClearPedTasks(ped)
          Wait(10)
  end
      
      if IsControlJustReleased(0, 0xD51B784F) then
          Anim(ped, "amb_rest@world_human_smoking@pipe@proper@male_d@wip_base", "wip_base", -1, 30)
          Wait(5000)
          Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31)
          Wait(100)
      end

      if IsControlJustReleased(0, 0x07B8BEAF) then
          Wait(500)
          if IsControlPressed(0, 0x07B8BEAF) then
              Anim(ped, "amb_rest@world_human_smoking@male_b@idle_b","idle_d", -1, 30, 0)
              Wait(15599)
              Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
              Wait(100)
          else
              Anim(ped, "amb_rest@world_human_smoking@male_b@idle_a","idle_a", -1, 30, 0)
              Wait(22600)
              Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
              Wait(100)
          end
      end
  end

  PromptSetEnabled(PropPrompt, false)
  PromptSetVisible(PropPrompt, false)
  PromptSetEnabled(UsePrompt, false)
  PromptSetVisible(UsePrompt, false)
  PromptSetEnabled(ChangeStance, false)
  PromptSetVisible(ChangeStance, false)
  proppromptdisplayed = false

  DetachEntity(pipe, true, true)
  ClearPedSecondaryTask(ped)
  RemoveAnimDict("amb_wander@code_human_smoking_wander@male_b@trans")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@base")
  RemoveAnimDict("amb_rest@world_human_smoking@pipe@proper@male_d@wip_base")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_b")
  Wait(100)
  ClearPedTasks(ped)
end)

--FredsPipe
RegisterNetEvent('prop:peacepipe')
AddEventHandler('prop:peacepipe', function() 
  FPrompt("Cancelar Animação", 0x3B24C470, false)
  LMPrompt("Use", 0x07B8BEAF, false)
  EPrompt("Pose", 0xD51B784F, false)
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local male = IsPedMale(ped)
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local fpipe = CreateObject(GetHashKey('p_peacepipe01x'), x, y, z + 0.2, true, true, true)
  local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
  
  AttachEntityToEntity(fpipe, ped, righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
  Anim(ped,"amb_wander@code_human_smoking_wander@male_b@trans","nopipe_trans_pipe",-1,30)
  Wait(9000)
  Anim(ped,"amb_rest@world_human_smoking@male_b@base","base",-1,31)

  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_b@base","base", 3) do
      Wait(100)
  end

  if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      PromptSetEnabled(UsePrompt, true)
      PromptSetVisible(UsePrompt, true)
      PromptSetEnabled(ChangeStance, true)
      PromptSetVisible(ChangeStance, true)
      proppromptdisplayed = true
  end

  while IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_b@base","base", 3) do

      Wait(5)
      if IsControlJustReleased(0, 0x3B24C470) then
          PromptSetEnabled(PropPrompt, false)
          PromptSetVisible(PropPrompt, false)
          PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
          PromptSetEnabled(ChangeStance, false)
          PromptSetVisible(ChangeStance, false)
          proppromptdisplayed = false

          Anim(ped, "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
          Wait(6066)
          DeleteEntity(fpipe)
          ClearPedSecondaryTask(ped)
          ClearPedTasks(ped)
          Wait(10)
      end
      
      if IsControlJustReleased(0, 0xD51B784F) then
          Anim(ped, "amb_rest@world_human_smoking@pipe@proper@male_d@wip_base", "wip_base", -1, 30)
          Wait(5000)
          Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31)
          Wait(100)
      end

      if IsControlJustReleased(0, 0x07B8BEAF) then
          Wait(500)
          if IsControlPressed(0, 0x07B8BEAF) then
              Anim(ped, "amb_rest@world_human_smoking@male_b@idle_b","idle_d", -1, 30, 0)
              Wait(15599)
              Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
              Wait(100)
          else
              Anim(ped, "amb_rest@world_human_smoking@male_b@idle_a","idle_a", -1, 30, 0)
              Wait(22600)
              Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
              Wait(100)
          end
      end
  end

  PromptSetEnabled(PropPrompt, false)
  PromptSetVisible(PropPrompt, false)
  PromptSetEnabled(UsePrompt, false)
  PromptSetVisible(UsePrompt, false)
  PromptSetEnabled(ChangeStance, false)
  PromptSetVisible(ChangeStance, false)
  proppromptdisplayed = false

  DetachEntity(fpipe, true, true)
  ClearPedSecondaryTask(ped)
  RemoveAnimDict("amb_wander@code_human_smoking_wander@male_b@trans")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@base")
  RemoveAnimDict("amb_rest@world_human_smoking@pipe@proper@male_d@wip_base")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_a")
  RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_b")
  Wait(100)
  ClearPedTasks(ped)
end)

--Fan
RegisterNetEvent('prop:fan')
AddEventHandler('prop:fan', function() 
  FPrompt("Cancelar Animação", 0x3B24C470, false)
  LMPrompt("Little Wave", 0x07B8BEAF, false)
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local male = IsPedMale(ped)
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  
  local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")

  Anim(ped,"amb_wander@code_human_fan_wander@female_a@trans","nonfan_trans_fan",-1,30)
  Wait(1000)
  local fan = CreateObject(GetHashKey('P_CS_FAN01X'), x, y, z + 0.2, true, true, true)
  AttachEntityToEntity(fan, ped, righthand, 0.0, 0.0, -0.02, 0.0, 120.0, 55.0, true, true, false, true, 1, true)
  
  PlayEntityAnim(fan, "nonfan_trans_fan_fan", "amb_wander@code_human_fan_wander@female_a@trans", 0.0, 0, 0, "OpenFan", 0.0, 0)
  Wait(2233)
  Anim(ped,"amb_rest@world_human_fan@female_a@base","base",-1,31)
  
  while not IsEntityPlayingAnim(ped,"amb_rest@world_human_fan@female_a@base","base", 3) do
      Wait(100)
  end

  if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      PromptSetEnabled(UsePrompt, true)
      PromptSetVisible(UsePrompt, true)
      proppromptdisplayed = true
end

  while  IsEntityPlayingAnim(ped, "amb_rest@world_human_fan@female_a@base","base", 3) do

      Wait(5)
  if IsControlJustReleased(0, 0x3B24C470) then
          PromptSetEnabled(PropPrompt, false)
          PromptSetVisible(PropPrompt, false)
          PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
          proppromptdisplayed = false

          Anim(ped, "amb_wander@code_human_fan_wander@female_a@trans", "fan_trans_nonfan", -1, 30)
          Wait(100)
          PlayEntityAnim(fan, "fan_trans_nonfan_fan", "amb_wander@code_human_fan_wander@female_a@trans", 0.0, 0, 0, "CloseFan", 0.0, 0)
          Wait(1800)
          DeleteEntity(fan)
          ClearPedSecondaryTask(ped)
          ClearPedTasks(ped)
          Wait(10)
  end
      
      if IsControlJustReleased(0, 0x07B8BEAF) then
          Wait(500)
          if IsControlPressed(0, 0x07B8BEAF) then
              Anim(ped, "amb_rest@world_human_fan@female_a@idle_c","idle_g", -1, 30, 0)
              Wait(11800)
              Anim(ped, "amb_rest@world_human_fan@female_a@base","base", -1, 31, 0)
              Wait(100)
          else
              Anim(ped, "amb_rest@world_human_fan@female_a@idle_a","idle_a", -1, 30, 0)
              Wait(5400)
              Anim(ped, "amb_rest@world_human_fan@female_a@base","base", -1, 31, 0)
              Wait(100)
          end
      end
  end

  PromptSetEnabled(PropPrompt, false)
  PromptSetVisible(PropPrompt, false)
  PromptSetEnabled(UsePrompt, false)
  PromptSetVisible(UsePrompt, false)
  proppromptdisplayed = false

  DetachEntity(fan, true, true)
  ClearPedSecondaryTask(ped)
  RemoveAnimDict("amb_wander@code_human_fan_wander@female_a@trans")
  RemoveAnimDict("amb_rest@world_human_fan@female_a@base")
  RemoveAnimDict("amb_rest@world_human_fan@female_a@idle_a")
  RemoveAnimDict("amb_rest@world_human_fan@female_a@idle_c")
  Wait(100)
  ClearPedTasks(ped)
end)

--Chewing Tobacco
RegisterNetEvent('prop:chewingtobacco')
AddEventHandler('prop:chewingtobacco', function()
  
  FPrompt("Finish", 0x3B24C470, false)
  LMPrompt("Do Something", 0x07B8BEAF, false)
  EPrompt("Change Stance", 0xD51B784F, false)
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")

  local basedict = "amb_misc@world_human_chew_tobacco@male_a@base"
  local basedictB = "amb_misc@world_human_chew_tobacco@male_b@base"
  local MaleA =
      { 
          [1] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_a", ['anim'] = "idle_a"},
          [2] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_a", ['anim'] = "idle_b"},
          [3] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_a", ['anim'] = "idle_c"},
          [4] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_b", ['anim'] = "idle_d"},
          [5] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_b", ['anim'] = "idle_e"},
          [6] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_b", ['anim'] = "idle_f"},
          [7] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_c", ['anim'] = "idle_g"},
          [8] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_c", ['anim'] = "idle_h"},
          [9] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_c", ['anim'] = "idle_i"},
          [7] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_d", ['anim'] = "idle_j"},
          [8] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_d", ['anim'] = "idle_k"},
          [9] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_a@idle_d", ['anim'] = "idle_l"}
      }
  local MaleB =
      { 
          [1] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_a", ['anim'] = "idle_a"},
          [2] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_a", ['anim'] = "idle_b"},
          [3] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_a", ['anim'] = "idle_c"},
          [4] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_b", ['anim'] = "idle_d"},
          [5] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_b", ['anim'] = "idle_e"},
          [6] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_b", ['anim'] = "idle_f"},
          [7] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_c", ['anim'] = "idle_g"},
          [8] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_c", ['anim'] = "idle_h"},
          [9] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_c", ['anim'] = "idle_i"},
          [7] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_d", ['anim'] = "idle_j"},
          [8] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_d", ['anim'] = "idle_k"},
          [9] = { ['dict'] = "amb_misc@world_human_chew_tobacco@male_b@idle_d", ['anim'] = "idle_l"}
      }
  local stance = "MaleA"

  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_a")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_b")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_c")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_d")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_a")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_b")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_c")
  RequestAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_d")

  Anim(ped,"amb_misc@world_human_chew_tobacco@male_a@stand_enter","enter_back",-1,30)
  Wait(2500)
  local chewingtobacco = CreateObject(GetHashKey('S_TOBACCOTIN01X'), x, y, z + 0.2, true, true, true)
  Wait(10)
  AttachEntityToEntity(chewingtobacco, ped, righthand, 0.0, -0.05, 0.02,  30.0, 180.0, 0.0, true, true, false, true, 1, true)
  Wait(6000)
  DeleteEntity(chewingtobacco)
  Wait(3500)
  Anim(ped,basedict,"base",-1,31, 0)
  
  while not IsEntityPlayingAnim(ped,basedict,"base", 3) do
      Wait(100)
  end

  if proppromptdisplayed == false then
      PromptSetEnabled(PropPrompt, true)
      PromptSetVisible(PropPrompt, true)
      PromptSetEnabled(UsePrompt, true)
      PromptSetVisible(UsePrompt, true)
      PromptSetEnabled(ChangeStance, true)
    PromptSetVisible(ChangeStance, true)
      proppromptdisplayed = true
end

  while IsEntityPlayingAnim(ped, basedict,"base", 3) or IsEntityPlayingAnim(ped, basedictB,"base", 3) do

      Wait(5)
  if IsControlJustReleased(0, 0x3B24C470) then
          PromptSetEnabled(PropPrompt, false)
          PromptSetVisible(PropPrompt, false)
          PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
          PromptSetEnabled(ChangeStance, false)
        PromptSetVisible(ChangeStance, false)
          proppromptdisplayed = false

          Anim(ped, "amb_misc@world_human_chew_tobacco@male_b@idle_b", "idle_d", 5500, 30)
          Wait(5500)
          ClearPedSecondaryTask(ped)
          ClearPedTasks(ped)
          Wait(10)
  end
      
      if IsControlJustReleased(0, 0x07B8BEAF) then
          local random = math.random(1,9)
          if stance == "MaleA" then
              randomdict = MaleA[random]['dict']
              randomanim = MaleA[random]['anim']
          else
              randomdict = MaleB[random]['dict']
              randomanim = MaleB[random]['anim']
          end
          animduration = GetAnimDuration(randomdict, randomanim)*1000
          Wait(100)
          PromptSetEnabled(PropPrompt, false)
          PromptSetVisible(PropPrompt, false)
          PromptSetEnabled(UsePrompt, false)
          PromptSetVisible(UsePrompt, false)
          PromptSetEnabled(ChangeStance, false)
        PromptSetVisible(ChangeStance, false)
          Anim(ped, randomdict, randomanim, -1, 30, 0)
          Wait(animduration)
          if stance == "MaleA" then
              Anim(ped, basedict,"base", -1, 31, 0)
          else
              Anim(ped, basedictB,"base", -1, 31, 0)
          end
          PromptSetEnabled(PropPrompt, true)
          PromptSetVisible(PropPrompt, true)
          PromptSetEnabled(UsePrompt, true)
          PromptSetVisible(UsePrompt, true)
          PromptSetEnabled(ChangeStance, true)
        PromptSetVisible(ChangeStance, true)
          Wait(100)
      end

      if IsControlJustReleased(0, 0xD51B784F) then
          if stance=="MaleA" then
              Anim(ped, "amb_misc@world_human_chew_tobacco@male_a@trans", "a_trans_b", -1, 30)
              PromptSetEnabled(PropPrompt, false)
              PromptSetVisible(PropPrompt, false)
              PromptSetEnabled(UsePrompt, false)
              PromptSetVisible(UsePrompt, false)
              PromptSetEnabled(ChangeStance, false)
            PromptSetVisible(ChangeStance, false)
              Wait(7333)
              Anim(ped, basedictB, "base", -1, 30, 0)
              while not IsEntityPlayingAnim(ped,basedictB, "base", 3) do
                  Wait(100)
              end    
              PromptSetEnabled(PropPrompt, true)
              PromptSetVisible(PropPrompt, true)
              PromptSetEnabled(UsePrompt, true)
              PromptSetVisible(UsePrompt, true)
              PromptSetEnabled(ChangeStance, true)
            PromptSetVisible(ChangeStance, true)
              stance="MaleB"
          else
              Anim(ped, "amb_misc@world_human_chew_tobacco@male_b@trans", "b_trans_a", -1, 30)
              PromptSetEnabled(PropPrompt, false)
              PromptSetVisible(PropPrompt, false)
              PromptSetEnabled(UsePrompt, false)
              PromptSetVisible(UsePrompt, false)
              PromptSetEnabled(ChangeStance, false)
            PromptSetVisible(ChangeStance, false)
              Wait(5833)
              Anim(ped, basedict, "base", -1, 30, 0)
              while not IsEntityPlayingAnim(ped,basedict,"base", 3) do
                  Wait(100)
              end
              PromptSetEnabled(PropPrompt, true)
              PromptSetVisible(PropPrompt, true)
              PromptSetEnabled(UsePrompt, true)
              PromptSetVisible(UsePrompt, true)
              PromptSetEnabled(ChangeStance, true)
            PromptSetVisible(ChangeStance, true)
              stance="MaleA"
          end
      end

  end

  PromptSetEnabled(PropPrompt, false)
  PromptSetVisible(PropPrompt, false)
  PromptSetEnabled(UsePrompt, false)
  PromptSetVisible(UsePrompt, false)
  PromptSetEnabled(ChangeStance, false)
PromptSetVisible(ChangeStance, false)
  proppromptdisplayed = false

  DetachEntity(chewingtobacco, true, true)
  ClearPedSecondaryTask(ped)
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_a@stand_enter")
  RemoveAnimDict(base)
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_a")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_b")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_c")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_a@idle_d")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_a")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_b")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_c")
  RemoveAnimDict("amb_misc@world_human_chew_tobacco@male_b@idle_d")
  Wait(100)
  ClearPedTasks(ped)
end)

--Hair Pomade
RegisterNetEvent('prop:hairpomade')
AddEventHandler('prop:hairpomade', function()
  ExecuteCommand('close')
  local ped = PlayerPedId()
  local male = IsPedMale(ped)
  local wearinghat = Citizen.InvokeNative(0xFB4891BD7578CDC1, PlayerPedId(), 0x9925C067)
  local basedict = "mech_inventory@apply_pomade"
  RequestAnimDict(basedict)
  if wearinghat and not male then
      --'yup')
      ExecuteCommand('hat')
      Wait(250)
      Anim(ped,basedict,"apply_pomade_no_hat",-1,0)
      Wait(5166)
      ExecuteCommand('hat')
  elseif wearinghat and male then
      Anim(ped,basedict,"apply_pomade_hat",-1,0)
  else
      Anim(ped,basedict,"apply_pomade_no_hat",-1,0)
  end
  Wait(5733)

  ClearPedSecondaryTask(ped)
  RemoveAnimDict(base)
  Wait(100)
  ClearPedTasks(ped)
end)


function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
Citizen.CreateThread(function()
  RequestAnimDict(dict)
  local dur = duration or -1
  local flag = flags or 1
  local intro = tonumber(introtiming) or 1.0
  local exit = tonumber(exittiming) or 1.0
timeout = 5
  while (not HasAnimDictLoaded(dict) and timeout>0) do
  timeout = timeout-1
      if timeout == 0 then 
          --"Animation Failed to Load")
  end
  Citizen.Wait(300)
  end
  TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
  end)
end

function StopAnim(dict, body)
Citizen.CreateThread(function()
  StopAnimTask(PlayerPedId(), dict, body, 1.0)
  end)
end


RegisterCommand("cigarro", function()
TriggerEvent('prop:cigarettes')
end)

RegisterCommand("cabelo", function()
TriggerEvent('prop:hairpomade')
end)

RegisterCommand("cigarro2", function()
TriggerEvent('prop:cigar')
end)


RegisterCommand("livro2", function()
TriggerEvent('prop:ledger')
end)

RegisterCommand("bussola", function()
TriggerEvent('prop:compass')
end)


RegisterCommand("relogio", function()
TriggerEvent('prop:watch')
end)


RegisterCommand("livro", function()
TriggerEvent('prop:book')
end)

RegisterCommand("peacepipe", function()
TriggerEvent('prop:peacepipe')
end)

RegisterCommand("tubo", function()
TriggerEvent('prop:pipe')
end)