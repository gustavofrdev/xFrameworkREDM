--> Update Munições

local police_em_servico = false

RegisterNetEvent("police_em_servico_status")
AddEventHandler("police_em_servico_status", function(i)
    police_em_servico = i
end)

local ammo_types = {
    {["AMMO_22"] = 2113196069},
    {["AMMO_22_TRANQUILIZER"] = -1903059161},
    {["AMMO_ARROW"] = 954660191},
    {["AMMO_ARROW_CONFUSION"] = 529538990},
    {["AMMO_ARROW_DISORIENT"] = -596647170},
    {["AMMO_ARROW_DRAIN"] = -1548100798},
    {["AMMO_ARROW_DYNAMITE"] = -1040876935},
    {["AMMO_ARROW_FIRE"] = 296901449},
    {["AMMO_ARROW_IMPROVED"] = -1841822177},
    {["AMMO_ARROW_POISON"] = 126245522},
    {["AMMO_ARROW_SMALL_GAME"] = -1368511730},
    {["AMMO_ARROW_TRACKING"] = 1657716792},
    {["AMMO_ARROW_TRAIL"] = -159383285},
    {["AMMO_ARROW_WOUND"] = -1233969318},
    {["AMMO_BOLAS"] = 34372170},
    {["AMMO_BOLAS_HAWKMOTH"] = 585177513},
    {["AMMO_BOLAS_INTERTWINED"] = -1699486271},
    {["AMMO_BOLAS_IRONSPIKED"] = -2017847322},
    {["AMMO_CANNON"] = -1231590751},
    {["AMMO_DYNAMITE"] = 480079517},
    {["AMMO_DYNAMITE_VOLATILE"] = 840671577},
    {["AMMO_HATCHET"] = 424030678},
    {["AMMO_HATCHET_ANCIENT"] = -1452241321},
    {["AMMO_HATCHET_CLEAVER"] = -1188697038},
    {["AMMO_HATCHET_DOUBLE_BIT"] = 1671758975},
    {["AMMO_HATCHET_DOUBLE_BIT_RUSTED"] = -893514737},
    {["AMMO_HATCHET_HEWING"] = -2063089161},
    {["AMMO_HATCHET_HUNTER"] = 446901936},
    {["AMMO_HATCHET_HUNTER_RUSTED"] = -1092841802},
    {["AMMO_HATCHET_VIKING"] = -452897925},
    {["AMMO_LASSO"] = -355466967},
    {["AMMO_LASSO_REINFORCED"] = -1367331108},
    {["AMMO_MOLOTOV"] = 1446246869},
    {["AMMO_MOLOTOV_VOLATILE"] = -2006166057},
    {["AMMO_MOONSHINEJUG"] = 1662813436},
    {["AMMO_MOONSHINEJUG_MP"] = 1701457723},
    {["AMMO_PISTOL"] = 1950175060},
    {["AMMO_PISTOL_EXPRESS"] = 836939099},
    {["AMMO_PISTOL_EXPRESS_EXPLOSIVE"] = 1185302722},
    {["AMMO_PISTOL_HIGH_VELOCITY"] = -1411815376},
    {["AMMO_PISTOL_SPLIT_POINT"] = 236338048},
    {["AMMO_POISONBOTTLE"] = 963726415},
    {["AMMO_REPEATER"] = -1330115686},
    {["AMMO_REPEATER_EXPRESS"] = -578347576},
    {["AMMO_REPEATER_EXPRESS_EXPLOSIVE"] = -1668585578},
    {["AMMO_REPEATER_HIGH_VELOCITY"] = 231465488},
    {["AMMO_REPEATER_SPLIT_POINT"] = 1148521608},
    {["AMMO_REVOLVER"] = 1681219929},
    {["AMMO_REVOLVER_EXPRESS"] = 1232099469},
    {["AMMO_REVOLVER_EXPRESS_EXPLOSIVE"] = 78180283},
    {["AMMO_REVOLVER_HIGH_VELOCITY"] = -2084181920},
    {["AMMO_REVOLVER_SPLIT_POINT"] = 1243983880},
    {["AMMO_RIFLE"] = 218444191},
    {["AMMO_RIFLE_ELEPHANT"] = -1282254562},
    {["AMMO_RIFLE_EXPRESS"] = 1654725195},
    {["AMMO_RIFLE_EXPRESS_EXPLOSIVE"] = 1838310467},
    {["AMMO_RIFLE_HIGH_VELOCITY"] = 1858824185},
    {["AMMO_RIFLE_SPLIT_POINT"] = 200254898},
    {["AMMO_SHOTGUN"] = -1878508229},
    {["AMMO_SHOTGUN_BUCKSHOT_INCENDIARY"] = -1077205471},
    {["AMMO_SHOTGUN_SLUG"] = 314966081},
    {["AMMO_SHOTGUN_SLUG_EXPLOSIVE"] = 588559146},
    {["AMMO_THROWING_KNIVES"] = -1639263599},
    {["AMMO_THROWING_KNIVES_CONFUSE"] = -1860710511},
    {["AMMO_THROWING_KNIVES_DISORIENT"] = 1507636870},
    {["AMMO_THROWING_KNIVES_DRAIN"] = 1828724907},
    {["AMMO_THROWING_KNIVES_IMPROVED"] = 1222378998},
    {["AMMO_THROWING_KNIVES_JAVIER"] = -182641977},
    {["AMMO_THROWING_KNIVES_POISON"] = 2074469742},
    {["AMMO_THROWING_KNIVES_TRAIL"] = 1270940175},
    {["AMMO_THROWING_KNIVES_WOUND"] = -1857826511},
    {["AMMO_THROWN_ITEM"] = -837456848},
    {["AMMO_TOMAHAWK"] = 1235846615},
    {["AMMO_TOMAHAWK_ANCIENT"] = -228768324},
    {["AMMO_TOMAHAWK_HOMING"] = -1411922943},
    {["AMMO_TOMAHAWK_IMPROVED"] = -834103244},
    {["AMMO_TURRET"] = -1171435365}
}

function found_ammo_type_string(hash)
    for _, v in pairs(ammo_types) do
       for k2, v2 in pairs(v) do
            if hash == v2 then 
                return k2
            end
       end
    end
end
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, 0, false)
        if weaponHash then 
            if weaponHash ~= -1569615261 and weaponHash ~= 1742487518 then 
                local type = GetPedAmmoTypeFromWeapon(PlayerPedId(), weaponHash)
                local type_string = found_ammo_type_string(type)
                if type_string == nil then 
                    print "Não existe munição para este tipo de arma... goto continue"
                    goto continue
                end
                local bullets = Citizen.InvokeNative(0x39D22031557946C1, PlayerPedId(), type)
                if not bullets then bullets = 0 end
                --" <tipo de munição>> ",string.lower(type_string), " <Quantidade atual>> ",bullets, "<weapon hash>>", weaponHash)
                if bullets and bullets >= 0 then
                    FrameworkSV.SetBulletFor(string.lower(type_string), bullets)
                end
                ::continue::
            end
        end
    end
end)
function _Framework.giveAmmoByType(ammoTypeT)
    local ped = PlayerPedId()
    for k, v in pairs(ammoTypeT) do 
        local hash = GetHashKey(k)
        SetPedAmmoByType(ped, hash, parseInt(v))
    end
end

function _Framework.giveAmmoByType_2(type, val)
    local ped = PlayerPedId()
    local hash = GetHashKey(type)
    local old = Citizen.InvokeNative(0x39D22031557946C1, PlayerPedId(), hash)
    if not old then old = 0 end
    --type, hash, parseInt(val), "toSet: "..parseInt(val+old))
    SetPedAmmoByType(ped, hash, parseInt(val+old))
end

function _Framework.useWeapon(weapon)
    --weapon, GetHashKey(weapon))
    -- GiveWeaponToPed_2(PlayerPedId(),tonumber(GetHashKey(weapon)),0,true,true,1,false,0.5,1.0,false,0)
    GiveDelayedWeaponToPed(PlayerPedId(), GetHashKey(weapon), 1, true, 2)
end
function _Framework.useWeapon_2(table)
    for k, v in pairs(table) do 
        --"arma: "..v.. " ".. GetHashKey(v))
        v = string.upper(v)
        Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(v), 0, true, 1, false, 0.0)
        Wait(500)
    end
end
local weapons = {                                   -- {0x0C45B2DE,0xD49321D4,},
    {'weapon_melee_knife_jawbone','group_melee',},                                      -- {0x1086D041,0xD49321D4,},                                       -- {0x1D7D0737,0xD49321D4,},
    {'weapon_melee_machete','group_melee',},                                            -- {0x28950C71,0xD49321D4,},                                       -- {0x64514239,0xD49321D4,},
    {'weapon_melee_torch','group_melee',},                                              -- {0x67DC3FDE,0xD49321D4,},                                   -- {0xDA54DD53,0xD49321D4,},
    {'weapon_melee_knife','group_melee',},                                              -- {0xDB21AC8C,0xD49321D4,},                                     -- {0xFA66468E,0xD49321D4,}, 
    {'weapon_pistol_volcanic','group_pistol',},                                         -- {0x020D13FF,0x18D5FA97,},                                  -- {0x4AAE5FFA,0x18D5FA97,},
    {'weapon_pistol_m1899','group_pistol',},                                            -- {0x5B78B8DD,0x18D5FA97,},
    {'weapon_pistol_semiauto','group_pistol',},                                         -- {0x657065D6,0x18D5FA97,},
    {'weapon_pistol_mauser','group_pistol',},                                           -- {0x8580C63E,0x18D5FA97,},
    {'weapon_repeater_evans','group_repeater',},                                        -- {0x7194721E,0xDC8FB3E9,},                              -- {0x7BD9C820,0xDC8FB3E9,},
    {'weapon_repeater_henry','group_repeater',},                                        -- {0x95B24592,0xDC8FB3E9,},
    {'weapon_repeater_winchester','group_repeater',},                                   -- {0xA84762EC,0xDC8FB3E9,},                            -- {0xBE76397C,0xDC8FB3E9,},
    {'weapon_repeater_carbine','group_repeater',},                                      -- {0xF5175BA1,0xDC8FB3E9,},                         -- {0x0247E783,0xBE5B8969,},
    {'weapon_revolver_doubleaction','group_revolver',},                                 -- {0x0797FBF5,0xBE5B8969,},
    {'weapon_revolver_cattleman','group_revolver',},                                    -- {0x169F59F7,0xBE5B8969,},
    {'weapon_revolver_cattleman_mexican','group_revolver',},                            -- {0x16D655F7,0xBE5B8969,},                        -- {0x514B39A1,0xBE5B8969,},
    {'weapon_revolver_lemat','group_revolver',},                                        -- {0x5B2D26B5,0xBE5B8969,},                             -- {0x6DFE44AB,0xBE5B8969,},
    {'weapon_revolver_schofield','group_revolver',},                                    -- {0x7BBD1FF6,0xBE5B8969,},               -- {0x8384D5FE,0xBE5B8969,},
    {'weapon_revolver_doubleaction_gambler','group_revolver',},                         -- {0x83DD5617,0xBE5B8969,},                           -- {0xFA4B2D47,0xBE5B8969,},
    {'weapon_rifle_springfield','group_rifle',},                                        -- {0x63F46DE6,0x39D5C192,},
    {'weapon_rifle_boltaction','group_rifle',},                                         -- {0x772C8DD6,0x39D5C192,},                                  -- {0xD853C801,0x39D5C192,},
    {'weapon_rifle_varmint','group_rifle',},                                            -- {0xDDF7BC1E,0x39D5C192,},
    {'weapon_shotgun_sawedoff','group_shotgun',},                                       -- {0x1765A8F8,0x33431399,},
    {'weapon_shotgun_doublebarrel_exotic','group_shotgun',},                            -- {0x2250E150,0x33431399,},
    {'weapon_shotgun_pump','group_shotgun',},                                           -- {0x31B7B9FE,0x33431399,},
    {'weapon_shotgun_repeating','group_shotgun',},                                      -- {0x63CA782A,0x33431399,},
    {'weapon_shotgun_semiauto','group_shotgun',},                                       -- {0x6D9BB970,0x33431399,},
    {'weapon_shotgun_doublebarrel','group_shotgun',},                                   -- {0x6DFA071B,0x33431399,},                       -- {0x4E328256,0xB7BBD827,},
    {'weapon_sniperrifle_carcano','group_sniper',},                                     -- {0x53944780,0xB7BBD827,},
    {'weapon_sniperrifle_rollingblock','group_sniper',},                                -- {0xE1D2B317,0xB7BBD827,},
    {'weapon_melee_hatchet','group_thrown',},                                           -- {0x09E12A01,0x5C4C5883,},                                  -- {0x21CCCA44,0x5C4C5883,},
    {'weapon_melee_hatchet_hunter','group_thrown',},                                    -- {0x2A5CF9D6,0x5C4C5883,},                        -- {0x39B815A2,0x5C4C5883,},
    {'weapon_thrown_molotov','group_thrown',},                                          -- {0x7067E7A7,0x5C4C5883,},                                  -- {0x74DC40ED,0x5C4C5883,},
    {'weapon_thrown_tomahawk_ancient','group_thrown',},                                 -- {0x7F23B6C7,0x5C4C5883,},                      -- {0x8F0FDE0E,0x5C4C5883,},
    {'weapon_thrown_tomahawk','group_thrown',},                                         -- {0xA5E972D7,0x5C4C5883,},
    {'weapon_thrown_dynamite','group_thrown',},                                         -- {0xA64DAA5E,0x5C4C5883,},
    {'weapon_melee_hatchet_double_bit','group_thrown',},                                -- {0xBCC63763,0x5C4C5883,},
    {'weapon_thrown_throwing_knives','group_thrown',},                                  -- {0xD2718D48,0x5C4C5883,},                       -- {0xE470B7AD,0x5C4C5883,},
    {'weapon_melee_cleaver','group_thrown',},                                           -- {0xEF32A25D,0x5C4C5883,},                                            -- {0xF62FB3A3,0xC715F939,},
    {'weapon_melee_davy_lantern','group_held',},                                          -- {0x4A59E501,0xC715F939,},                                  -- {0x3155643F,0xC715F939,},
    {'weapon_kit_binoculars','group_held',},                                              -- {0xF6687C5A,0xC715F939,},
    {'weapon_kit_camera','group_held',},                                                  -- {0xc3662b7d,0xc715f939,},                                          -- {0x791bbd2c,0xb5fd67cd,},
    {'weapon_bow','group_bow',},                                                         -- {0x88a8505c,0xb5fd67cd,},
    {'weapon_fishingrod','group_fishingrod',},                                                  -- {0xaba87754,0x60b51da4,},
    {'weapon_lasso','group_lasso',},                                                       -- {0x7a8a724a,0x126210c3,},
    {'weapon_kit_camera_advanced','group_held',},                
    {'weapon_melee_machete_horror','group_melee',},                
    {'weapon_bow_improved','group_bow',},                  
    {'weapon_rifle_elephant','group_rifle',},                  
    {'weapon_revolver_navy','group_revolver',},                
    {'weapon_lasso_reinforced','group_lasso',},                
    {'weapon_kit_binoculars_improved','group_held',},                
    {'weapon_melee_knife_trader','group_melee',},                  
    {'weapon_melee_machete_collector','group_melee',},                 
    {'weapon_moonshinejug_mp','group_petrolcan',},                 
    {'weapon_thrown_bolas','group_thrown',},                   
    {'weapon_thrown_poisonbottle','group_thrown',}, 
    {'weapon_kit_chumbo_detector','group_held',}, 
    {'weapon_revolver_navy_crossover','group_revolver',}, 
    {'weapon_thrown_bolas_hawkmoth','group_thrown',},
    {'weapon_thrown_bolas_ironspiked','group_thrown',},
    {'weapon_thrown_bolas_intertwined','group_thrown',},
}
function findWeaponName(hash)
    for k, v in pairs(weapons) do
        if GetHashKey(v[1]) == hash then 
            return v[1]
        end
    end
end

local bullets = 0 
RegisterCommand("garmas", function()
    if police_em_servico then TriggerEvent("xFramework:Notify", "negado", "Policais em Serviço não podem usar GARMAS!") return end
    local ped_weapons = {}
    local ped_ammo = {}
    for _, v in pairs(weapons) do
        if HasPedGotWeapon(PlayerPedId(), GetHashKey(v[1]), false) then 
            -- if string.lower(findWeaponName(GetHashKey(v[1])) == "weapon_melee_torch") then return end; 
            table.insert(ped_weapons, findWeaponName(GetHashKey(v[1]))) 
            local type = Citizen.InvokeNative(0x5C2EA6C44F515F34,GetHashKey(v[1]))
            local string_type = found_ammo_type_string(type)
            if string_type then 
                bullets = Citizen.InvokeNative(0x39D22031557946C1, PlayerPedId(), type)
                if not bullets then bullets = 0 end
                if bullets and type then 
                    ped_ammo[string_type] = bullets
                else 
                    ped_ammo[string_type] = 0
                end
                --string_type, bullets)
            else
                print "string type não encontrada."
            end
        end
    end
    for ammo,qnt in pairs(ped_ammo) do
        if qnt > 0 then 
            FrameworkSV.backAmmo(ammo,qnt, "__pass__")
        end
    end
    for _, gun in pairs(ped_weapons) do 
        FrameworkSV.backGun(gun,"_pass_")
     end
    Citizen.InvokeNative(0x1B83C0DEEBCBB214, PlayerPedId())
    RemoveAllPedWeapons(PlayerPedId(), true, true)
    Citizen.InvokeNative(0x1B83C0DEEBCBB214,PlayerPedId())
end)
