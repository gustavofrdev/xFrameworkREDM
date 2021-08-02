Config = {}
Config.Interval = 30 --(mins)
Config.Blip = {
  Sprite = 1754506823,
  BlipName = "Tesouro"
}
Config.Animals = {
    -- Animal | Habitat
    [1] = {"Pantano","A_C_Alligator_01"},
    [2] = {"Pantano","A_C_Alligator_01"},
    [3] = {"Pantano","A_C_Alligator_01"},
    [4] = {"Pantano","A_C_Alligator_01"},
    [5] = {"Pantano","A_C_Alligator_01"},
    [6] = {"Pantano","A_C_Alligator_01"},
    [7] = {"Pantano","A_C_Alligator_01"},
    [8] = {"Pantano","A_C_Alligator_01"},
    [9] = {"Pantano","A_C_Alligator_01"},
    [10]= {"Pantano","A_C_Alligator_01"},

    [11] = {"Neve","A_C_Bear_01"},
    [12] = {"Neve","A_C_Bear_01"},
    [13] = {"Neve","A_C_Bear_01"},
    [14] = {"Neve","A_C_Bear_01"},
    [15] = {"Neve","A_C_Bear_01"},

    [16] = {"Arido","A_C_Alligator_01"},
    [17] = {"Arido","A_C_Alligator_01"},
    [18] = {"Arido","A_C_Alligator_01"},
    [19] = {"Arido","A_C_Alligator_01"},
    [20] = {"Arido","A_C_Alligator_01"},

    [21] = {"Arido","A_C_LionMangy_01"},
    [22] = {"Arido","A_C_LionMangy_01"},
    [23] = {"Arido","A_C_LionMangy_01"},
    [24] = {"Arido","A_C_LionMangy_01"},
    [25] = {"Arido","A_C_LionMangy_01"},
}
Config.AssassinPedModel = "s_m_m_valdeputy_01"

Config.Tesouro_Locais = {
  {
    x = 2092.84, 
    y = -1680.09, 
    z = 41.79,
    Animais = {
      [1] = {x = 2096.31, y = -1696.82, z = 40.62},
      [2] = {x = 2082.22, y = -1699.92, z = 41.26},
      [3] = {x = 2070.76, y = -1700.06, z = 40.6},
      [4] = {x = 2077.7, y = -1694.94, z = 41.8},
      [5] = {x = 2084.94, y = -1679.95, z = 40.53},
      [6] = {x = 2095.84, y = -1673.43, z = 41.86},
      [7] = {x = 2095.34, y = -1654.93, z = 40.46},
      [8] = {x = 2102.66, y = -1649.85, z = 41.09},
      [9] = {x = 2110.55, y = -1656.8, z = 40.46},
      [10] = {x = 2109.59, y = -1662.25, z = 41.03}
    },
    Peds = {
      [1] = {x = 2098.03, y = -1687.04, z = 41.87},
      [2] = {x = 2084.84, y = -1690.0, z = 41.62},
      [3] = {x = 2101.14, y = -1666.52, z = 41.97},
      [4] = {x = 2088.58, y = -1683.63, z = 41.67},
    },
    Habitat = "Pantano",
    Bau_anim_pos = {2092.88, -1680.77, 41.83},
    Bau_anim_heading = 353.317,
    itens = {
      [1] = {"dinheiro", 30},
      [2] = {"goldtooth", 30},
      [3] = {"piratecoin", 30}
    }
  },

  {
    x = -1755.61, y = 1689.98, z = 237.84,
    Animais = {
      [11] = {x = -1765.13, y = 1705.49, z = 236.87},
      [12] = {x = -1773.65, y = 1694.72, z = 239.1},
      [13] = {x = -1752.66, y = 1683.13, z = 237.63},
      [14] = {x = -1745.78, y = 1694.02, z = 236.63},
      [15] = {x = -1769.73, y = 1705.44, z = 237.38},
    },
    Peds = {
      [1] = {x = -1752.8, y = 1690.62, z = 237.55},
      [2] = {x = -1756.62, y = 1687.31, z = 238.04},
      [3] = {x = -1760.62, y = 1688.04, z = 238.37},
      [4] = {x = -1761.8, y = 1691.71, z = 238.46},
    },
    Habitat = "Neve",
    Bau_anim_pos = {-1755.54, 1689.32, 237.87},
    Bau_anim_heading = 1.5185,
    itens = {
      [1] = {"dinheiro", 30},
      [2] = {"goldtooth", 30},
      [3] = {"piratecoin", 30}
    }
  },
  
  {
    x = -3401.8, y = -3306.32, z = -4.45,
    Animais = {
      [16] = {x = -3410.31, y = -3290.29, z = -6.18},
      [17] = {x = -3414.61, y = -3296.81, z = -5.71},
      [18] = {x = -3406.01, y = -3300.15, z = -5.26},
      [19] = {x = -3392.12, y = -3298.27, z = -5.23},
      [20] = {x = -3390.59, y = -3293.3, z = -6.11},

      [21] = {x = -3425.3, y = -3294.74, z = -6.23},
      [22] = {x = -3423.23, y = -3294.1, z = -6.21},
      [23] = {x = -3419.66, y = -3296.8, z = -5.84},
      [24] = {x = -3420.99, y = -3304.94, z = -4.95},
      [25] = {x = -3413.41, y = -3301.92, z = -5.34},
    },
    Peds = {
      [1] = {x = -3399.4, y = -3305.79, z = -4.45},
      [2] = {x = -3401.75, y = -3301.04, z = -4.44},
      [3] = {x = -3399.1, y = -3301.01, z = -4.44},
      [4] = {x = -3400.91, y = -3298.0, z = -5.25},
    },
    Habitat = "Arido",
    Bau_anim_pos = {-3401.73, -3307.01, -4.45},
    Bau_anim_heading = 11.673,
    itens = {
      [1] = {"dinheiro", 10},
      [2] = {"goldtooth", 30},
      [3] = {"piratecoin", 30}
    }
  },
}