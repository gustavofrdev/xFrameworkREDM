Config = {}

Config.UseTeleports = true
Config.Blips = false

-- Change interior_sets with the interior you want at that location
-- https://github.com/femga/rdr3_discoveries/blob/399df3278b5101af1044f205c045648d2c8bcb38/interiors/interior_sets/README.md

Config.Shacks = {

    ['cattail_pond'] = {
        ['outside'] = vector3(-1085.63, 714.14, 103.32),
        ['inside'] = vector3(-1085.63, 714.14, 83.23),
        ['interior'] = 77569,
        ['interior_sets'] = {
            "mp006_mshine_band2",
            "mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_1",
            "mp006_mshine_hidden_door_open",
            "mp006_mshine_location1",
            "mp006_mshine_pic_02",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            "mp006_mshine_Still_02",
            "mp006_mshine_still_hatch",
            "mp006_mshine_theme_goth",
        }
    }
}
