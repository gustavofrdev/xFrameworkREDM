Config = {}
Config.BlipName = 'Loja de roupas' -- Blip Name Showed on map
Config.BlipSprite = 1195729388 -- Clothing shop sprite
Config.BlipSpriteCloakRoom = 1496995379 -- Clothing shop sprite
Config.BlipScale = 0.2 -- Blip scale
Config.OpenKey = 0xD9D0E1C0 -- Opening key hash
Config.Price = 5 -- Price for clothes
Config.CanUseIfNoOwer = true 
Config.PrecoVendaRoupa = 10
Config.Divisao = 2 -- valor do precovenda / divisão. Nessa caso, 10/2 ======> 5
Config.Zones = {
    {
        Id = 1,
        Name = "Loja de roupas em Valentine",
        Price = 2000,
        Position = vector3(-325.53, 774.64, 117.47),
        BuyPos = vector3(-329.37, 780.26, 116.22),
        commandLocation = vector3(-325.77, 765.94, 121.64),
        hasOwner = false,
    },
    {
        Id = 2,
        Price = 2000,
        Name = "Loja de roupas em Blackwater",
        Position = vector3(-761.41, -1291.68, 43.86),
        BuyPos = vector3(-755.94, -1292.73, 43.66),
        commandLocation = vector3(-764.95, -1291.1, 43.84),
        hasOwner = false
    },
    {
        Id = 3,
        Price = 2000,
        Name = "Loja de roupas em Saint Denis",
        Position = vector3(2554.95, -1169.25, 53.79),
        BuyPos = vector3(-2549.53, -1174.85, 53.42),
           commandLocation = vector3(2550.57, -1159.52, 53.83),
        hasOwner = false
    },
    {
        Id = 4,
        Price = 2000,
        Name = "Loja de roupas em Tumbleweed",
        Position = vector3(-5487.32, -2938.98, -0.28),
        BuyPos = vector3(-5495.43, -2941.05, -1.06),
        commandLocation = vector3(-5483.76, -2932.51, -0.3),
        hasOwner = false
    }
}

Config.Label = {
    ['boot_accessories'] = 'Acessórios para sapatos',
    ['pants'] = 'Calças',
    ['cloaks'] = 'Mantos',
    ['hats'] = 'Chapéus',
    ['vests'] = 'Coletes',
    ['chaps'] = 'Calça de Montaria',
    ['shirts_full'] = 'Camisas',
    ['badges'] = 'Distintivos',
    ['masks'] = 'Mascáras',
    ['spats'] = 'Polainas de pano',
    ['neckwear'] = 'Pescoço',
    ['boots'] = 'Sapatos',
    ['accessories'] = 'Acessórios',
    ['jewelry_rings_right'] = 'Joias lado direito',
    ['jewelry_rings_left'] = 'Joias lado esquerdo',
    ['jewelry_bracelets'] = 'Braceletes',
    ['gauntlets'] = 'Manoplas',
    ['neckties'] = 'Gravata',
    ['holsters_knife'] = 'Coldre de facas',
    ['talisman_holster'] = 'Coldre Talismã',
    ['loadouts'] = 'Loadouts',
    ['suspenders'] = 'Suspensórios',
    ['talisman_satchel'] = 'Talisman Satchel',
    ['satchels'] = 'Mochila',
    ['gunbelts'] = 'Cintos de Armas',
    ['belts'] = 'Cinto',
    ['belt_buckles'] = 'Fivela',
	['bows'] = "Acessório de cabelo",
    ['holsters_left'] = 'Coldre Esquerdo',
    ['holsters_right'] = 'Coldre Direito',
    ['talisman_wrist'] = 'Pulso Talismã',
    ['coats'] = 'Casacos',
    ['coats_closed'] = 'Casacos Fechados',
    ['ponchos'] = 'Poncho',
    ['eyewear'] = 'Óculos',
    ['gloves'] = 'Luvas',
    ['holsters_crossdraw'] = 'Coldres Crossdraw',
    ['aprons'] = 'aventais',
    ['skirts'] = 'Saias'
}
