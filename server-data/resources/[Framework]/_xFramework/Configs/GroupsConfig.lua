local GroupsConfig = {}

--[[
! Configuração de Grupos da xFramework
]]

--> Configuração de todos os grupos do servidor!
--> Não é possível setar alguém em um grupo não listado
--> Basta seguir o padrão
--> Não é possível setar alguém com 2 grupos dos mesmo tipo. Existem exceções.

GroupsConfig.salaryRecieveTime = 20 --> Minutes

GroupsConfig.Grupos = {

  ["Dono"] = {
    nome       = "Dono",
    tipo       = "superior",
    permissoes = {
      "*", --> Dá acesso para qualquer permissão.
      "admin.permissao", "dono.permissao", "skin.permissao", "skin.animais.permissao", "comando.cavalo", "comando.wl","sistema.jornal.permissao",
      "comando.tptome", "comando.kill", "comando.god", "comando.money", "comando.item", "comando.players", "verids", "criar.tesouro","comando.removevip",
      "comando.tpto", "comando.tptome", "comando.tpback", "comando.tpway", "comando.tpcds", "comando.raio","comando.fogo", "comando.setvip", 
      "comando.cds", "comando.ungroup", "comando.group", "comando.nc", "comando.kick", "comando.ban", "comando.unban", "controlar.clima"
    },
    salario = {  ativo = false,  valor = 0},
    BonusItem  = 0
  },
  ["Vip1"] = {
      nome      = "",
      tipo      = "vip",
      permissoes = {
        "cavalos.upgrades.stamina", "cavalos.upgrades.limpar", "vipcavalo.permissao"
      },
      salario = {  ativo = false,   valor = 0},
      bonusItem = 0
    },
    ["dev"] = {
      nome      = "",
      tipo      = "dev",
      permissoes = {
        "dev.permissao"
      },
      salario = {  ativo = false,   valor = 0},
      bonusItem = 0
    },
  ["Bruxas1"] = {
    nome      = "Bruxas",
    tipo      = "bruxas",
    permissoes = {
      "skin.animais.permissao", "skin.permissao",
      "comando.raio","comando.fogo","comando.god", 
      "controlar.clima", "elixir.permissao", "verids"
    },
    salario = {  ativo = false,   valor = 0},
    bonusItem = 0
  },
  ["Bruxas2"] = {
    nome      = "Bruxas2",
    tipo      = "bruxas2",
    permissoes = {},
    salario = {  ativo = false,   valor = 0},
    bonusItem = 0
  },
  ["Bruxas3"] = {
    nome      = "Bruxas3",
    tipo      = "bruxas3",
    permissoes = {},
    salario = {  ativo = false,   valor = 0},
    bonusItem = 0
  },
  ["Jornalista"] = {
    nome      = "Jornalista",
    tipo      = "emprego",
    permissoes = {
      "sistema.jornal.permissao"
    },
    salario = {  ativo = true,   valor = 5},
    bonusItem = 0
  },
  ["Policia1"] = {
    nome       = "Policial",
    tipo       = "emprego",
    permissoes = {"policia.permissao"},
    salario = {  ativo = true,   valor = 180},
    BonusItem  = 0
  },
  ["Policia2"] = {
    nome       = "Policial",
    tipo       = "emprego",
    permissoes = {"policia.permissao", "cargo2.policia"},
    salario = {  ativo = true,   valor = 180},
    BonusItem  = 0
  },
  ["Medico"] = {
    nome        = "Médico",
    tipo        = "emprego",
    permissoes  = {"medico.permissao"},
    salario = {  ativo = true,   valor = 180},
    BonusItem   = 0
  },
  ["Indios"] = {
    nome        = "Indio",
    tipo        = "indio",
    permissoes  = {"indio.permissao"},
    salario = {  ativo = false,   valor = 0},
    BonusItem   = 0
  },
  ["Bandido1"] = {
    nome        = "Bandido1",
    tipo        = "Bandido1",
    permissoes  = {"bandido1.permissao"},
    salario = {  ativo = false,   valor = 0},
    BonusItem   = 0
  },
  ["Bandido2"] = {
    nome        = "Bandido2",
    tipo        = "Bandido2",
    permissoes  = {"bandido2.permissao"},
    salario = {  ativo = false,   valor = 0},
    BonusItem   = 0
  },
  ["skin"] = {
    nome        = "",
    tipo        = "skin_manager",
    permissoes  = {"skin.permissao"},
    salario = {  ativo = false,   valor = 0},
    BonusItem   = 0
  }

}

--> StartIDS são os ids que ao logar no servidor, já entrarão com a permissão especificada automaticamente
--> Também só seguir o padrão. O que está dentro de [] é o id, e o que está em {""} é o grupo
GroupsConfig.StartIDS = {
  [1] = {"Dono"},
  [2] = {"Dono"},
  [3] = {"Dono"},
  [4] = {"Dono"},
  [5] = {"Dono"},
  [6] = {"Dono"},
  [7] = {"Dono"},
  [8] = {"Dono"},
  [9] = {"Dono"},



}
function _Framework.GroupsConfig()
  return GroupsConfig
end
