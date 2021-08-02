local LoginConfig = {}
--> Mensagens do Login, as que aparecem quando está logando no servidor
--> O FiveM/RedM está substituindo tudo que é "Whitelist" para "AllowList", o porque? não sei
LoginConfig.Mensagens = {
  ["NãoPrimeiroLogin"]   = "Informação Coletada - Não é a sua primeira vez por aqui. Bem vindo novamente(a) ",
  ["PrimeiroLogin"]      = "Informação Coletada - Bem Vindo pela primeira vez conosco! Já estamos te redirecionando ao servidor, aguarde.",
  ["AguardandoBan"]      = "Informação Ainda Não Coletada - Aguarde: Banimentos...",
  ["InfoBanColetada"]    = "Informação Coletada - Banimentos[!]",
  ["Banido"]             = "Você está banido do servidor. Procure a staff caso isso for um erro",
  ["NãoEstaBanido"]      = "Informação: Você não está banido",
  ["ChcandoWL"]          = "Informação: Checando Whitelist",
  ["WhitelistOFF"]       = "IGNORANDO: A Whitelist está desativada.",
  ["NãoEstaWL"]          = "Checagem Concluída: Você não está em nossa Whitel1st! Entre no Discord",
  ["EstaWL"]             = "Checagem Concluída: Você está em nossa Whitelist",
  ["BemVindo"]           = "Bem Vindo(a)",
  ["ChecandoSteamMSG"]   = "Informação: Checando presença do STEAM",
  ["SteamNaoPresente"]   = "Checagem Concluída: Steam Inativa. Reinicie o client, abra a Steam e volte aqui.",
  ["StemEstaPresente"]   = "Checagem Concluída: Steam Ativa. Continuando Login.",
  ["PreparandoStats"]    = "Informação: Preparando estatisticas, aguarde. Isso pode demorar um pouco dependendo do servidor.",
  ["StatsConcluido"]     = "Informação: Estatisticas Preparadas. Continuando",
}

--> Posição de Spawn de um jogador novo. Primeiro login após a criação
LoginConfig.NewPlayerSpawnPosition = {x = -324.52, y = 760.8, z = 121.65}

--> Sistema de Whitelist
LoginConfig.Whitelist = true

LoginConfig.Survival = {}
--------------------------------------------------------------------
-- ! Todas as com o pref. Survival, são do sistema de sobrevivência
--------------------------------------------------------------------
--> Vida máxima. De preferencia deixe em 100
LoginConfig.Survival.VidaMaxima = 100
--> Tempo(em segundos) para ir ao hospital após a morte
LoginConfig.Survival.TempoHP    = 300
--> Spawn de um jogador após a morte
LoginConfig.Survival.SpawnLocation = {x = -384.51, y = 731.58, z = 115.56}
function _Framework.LoginConfig()
  return LoginConfig
end
