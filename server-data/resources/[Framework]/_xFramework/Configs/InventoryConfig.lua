local InventoryConfig = {}

InventoryConfig.Defaults = {
    Item_Event_Prefix_Default = 'xFramework_ItemFunction:'
}
InventoryConfig.Itens = {
    -- ! Atenção em InventoryConfig.Defaults.Item_Event_Prefix_Default. Quando fizer um item, sua função deve ser em forma de evento obrigatoriamente do lado server
    -- ! Exemplo: Evento[xFramework_ItemFunction:maca ==> Função]
    -- O unico tipo que interessa é o "usar". Apenas ele recebe alguma ação especial -- Os outros são para organizar
    -- Limite: Defina um valor alto, como 99999 para "não ter" limite. Eu sei que poderia fazer algo pra por FALSE ali, mas preferi pela simplicidade
    -- O resto é intuitivo. Não tem muito o que explicar, como Descrição, Label, peso, etc.
    ['dinheiro'] = {
        Descricao = 'Dinheiro',
        Label = 'Dinheiro',
        Peso = 0,
        Tipo = 'Não-Usável',
        Limite = -1
    },
    ['peneira'] = {
        Descricao = 'Peneira',
        Label = 'Peneira',
        Peso = 0.5,
        Tipo = 'Usar',
        Limite = -1
    },
    ['milho'] = {
        Descricao = '',
        Label = 'Milho',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['mochila'] = {
        Descricao = '',
        Label = 'Mochila',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['bandana'] = {
        Descricao = '',
        Label = 'Bandana',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ["polvora"] = {
        Descricao = "", 
        Label = "Polvora",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["zinco"] = {
        Descricao = "", 
        Label = "Zinco",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["cobre"] = {
        Descricao = "", 
        Label = "Cobre",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["agua"] = {
        Descricao = "", 
        Label = "Água",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["pera"] = {
        Descricao = "", 
        Label = "Pera",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["banana"] = {
        Descricao = "", 
        Label = "Banana",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ["cenoura"] = {
        Descricao = "", 
        Label = "Cenoura",
        Peso = 0,
        Tipo = "Usar",
        Limite = -1
    },
    ['madeira'] = {
        Descricao = '',
        Label = 'Galho de madeira',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_arrow_dymamite'] = {
        Descricao = '',
        Foto = "ammo_arrow_disorient",
        Label = 'Flecha Dinamite',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_melee_cleaver'] = {
        Descricao = '',
        Label = 'Machado Arremesável',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_arrow_fire'] = {
        Descricao = '',
        Label = 'Flecha Flamejante',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_bow_improved'] = {
        Descricao = '',
        Foto = 'weapon_bow',
        Label = 'Arco Aprimorado',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    -- weapon_bow_improved
    ['cacto'] = {
        Descricao = '',
        Label = 'Cacto',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['lockpick'] = {
        Descricao = '',
        Label = 'Lockpick',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['chumbo'] = {
        Descricao = '',
        Label = 'chumbo',
        Peso = 0,
        Foto = "prata_bruto",
        Tipo = 'Usar',
        Limite = -1
    },
    --[[javali  cogumelo  sopa javali  35%

    bode  cenoura    Sopa de bode 30% 
    
    pato cacto   sopa de pato  20%
    
    peru selvage cogumelo sopa de peru 25%
    
    frango milho sopa de frango  15%
    
    iguana verde cenouro sopa de iguana   50%
    
    angus  cacto  sopa de angus  40%]]
    ['ensopado_cenoura'] = {
        Descricao = '',
        Label = 'Ensopado de bode com cenora',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_javali'] = {
        Descricao = '',
        Label = 'Ensopado de Javali com Cogumelo',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_pato'] = {
        Descricao = '',
        Label = 'Ensopado de pato com cacto',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_peru'] = {
        Descricao = '',
        Label = 'Ensopado de peru selvagem com cogumelo',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_frango'] = {
        Descricao = '',
        Label = 'Ensopado de Frango com milho',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_angus'] = {
        Descricao = '',
        Label = 'Ensopado de Angus com cacto',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['ensopado_iguana'] = {
        Descricao = '',
        Label = 'Ensopado de iguana verde com cenoura',
        Peso = 0,
        Tipo = 'Usar',
        Foto = "ensopado",
        Limite = -1
    },
    ['cogumelo'] = {
        Descricao = '',
        Label = 'Cogumelo',
        Peso = 0,
        Tipo = 'Usar',
        Limite = -1
    },
    ['mercurio'] = {
        Descricao = 'Mercúrio',
        Label = 'Mercúrio',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 1
    },
    ['mapa'] = {
        Descricao = 'Mapa',
        Label = 'Mapa',
        Peso = 0.001,
        Tipo = 'Não-Usável',
        Limite = 1
    },
    ['fogueira'] = {
        Descricao = 'Fogueira',
        Label = 'Fogueira',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['escova'] = {
        Descricao = 'Escova para cavalos',
        Label = 'Escova',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 1
    },
    ['feno'] = {
        Descricao = 'Comida para cavalo ',
        Label = 'Feno',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 10
    },
    ['maca'] = {
        Descricao = 'Comida para cavalo ',
        Label = 'Maçã',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 10
    },
    ['semente_acucar'] = {
        Descricao = 'Semente/açucar ',
        Label = 'Semente de Açucar',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 999
    },
    ['regador'] = {
        Descricao = 'Regar plantas',
        Label = 'Regador',
        Peso = 2,
        Tipo = 'Usar',
        Limite = 999
    },
    ['semente_tabaco'] = {
        Descricao = 'Semente/tabaco ',
        Label = 'Semente de Tabaco',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 999
    },
    ['tabaco'] = {
        Descricao = 'tabaco ',
        Label = 'Tabaco',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 999
    },
    ['sugar'] = {
        Descricao = 'açucar ',
        Label = 'Açucar',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 999
    },
    ['painita_bruto'] = {
        Descricao = 'painita_bruto ',
        Label = 'Painita Bruta',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['painita'] = {
        Descricao = 'Painita',
        Label = 'Painita',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ouro_bruto'] = {
        Descricao = 'ouro_bruto ',
        Label = 'Ouro Bruto',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ouro'] = {
        Descricao = 'ouro ',
        Label = 'Ouro',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['cerveja'] = {
        Descricao = 'cerveja ',
        Label = 'Cerveja',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['whisky'] = {
        Descricao = 'Whisky',
        Label = 'Whisky',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['prata_bruto'] = {
        Descricao = 'prata_bruto ',
        Label = 'Prata Bruto',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['prata'] = {
        Descricao = 'prata',
        Label = 'Prata',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['diamante_bruto'] = {
        Descricao = 'diamante_bruto ',
        Label = 'Diamante Bruto',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['diamante'] = {
        Descricao = 'diamante',
        Label = 'Diamante',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    --> Ervas -->
    ['alecrim'] = {
        Descricao = 'Erva -> Alecrim',
        Label = 'Alecrim',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['aroeira'] = {
        Descricao = 'Erva -> Aroeira',
        Label = 'Aroeira',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['arruda'] = {
        Descricao = 'Erva -> Arruda',
        Label = 'Arruda',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['hortela'] = {
        Descricao = 'Erva -> Hortela',
        Label = 'Hortelã',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['boldo'] = {
        Descricao = 'Erva -> Boldo',
        Label = 'Boldo',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['guaco'] = {
        Descricao = 'Erva -> Guaco',
        Label = 'Guaco',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['oldbuckle'] = {
        Descricao = '',
        Label = 'Fivela Velha',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['oldwatch'] = {
        Descricao = '',
        Label = 'Relógio Velho',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['peacockfeather'] = {
        Descricao = '',
        Label = 'Pena de Pavão',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['rubyring'] = {
        Descricao = '',
        Label = 'Anel de Rúbi',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['goldtooth'] = {
        Descricao = '',
        Label = 'Dente de Ouro',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['piratecoin'] = {
        Descricao = '',
        Label = 'Moeda Pirata',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['camelia'] = {
        Descricao = '',
        Label = 'Camelia',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['primola'] = {
        Descricao = '',
        Label = 'Primola',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['gardenia'] = {
        Descricao = '',
        Label = 'Gardenia',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['corpuscularia'] = {
        Descricao = '',
        Label = 'Corpuscularia',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['bloodmary'] = {
        Descricao = '',
        Label = 'Bloodmary',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['veneno_cobra'] = {
        Descricao = '',
        Label = 'Veneno de Cobra ',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['heleboro'] = {
        Descricao = '',
        Label = 'Heleboro',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['gerbera'] = {
        Descricao = '',
        Label = 'Gerbera',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['dalia'] = {
        Descricao = '',
        Label = 'Dalia',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['violetta'] = {
        Descricao = '',
        Label = 'Violetta',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['girassol'] = {
        Descricao = '',
        Label = 'Girassol',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['viburno'] = {
        Descricao = '',
        Label = 'Viburno',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['galantus'] = {
        Descricao = '',
        Label = 'Ggalantus',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['elixir_vida'] = {
        Descricao = '',
        Label = 'Elixir da vida',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['elixir_morte'] = {
        Descricao = '',
        Label = 'Elixir da morte',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['elixir_energia'] = {
        Descricao = '',
        Label = 'Elixir da energia',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['veruns_morthari'] = {
        Descricao = '',
        Label = 'Veruns Morthari ',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['veruns_transformarun'] = {
        Descricao = '',
        Label = 'Veruns Transformarun',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['atration_tontelle'] = {
        Descricao = '',
        Label = 'Atration Tontelle',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['cocaina'] = {
        Descricao = '',
        Label = 'Cocaina',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['maconha'] = {
        Descricao = '',
        Label = 'Maconha',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['semente_maconha'] = {
        Descricao = '',
        Label = 'Semente de Maconha',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['semente_cocaina'] = {
        Descricao = '',
        Label = 'Semente de Cocaina',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 40
    },
    ['weapon_rifle_springfield'] = {
        Descricao = '',
        Label = 'Rifle Springfield',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_rifle'] = {
        Descricao = '',
        Label = 'Munição de Rifle',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_revolver'] = {
        Descricao = '',
        Label = 'Munição de Revolver',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_sniper'] = {
        Descricao = '',
        Label = 'Munição de Sniper',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_shotgun'] = {
        Descricao = '',
        Label = 'Munição de Shotgun',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_arrow'] = {
        Descricao = '',
        Label = 'Flecha',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_repeater'] = {
        Descricao = '',
        Label = 'Munição de Repetidoras',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['ammo_rifle_springfield'] = {
        Descricao = '',
        Label = 'Munição de Rifle',
        Peso = 0.1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_revolver_schofield'] = {
        Descricao = '',
        Label = 'Revolver Schofield',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_revolver_doubleaction_gambler'] = {
        Descricao = '',
        Label = 'Revolver Ação Dupla',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_sniperrifle_carcano'] = {
      Descricao = '',
      Label = 'Sniper Carcano',
      Peso = 3,
      Tipo = 'Usar',
      Limite = -1
  },
    ['bomba'] = {
      Descricao = '',
      Label = 'Bomba',
      Peso = 3,
      Tipo = 'Usar',
      Limite = -1
    },
    ['weapon_revolver_lemat'] = {
        Descricao = '',
        Label = 'Revolver Lemat',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_sniperrifle_rollingblock'] = {
        Descricao = '',
        Label = 'Sniper Rollingblock',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_shotgun_doublebarrel'] = {
        Descricao = '',
        Label = 'Shotgun Double Barrel',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_revolver_cattleman'] = {
        Descricao = '',
        Label = 'Revolver Cattleman',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_repeater_winchester'] = {
        Descricao = '',
        Label = 'Lancaster',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_lasso'] = {
        Descricao = '',
        Label = 'Laço',
        Peso = 1,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_melee_knife'] = {
        Descricao = '',
        Label = 'Faca de Caçador',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_melee_torch'] = {
        Descricao = '',
        Label = 'Tocha',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_melee_machete'] = {
        Descricao = '',
        Label = 'Machete Comum',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_melee_knife_jawbone'] = {
        Descricao = '',
        Label = 'Faca Jawbone',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['weapon_bow'] = {
        Descricao = '',
        Label = 'Arco',
        Peso = 3,
        Tipo = 'Usar',
        Limite = -1
    },
    ['tonico_ar_'] = {
        Descricao = ' [50% - bom] + tela zoada 30s',
        Label = 'Tônico de Alecrim com Arruda',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['tonico_aa_'] = {
        Descricao = '[25% - médio] + tela zoada 10s',
        Label = 'Tônico de Alecrim com Aroeira',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['tonico_ga_'] = {
        Descricao = '[60% - bom] + tela zoada 45s',
        Label = 'Tônico de Guaco com Arruda',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['tonico_ba_'] = {
        Descricao = '[30% - mega ruim] + tela zoada 60s',
        Label = 'Tônico de Boldo com Hortelã',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['tonico_aga_'] = {
        Descricao = '[80% - Super Bom] + tela zoada 60s',
        Label = 'Tônico de Alecrim, Guaco e Arruda',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['tonico_gh_'] = {
        Descricao = '[15%] + n/a tela zoada',
        Label = 'Tônico de Guaco com Hortelã',
        Peso = 1,
        Tipo = 'Usar',
        Limite = 2
    },
    ['carta_0x'] = {
        Descricao = 'Carta ',
        Label = 'Carta',
        Peso = 1,
        Tipo = 'Especial',
        Limite = 10
    }
}

function _Framework.InventoryConfig()
    return InventoryConfig
end
function _Framework.UpdateConfig(iv)
    InventoryConfig = iv
end
