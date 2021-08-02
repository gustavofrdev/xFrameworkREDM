
AddEventHandler('playerConnecting',function(name, setCallback, progresso)
    local ConfigFile = _Framework.LoginConfig()
    local whitelistON = ConfigFile.Whitelist
    local MySQL = _Framework
    progresso.defer()
    local playerId = source
    local hex = _Framework.GetPlayerActualSteam(playerId)
    local user_id
    progresso.update(ConfigFile.Mensagens['ChecandoSteamMSG'])
    if not hex then
      progresso.done(ConfigFile.Mensagens['SteamNaoPresente'])
    elseif hex then
      progresso.update(ConfigFile.Mensagens['StemEstaPresente'])
      Wait(100)
    end
    
    if MySQL.HasHexID(hex) then
      progresso.update(ConfigFile.Mensagens['NãoPrimeiroLogin'] .. name)
      user_id = MySQL.HasHexID(hex)
      TriggerEvent('playerLogou', hex)
      Wait(100)
    else
      progresso.update(ConfigFile.Mensagens['PrimeiroLogin'])
      MySQL.GenerateNewUser(hex)
      Wait(100)
      --   while not preparando do Wait(0) end
      Wait(100)
      TriggerEvent('playerLogou', hex)
    end
    progresso.update(ConfigFile.Mensagens['AguardandoBan'])
    exports.ghmattimysql:execute('SELECT banido FROM xframework_usuarios WHERE identifier = @id',{['@id'] = hex},
    function(isBanido)
      progresso.update(ConfigFile.Mensagens['InfoBanColetada'])
      if tonumber(isBanido[1].banido) == 1 then
        progresso.done(ConfigFile.Mensagens['Banido'])
      else
        progresso.update(ConfigFile.Mensagens['NãoEstaBanido'])
        Wait(100)
        progresso.update(ConfigFile.Mensagens['ChcandoWL'])
        if whitelistON then
          local isWhitelisted = MySQL.CheckWhitelist(hex)
          if ConfigFile.Whitelist == false then
            progresso.update(ConfigFile.Mensagens['WhitelistOFF'])
            Wait(100)
            isWhitelisted = 'skip'
          end
          if isWhitelisted == 0 then
            progresso.done(ConfigFile.Mensagens['NãoEstaWL'].." sua Steam Hex é: ".. _Framework.GetPlayerActualSteam(playerId))
          elseif isWhitelisted == 1 then
            progresso.update(ConfigFile.Mensagens['EstaWL'])
            Wait(100)
          end
        end
        Wait(100)
        progresso.update(ConfigFile.Mensagens['BemVindo'])
        Wait(100)
        progresso.done()
      end
    end)
  end)

  function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end