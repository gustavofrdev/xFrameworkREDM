config = {}
config.job = {}
config.posicao = {3357.39, -677.65, 46.28}

config.pegoMsg = "Você foi pego tentando fugir da cadeia... Mais sorte da próxima vez, amigo."

config.startMsg = "[G] iniciar trabalhos para redução de pena."
config.startMsg2 = "[G] Selecionar & Embalar maçãs"
config.startMsg3 = "[G] Entregar saco"

config.msg1 = "Vá até a área onde contém maçãs para selecionar e embalar maçãs"
config.msg2 = "Agora, entregue elas até o local marcado"
config.msg3 = "Trabalho concluído"

config.faltam = "Ainda faltam time_prisao minutos de cadeia"


config.job.posicoes = {
    Start = {3364.44, -701.92, 45.54},
    Analise = {3353.0, -688.59, 44.06, 232.892},
    Final = {3361.76, -655.04, 46.33, 105.900},
}

config.saida = {3350.84, -644.08, 45.3}

config.job.reducaoPenalPass = 1

config.job.anicoes = {
    Start = "S/N",
    Analisando = "rezar",
    PegarSaco = "saco",
    JogarSaco = "saco2"
}

function t_Framework.JailConfig()
    return config
  end
  