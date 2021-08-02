-- ! Configuração dos cavalos
-- ! Depende do script externo x_cavalos. Apenas a configuração é por aqui
local horseConfig = {}


--> Configuração de todos os cavalos disponíveis para a compra
--> Apenas seguir o padrão e criar novos cavalos. Atente-se com as virgulas.


horseConfig.cavalos = {
  {
    name             = "A_C_Horse_AmericanPaint_Greyovero",
    label            = "Cavalo American Paint Greyovero ",
    preco            = 2500,
    permission       = 'nenhum',
    descricao        = "Variação #1 American_Paint",
  },
  {
    name             = "A_C_Horse_AmericanPaint_Overo",
    label            = "Cavalo American Paint Overo",
    preco            = 2500,
    permission       = 'nenhum',
    descricao        = "Variação #2 American_Paint",
  },
  {
    name             = "A_C_HorseMule_01",
    label            = "Cavalo Steel Gray by Breton",
    preco            = 200,
    permission       = 'nenhum',
    descricao        = "Variação #1 Steel Gray",
  },
}

--> Configuração de todos as carroças disponíveis para a compra
--> Apenas seguir o padrão e criar novas carroças. Atente-se com as virgulas.


horseConfig.carrocas = {
  {
    name = "WAGON06X",
    label = "Carroça para Passageiros",
    preco = 50,
    permission = 'nenhum',
    descricao = "Carroça própia para o transporter de passageiros - EMPREGO."
  },
}

--> Aqui está a área onde podemos configurar o peso limite do inventário de cada cavalo(ped) ou carroça(entity)
--> É importando o valor ["Parao"] estar sempre definido, pois se não existir X cavalo nessa lista, a Framework irá-
--> Atrelar o peso daquele cavalo ou carroça ao valor Padrão.

horseConfig.Pesos = {
  Cavalos = {
    ["Padrao"] = 6,
    ['A_C_Horse_Criollo_Dun'] = 7,
  },
  Carrocas = {
    ["Padrao"] = 12,
    ['buggy01'] = 14
  }
}

--> Configure aqui todos os estabulos do servidor
--> Se atente bem sobre aonde termina as {}, pois se estiver qualquer coisa errada, o script x_cavalos não rodará como deve

--> -1818.44, -564.83, 156.17
horseConfig.Estabulos = {
  {
    nome = "Estábulo de Saint Denis", 
    x = 2510.71,
    y = -1456.59, 
    z = 46.12,
  cameras = {
    ['camHorse'] ={ 2506.807, -1452.29, 48.61699, -34.77003, 0.0, -35.20742 },
    ['CamHorseGear'] ={ 2508.876, -1451.953, 48.67999, -35.29771, 0.0, -0.4993192},
    ['camCart'] = {2506.428, -1437.7, 50.57832, -39.4497, 0.0, 120.535}
  },
  preview = {2508.59, -1449.96, 45.5, 90.09},
  Guardar_Cavalo = {2503.32, -1449.34, 46.12},
  previewVehicle = { 2503.47, -1441.89, 46.31, 0.24},
  },
  {
    nome = "Estábulo de Valentine",
    x = -366.14, y = 791.15, z = 116.27,
    preview = { -366.07, 781.81, 115.14, 5.97},
    previewVehicle = {-370.11, 786.99, 115.16, 274.18},
    Guardar_Cavalo = {-371.62, 787.04, 116.27},
    cameras = {
      ['camHorse'] = {-367.9267, 783.0237, 117.7778, -36.42624, 0.0, -100.9786 },
      ['CamHorseGear'] = {-1819.512, -558.6999, 157.6765, -23.95241, 0.0, 28.46066 },
      ['camCart'] = {-363.5831, 792.1113, 118.0419, -16.35144, 0.0, 143.9759}
    }
  },
  {
    nome = "Estábulo de Strawberry",
    x = -1818.44, y = -564.83, z = 156.17,
    preview = { -1820.26, -555.84, 155.16, 163.01 },
    previewVehicle = {  -1821.46, -561.41, 155.06, 256.24 },
    Guardar_Cavalo = {-1792.27, -577.03, 155.64},
    cameras = {
      ['camHorse'] = { -1819.512, -558.6999, 157.6765, -23.95241, 0.0, 28.46066 },
      ['CamHorseGear'] = {1819.512, -558.6999, 157.6765, -23.95241, 0.0, 28.46066},
      ['camCart'] = {-1816.372, -560.2017, 157.6678, -22.02157, 0.0, 124.3779}
    }
  },
  {
    nome = "Estábulo de Blackwater",
    x = -878.78, y = -1368.29, z = 43.63,
    preview = { -864.25, -1361.8, 42.7, 177.48  },
    previewVehicle = { -872.58, -1366.57, 42.53, 270.35 },
    Guardar_Cavalo = {-872.54, -1366.34, 43.64},
    cameras = {
      ['camHorse'] = { -862.6163, -1362.927, 45.58158, -40.96593, 0.0, 71.8129  },
      ['CamHorseGear'] = {-862.6163, -1362.927, 45.58158, -40.96593, 0.0, 71.8129},
      ['camCart'] = {-869.7852, -1361.103, 45.26991, -17.11994, 0.0, 161.4039 }
    }
  },
  {
    nome = "Estábulo de Tumbleweed",
    x = -5515.19, y = -3039.31, z = -2.28,
    preview = {  -5519.47, -3039.32, -3.31, 181.62 },
    previewVehicle = {  -5520.65, -3044.3, -3.39, 270.83  },
    Guardar_Cavalo = {-5520.39, -3044.2, -2.28},
    cameras = {
      ['camHorse'] = {  -5517.651, -3041.113, -0.50949, -33.14523, 0.0, 55.47822  },
      ['CamHorseGear'] = { -5517.651, -3041.113, -0.50949, -33.14523, 0.0, 55.47822 },
      ['camCart'] = {-5514.191, -3040.633, -0.5108569, -18.79705, 0.0, 141.3175 }
    }
  }
}

--> Posição de todos os locais de Pegar cavalos e carroças
--> Explicando o Padrão: Blip é aonde abre o Menu e Retirar é aonde ele irá aparecer após selecionado no menu
--> Blip:[X, Y, Z]
--> Retirar: [X, Y, Z, HEADING]

horseConfig.HorsePositions = {
  {
    Blip = {2502.0, -1454.64, 46.12},
    Retirar = {2508.78, -1453.24, 46.23, 0}
  },
  {
    Blip = {-360.98, 792.27, 116.31},
    Retirar = {-357.14, 792.68, 116.14, 254.957}
  },
  {
    Blip = {-1807.41, -583.17, 156.04},
    Retirar = {-1803.83, -578.56, 155.88, 0}
  },
  {
    Blip = {-882.33, -1361.75, 43.63},
    Retirar = {-886.19, -1361.27, 43.39, 0}
  },
  {
    Blip = {-5534.39, -3040.03, -1.66},
    Retirar = {-5534.96, -3052.04, -1.35, 0}
  }
}

horseConfig.CarrocaPositions = {
  {
    Blip = {2506.22, -1466.81, 46.13},
    Retirar = {2506.32, -1470.48, 46.05, 271.372}
  },
  {
    Blip = {-359.73, 782.67, 116.3},
    Retirar = {-359.29, 777.06, 116.27, 293.553}
  },
  {
    Blip = {-1801.77, -584.54, 155.95},
    Retirar = {-1800.47, -578.45, 156.06, 340.438}
  },
  {
    Blip = {-881.89, -1366.44, 43.64},
    Retirar = {-885.95, -1366.43, 43.64, 96.230}
  },
  {
    Blip = {-5534.93, -3037.3, -1.45},
    Retirar = {-5538.37, -3029.85, -1.19,43.68}
  } 
}

--> Botão do inventario do cavalo
--> Padrão: PgUp

horseConfig.botao_inventario = '0x446258B6'
function _Framework.HorseConfig()
return horseConfig
end

