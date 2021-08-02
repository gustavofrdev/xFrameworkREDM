-- framework -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tools = module('Server/CallBack/Callback_Tools')
local onetimeclose = false
local onetimeclose2 = false
local onetimeclose3 = false
local Config = {}
local operationTimer = 0
local nearStable
local opened = {}
local Cache = {}
local lastHeading = 0.0
local lastHeading2 = 0.0
local selectedHorsePositionIndex = 1
local selectedCarrocaPositionIndex = 1
local Core = Citizen
local Sleep = Core.Wait
local n = Core.InvokeNative
local CurrentCartAction = {}
local aT = 0
local CurrentHorseAction = {}
local spawnedHorse, tag
local info
local info2
local Mantas
local Cornetas
local Alforjes
local Caudas
local Cabelos
local Selas
local Estribos
local Saco_Dormir
local Lanterna
local Mascara
local Upgrades = {}
Cache['lastSpawnHorse'] = {}
Cache['lastSpawnVeh'] = {}
Cache['lastHorseName'] = ''
Cache['lastVehName'] = ''
Cache['CanPedBeReset'] = false
Cache['lastTunHorse'] = ''
Cache['SelectedPurcahse'] = ''
Cache['SelectedIndex'] = ''
Cache['NumberMenuSelected'] = tonumber(1)
Cache['actualspawnedcart'] = {}
Cache['actualspawnedcartname'] = ''
Cache['actualcartped'] = ''
Cache['px'] = 0
Cache['ActualTunningHorseName'] = ''
Cache['ActualTypeSpawn'] = ''
Cache['ActualHorsePed'] = ''
Function = {}
x_cavalosSV = Tunnel.getInterface('x_cavalos')
x_cavalosCL = Proxy.getInterface('x_cavalos')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')
Proxy.addInterface('x_cavalos', Function)
Tunnel.bindInterface('x_cavalos', Function)
Citizen.CreateThread(function()
for i=0,1000 do
print()
end
print("iniciado sem erros!")

end )
function Function.AtualizarTunningVar(NEW)
    if type(NEW) ~= 'boolean' then
        if NEW['Mantas'] then
            Mantas = NEW['Mantas']
        else
            Mantas = nil
        end
        if NEW['Cornetas'] then
            Cornetas = NEW['Cornetas']
        else
            Cornetas = nil
        end
        if NEW['Alforjes'] then
            Alforjes = NEW['Alforjes']
        else
            Alforjes = nil
        end
        if NEW['Caudas'] then
            Caudas = NEW['Caudas']
        else
            Caudas = nil
        end
        if NEW['Cabelos'] then
            Cabelos = NEW['Cabelos']
        else
            Cabelos = nil
        end
        if NEW['Selas'] then
            Selas = NEW['Selas']
        else
            Selas = nil
        end
        if NEW['Estribos'] then
            Estribos = NEW['Estribos']
        else
            Estribos = nil
        end
        if NEW['Saco_Dormir'] then
            Saco_Dormir = NEW['Saco_Dormir']
        else
            Saco_Dormir = nil
        end
        if NEW['Lanterna'] then
            Lanterna = NEW['Lanterna']
        else
            Lanterna = nil
        end
        if NEW['Mascara'] then
            Mascara = NEW['Mascara']
        else
            Mascara = nil
        end
        Upgrades = NEW
        --(json.encode(NEW))
        return true
    end
end
-- Preview
local type
local typev
local blip = {}
local blip_2 = {}
local blip_3 = {}
Citizen.CreateThread(function()
    local Config = x_cavalosSV.SendCFG()
    for k,v in pairs(Config.Estabulos) do
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip[k], -73168905, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Estábulo')
    --     blip_2[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.Guardar_Cavalo[1], v.Guardar_Cavalo[2], v.Guardar_Cavalo[3])
    --     SetBlipSprite(blip_2[k], -73168905, 1)
    --     Citizen.InvokeNative(0x9CB1A1623062F402, blip_2[k], 'Estábulo - Guardar Veículos e Cavalos')
    -- end
    -- for k, v in pairs(Config.HorsePositions) do
    --     blip_3[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.Blip[1], v.Blip[2], v.Blip[3])
    --     SetBlipSprite(blip_3[k], -73168905, 1)
    --     Citizen.InvokeNative(0x9CB1A1623062F402, blip_3[k], 'Estábulo - Garagem')
    -- end
    end
end)
local CreateMarkers = function()
    local Config = x_cavalosSV.SendCFG()
    while true do
        local W = 500
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        for _, v in pairs(Config.Estabulos) do
            if GetDistanceBetweenCoords(x, y, z, v.x, v.y, v.z, true) <= 5 then
                W = 1
               
                if GetDistanceBetweenCoords(x, y, z, v.x, v.y, v.z, true) <= 1.5 then
                    W = 1
                    DrawText3D( v.x, v.y, v.z-1, "Pressione ~e~[ESPAÇO]~p~ para comprar novos cavalos e modificações!")
                    if not onetimeclose then
                        
                    end
                    if IsControlJustPressed(0, 0x39336A4F) then
                        OpenStableGUI()
                        onetimeclose = true
                        nearStable = _
                    end
                else
                    if onetimeclose then
                        WarMenu.CloseMenu()
                        onetimeclose = false
                    end
                end
            end
        end
        Sleep(W)
    end
end
local CreateMarkers2 = function()
    local Config = x_cavalosSV.SendCFG()
    while true do
        local W = 500
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        for _, v in pairs(Config.HorsePositions) do
            if GetDistanceBetweenCoords(x, y, z, v.Blip[1] - 0., v.Blip[2], v.Blip[3], true) <= 5 then
                W = 1
                
                if GetDistanceBetweenCoords(x, y, z, v.Blip[1], v.Blip[2], v.Blip[3], true) <= 7.5 then
                    W = 1
                    selectedHorsePositionIndex = _
                    if not onetimeclose2 then
                        DrawText3D( v.Blip[1], v.Blip[2], v.Blip[3]-1, "Pressione ~e~[ESPAÇO]~p~ para abrir a lista dos seus cavalos")
                        nearStable = _
                    end
                    if GetDistanceBetweenCoords(x, y, z, v.Blip[1], v.Blip[2], v.Blip[3], true) <= 7.5 then
                        if IsControlJustPressed(0, 0x39336A4F) then
                            if (spawnedHorse == nil or spawnedHorse == '') then
                                info = x_cavalosSV.info()
                                info2 = x_cavalosSV.info2()
                                Wait(50)
                                WarMenu.OpenMenu('acoes')
                            else
                                TriggerEvent(
                                    'xFramework:Notify',
                                    'negado',
                                    'Esse menu só pode ser aberto quando não há cavalos do lado de fora do estábulo!'
                                )
                            end
                        end
                    end
                else
                    if onetimeclose2 then
                        WarMenu.CloseMenu()
                        onetimeclose2 = false
                    end
                end
            end
        end
        Sleep(W)
    end
end

local CreateMarkers3 = function()
    local Config = x_cavalosSV.SendCFG()
    while true do
        local W = 500
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        for _, v in pairs(Config.Estabulos) do
            if
                GetDistanceBetweenCoords(
                    x,
                    y,
                    z,
                    v.Guardar_Cavalo[1] - 0.,
                    v.Guardar_Cavalo[2],
                    v.Guardar_Cavalo[3],
                    true
                ) <= 5
             then
                W = 1
                if (spawnedHorse) then
                    
                end
                if
                    GetDistanceBetweenCoords(
                        x,
                        y,
                        z,
                        v.Guardar_Cavalo[1],
                        v.Guardar_Cavalo[2],
                        v.Guardar_Cavalo[3],
                        true
                    ) <= 5
                 then
                    W = 1
                    if (spawnedHorse) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true) < 3 then 
                            DrawText3D(v.Guardar_Cavalo[1],v.Guardar_Cavalo[2],v.Guardar_Cavalo[3], "Pressione ~e~[R]~p~ para guardar esse cavalo/veiculo no estabulo") 
                        else 
                            DrawText3D(v.Guardar_Cavalo[1],v.Guardar_Cavalo[2],v.Guardar_Cavalo[3], "Para guardar, esteja com seu cavalo ou carroça por perto...") 
                        end 
                    end
                    if IsControlJustPressed(0, 0xE30CD707) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true) < 3 then
                        if (spawnedHorse) then
                            DeleteEntity(spawnedHorse)
                            x_cavalosSV.SyncDeleteHorse(spawnedHorse)
                            spawnedHorse = nil
                            tag = nil
                            Cache['PlayerspawnedHorses'] = {}
                            Cache['ActualSelectedHorseName'] = {}
                            Cache['actualspawnedcart'] = {}
                            Cache['actualspawnedcartname'] = {}
                            Cache['actualcartped'] = ''
                            Cache['ActualHorsePed'] = ''
                            -- TriggerEvent("xFramework:Notify", 'sucesso', '[' ..(math.floor(aT/60))..'s]: Seu cavalo foi até o estabulo. Você pode chamá-lo novamente a qualquer momento com /cavalos!')
                            aT = 0
                            Cache['px'] = 0
                        end
                    end
                else
                    if onetimeclose2 then
                        WarMenu.CloseMenu()
                        onetimeclose2 = false
                    end
                end
            end
        end
        Sleep(W)
    end
end

local CreateMarkers5 = function()
    local Config = x_cavalosSV.SendCFG()
    while true do
        local W = 500
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        for _, v in pairs(Config.CarrocaPositions) do
            if GetDistanceBetweenCoords(x, y, z, v.Blip[1] - 0., v.Blip[2], v.Blip[3], true) <= 5 then
                W = 1
                
                if GetDistanceBetweenCoords(x, y, z, v.Blip[1], v.Blip[2], v.Blip[3], true) <= 7.5 then
                    W = 1
                    selectedCarrocaPositionIndex = _
                    DrawText3D( v.Blip[1], v.Blip[2], v.Blip[3]-1, "Pressione ~e~[ESPAÇO]~p~ para abrir a lista dos seus veiculos")
                    if not onetimeclose2 then
                       
                        nearStable = _
                    end
                    if GetDistanceBetweenCoords(x, y, z, v.Blip[1], v.Blip[2], v.Blip[3], true) <= 1.5 then
                        if IsControlJustPressed(0, 0x39336A4F) then
                            if (spawnedHorse == nil or spawnedHorse == '') then
                                info = x_cavalosSV.info()
                                info2 = x_cavalosSV.info2()
                                Wait(50)
                                WarMenu.OpenMenu('acoesveh1')
                            else
                                TriggerEvent(
                                    'xFramework:Notify',
                                    'negado',
                                    'Esse menu só pode ser aberto quando não há cavalos do lado de fora do estábulo!'
                                )
                            end
                        end
                    end
                else
                    if onetimeclose2 then
                        WarMenu.CloseMenu()
                        onetimeclose2 = false
                    end
                end
            end
        end
        Sleep(W)
    end
end

Core.CreateThread(CreateMarkers)
Core.CreateThread(CreateMarkers2)
Core.CreateThread(CreateMarkers3)
Core.CreateThread(CreateMarkers5)



-- Menu
local tunningHorse
local carrocaSpawn

RegisterNetEvent('x_cavalos:UpdatePlayerHorseTable')
AddEventHandler(
    'x_cavalos:UpdatePlayerHorseTable',
    function()
        info = x_cavalosSV.info()
        info2 = x_cavalosSV.info2()
    end
)
function OpenStableGUI()
    WarMenu.OpenMenu('principal')
end

RegisterNetEvent('DeleteHorse')
AddEventHandler(
    'DeleteHorse',
    function()
        x_cavalosSV.SyncDeleteHorse(spawnedHorse)
    end
)
Cache['SelectedHorseAprimoramento'] = {}
Cache['PlayerspawnedHorses'] = {}
Cache['ActualSelectedHorseName'] = 'Ações'
local Tunning = {}
Tunning.Categorias = {}
Tunning.Categorias.Cavalos = {}
Tunning.Categorias.Cavalos = {
    [1] = {
        10,
        'Mantas',
        opcoes = {
            tipo = 'Mantas',
            categorias = {
                [1] = {
                    Variacoes = {'0x127E0412', '0x20D4A0BF', '0x2A6D33E8', '0xDC87A9F', '0xFFB1DE72'},
                    anterior = 'Mantas',
                    label = 'Ribeira Silwaters',
                    preco = 50
                },
                [2] = {
                    Variacoes = {'0x19C5E80C', '0x3278996D', '0x3D34F3', '0x64BE7DF8', '0xEC040C89'},
                    anterior = 'Mantas',
                    label = 'Roanoke Ridge',
                    preco = 50
                },
                [3] = {
                    Variacoes = {'0x269583CA', '0x3973A986', '0x4A294AF1', '0x97EBE669', '0xED0190A3'},
                    anterior = 'Mantas',
                    label = 'Río Bravo',
                    preco = 50
                },
                [4] = {
                    Variacoes = {'0x342916F3', '0x6B2084E5', '0x78FB209A', '0x8FAD4DFE', '0x9DE0EA65'},
                    anterior = 'Mantas',
                    label = 'Cholla Springs',
                    preco = 50
                },
                [5] = {
                    Variacoes = {'0x3BA0D76D', '0x4BF1F80F', '0x5F0F9E4A', '0x71DFC3EA', '0xF506CA32'},
                    anterior = 'Mantas',
                    label = 'Nekoti Rock',
                    preco = 50
                },
                [6] = {
                    Variacoes = {'0x4655E362', '0xAD283105', '0xC2EF5C93', '0xC8A467FD', '0xDBEF0E96'},
                    anterior = 'Mantas',
                    label = 'Manzanita',
                    preco = 50
                },
                [7] = {
                    Variacoes = {'0x508B80B9', '0x67CAAF37', '0xEBB4B70D'},
                    anterior = 'Mantas',
                    label = 'Manantial de la Cotorra',
                    preco = 50
                },
                [8] = {
                    Variacoes = {'0x533A022A', '0x823A602A', '0xB0F7BDA4', '0xBBF05395', '0xFDC3D6D3'},
                    anterior = 'Mantas',
                    label = 'Bayou',
                    preco = 50
                },
                [9] = {
                    Variacoes = {
                        '0x53B325B7',
                        '0x7D637917',
                        '0x90A31F96',
                        '0x9AD633FC',
                        '0xB19B4519',
                        '0xC073E2CA',
                        '0xC7688D20'
                    },
                    anterior = 'Mantas',
                    label = 'Owanjila',
                    preco = 50
                },
                [10] = {
                    Variacoes = {'0x5894FB24', '0x9E468686', '0xAB302059', '0xD9E17DBB', '0xE32A1050'},
                    anterior = 'Mantas',
                    label = 'Millesani',
                    preco = 50
                },
                [11] = {
                    Variacoes = {'0x7951D487', '0xA3D5298D', '0xEDCB3D78'},
                    anterior = 'Mantas',
                    label = 'Risco del Diabo',
                    preco = 50
                },
                [12] = {
                    Variacoes = {'0xC097E12C', '0xCDD2FB96', '0xD333865B', '0xE409A807', '0xF6484C84'},
                    anterior = 'Mantas',
                    label = 'Iron Cloud',
                    preco = 50
                }
            }
        }
    },
    [2] = {
        10,
        'Cornetas',
        opcoes = {
            tipo = 'Cornetas',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x107D9598',
                        '0x2A28C8BE',
                        '0x333CDC06',
                        '0x34135CC3',
                        '0x3E40711D',
                        '0xDBE6AC3B',
                        '0xE1B1B8F1',
                        '0xE1DC3856',
                        '0xED0BCEB5',
                        '0xF09C56EE',
                        '0xF826E4EB',
                        '0xF8CAE723',
                        '0x9AD2AA40',
                        '0xC6C381F5'
                    },
                    anterior = 'Cornetas',
                    label = 'todas',
                    preco = 50
                }
            }
        }
    },
    [3] = {
        10,
        'Alforjes',
        opcoes = {
            tipo = 'Alforjes',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x1D4EDB88',
                        '0x20AA8620',
                        '0x293E17B3',
                        '0x2AEFF6CA',
                        '0x5277E9BA',
                        '0x577EF434',
                        '0x8BE10F93',
                        '0x9D593283',
                        '0xAE110017',
                        '0xB4F40DD9',
                        '0xC019F804',
                        '0xC05AA4AA',
                        '0xD048C482',
                        '0xE2ADE94C',
                        '0xE4108D59',
                        '0xE57042B4',
                        '0xE893DFD',
                        '0xEEC77E72',
                        '0xF0C30271',
                        '0xF8FB69CA'
                    },
                    anterior = 'Alforjes',
                    label = 'Desgastadas',
                    preco = 50
                }
            }
        }
    },
    [4] = {
        10,
        'Caudas',
        opcoes = {
            tipo = 'Caudas',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x12DBBBAF',
                        '0x3B8A8D0C',
                        '0x4951F22',
                        '0x49CD2991',
                        '0x607956E9',
                        '0x6DB6F164',
                        '0x7522834F',
                        '0x84269E43',
                        '0x876B27E0',
                        '0x88A2AA53',
                        '0x96EDC3D1',
                        '0x972AC447',
                        '0xA8A4673A',
                        '0xBCD412B1',
                        '0xCE62B5CE',
                        '0xDD9F5447',
                        '0xEFA67855'
                    },
                    anterior = 'Caudas',
                    label = 'Com dreadlock',
                    preco = 50
                },
                [2] = {
                    Variacoes = {
                        '0x17EB79D3',
                        '0x1A3B721B',
                        '0x25B51566',
                        '0x33E7B1CB',
                        '0x4124CC49',
                        '0x4F5268A4',
                        '0xA3DA055A',
                        '0xA62C9657',
                        '0xA7438C29',
                        '0xB4AB3354',
                        '0xC2FA4FF2',
                        '0xC74FCC45',
                        '0xD143E02D',
                        '0xEBC7218B',
                        '0xED0397AC',
                        '0xF6B0AB06'
                    },
                    anterior = 'Caudas',
                    label = 'Trançadas',
                    preco = 50
                },
                [3] = {
                    Variacoes = {
                        '0x1BB5EAA1',
                        '0x1E9A18C2',
                        '0x2E753874',
                        '0x3B27D1DD',
                        '0x3D212D77',
                        '0x5062FC53',
                        '0x508AD44A',
                        '0x543203ED',
                        '0x5F4871C5',
                        '0x695B2E3F',
                        '0x75C4C716',
                        '0x82DB38EE',
                        '0x84ADE4E4',
                        '0xAFB492C',
                        '0xC0AF3489',
                        '0xDCE41557',
                        '0xDDB48566',
                        '0xEAEAB164'
                    },
                    anterior = 'Caudas',
                    label = 'Baixas',
                    preco = 50
                },
                [4] = {
                    Variacoes = {
                        '0x383E86F3',
                        '0x3D1F13D4',
                        '0x4B51B039',
                        '0x574BC82D',
                        '0x66C266F',
                        '0x69756C80',
                        '0x740701A3',
                        '0x7A248ABE',
                        '0x84D6B90',
                        '0x894C290D',
                        '0x9CB1CFD8',
                        '0xA0775A83',
                        '0xA4F0E056',
                        '0xB244FE1E',
                        '0xCDFF359A',
                        '0xE38F5D96',
                        '0xEAA5EEE7',
                        '0xED787168'
                    },
                    anterior = 'Caudas',
                    label = 'Medias',
                    preco = 50
                },
                [5] = {
                    Variacoes = {
                        '0x1F7A99EA',
                        '0x30603BB5',
                        '0x3AE050B5',
                        '0x5D7FA043',
                        '0x607E6DD',
                        '0x73073A2',
                        '0x810A5CE0',
                        '0xB4374DB1',
                        '0xC304EB4C',
                        '0xD7D68A7B',
                        '0xD9288D47',
                        '0xD9EA1916',
                        '0xEABBBAB9',
                        '0xF4294320',
                        '0xF4A3443C',
                        '0xF867D611'
                    },
                    anterior = 'Caudas',
                    label = 'Longas',
                    preco = 50
                }
            }
        }
    },
    [5] = {
        10,
        'Selas',
        opcoes = {
            tipo = 'Selas',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x353FC03C',
                        '0x106961A8',
                        '0x150D0DAA',
                        '0x17153A45',
                        '0x1C14443F',
                        '0x1F7C4C5',
                        '0x2E4668A3',
                        '0x2ECD9E70',
                        '0x3D0C3AED',
                        '0x3F9F62CE',
                        '0x4B372288',
                        '0x5D717C9',
                        '0x78F07DFA',
                        '0xC04FE429',
                        '0xD97573C1',
                        '0xDE47F51',
                        '0xEB1139AB',
                        '0xF3BEA853',
                        '0xF94D5623'
                    },
                    anterior = 'Selas',
                    label = 'McClelland Lumley',
                    preco = 50
                },
                [2] = {
                    Variacoes = {
                        '0xDE5A2905',
                        '0x14168240',
                        '0x2844E292',
                        '0x3E949A74',
                        '0x5B6390D9',
                        '0x5BBC54C3',
                        '0x6D403492',
                        '0x70BB7EC1',
                        '0x7FD859C2',
                        '0x87F421F7',
                        '0x8D163776',
                        '0x8D9D754C',
                        '0x9CD94BC1',
                        '0xBA6A921E',
                        '0xBB335077',
                        '0xC1AF1568',
                        '0xCE8C2F22',
                        '0xD11CBF82',
                        '0xF36A78DE'
                    },
                    anterior = 'Selas',
                    label = 'Mother Hubbard Kneller',
                    preco = 50
                },
                [3] = {
                    Variacoes = {
                        '0x15FB6791',
                        '0x3827D232',
                        '0x40C53D24',
                        '0x47D2CB3F',
                        '0x9533FA8E',
                        '0xA7AC9F7B',
                        '0xB7B33F88',
                        '0xB9BE555D',
                        '0xC7FC601A',
                        '0xDA36048D',
                        '0xE039FC0F',
                        '0xE36C8274',
                        '0xE52BAC3F',
                        '0xEC882931',
                        '0xF2F0045',
                        '0xF4B14B4A',
                        '0xF687A8AA'
                    },
                    anterior = 'Selas',
                    label = 'Dakota Kneller',
                    preco = 50
                },
                [4] = {
                    Variacoes = {
                        '0x7D795D72',
                        '0x189F7005',
                        '0x1D0BF8F2',
                        '0x1EC65C0',
                        '0x219D85E2',
                        '0x4C1A5ADB',
                        '0x522CCED',
                        '0x5546EB7A',
                        '0x5B45F932',
                        '0x7092A211',
                        '0x7DBB3E1C',
                        '0x8E64DDB5',
                        '0x8FFCF06B',
                        '0xA39D34E',
                        '0xAD4A6355',
                        '0xBE703DF7',
                        '0xBFD09512',
                        '0xC0C04297',
                        '0xD2FA64BC',
                        '0xE5510BB8',
                        '0xE6488B58',
                        '0xF1BAA60D',
                        '0xF7682D97'
                    },
                    anterior = 'Selas',
                    label = 'Gerden cowboy',
                    preco = 50
                },
                [5] = {
                    Variacoes = {
                        '0xD225CCA0',
                        '0x1EE21489',
                        '0x20359E53',
                        '0x24F24446',
                        '0x2E3F3A62',
                        '0x306806F',
                        '0x335DC49F',
                        '0x534A7D59',
                        '0x660B29F9',
                        '0x6C622F8C',
                        '0x70C65BED',
                        '0x8E22730C',
                        '0x93B7057',
                        '0xC454830C',
                        '0xD6BF27E1',
                        '0xD7FC86BF',
                        '0xE9B7AA35',
                        '0xF4118E4',
                        '0xFCE1D7A4'
                    },
                    anterior = 'Selas',
                    label = 'Trail Gerden',
                    preco = 50
                },
                [6] = {
                    Variacoes = {
                        '0x21E8DDFA',
                        '0x2E216DBC',
                        '0x2F8C7941',
                        '0x5A9E4F6C',
                        '0x60DE5335',
                        '0x6384D886',
                        '0x64CEC6DF',
                        '0x694DE418',
                        '0x76887E89',
                        '0x8DABACD7',
                        '0x90489DD2',
                        '0x9E0C3959',
                        '0xB61F0668',
                        '0xBC52F5E6',
                        '0xC7D58D0B',
                        '0xD61B2996',
                        '0xDA84CF33',
                        '0xFD4E14C5'
                    },
                    anterior = 'Selas',
                    label = 'Roping Stenge',
                    preco = 50
                },
                [7] = {
                    Variacoes = {
                        '0xB5802A5F',
                        '0x6FEABF89',
                        '0x7A23C686',
                        '0x7C19770A',
                        '0x7C2C580C',
                        '0x88C363C5',
                        '0x8DD09A7C',
                        '0x93DA8768',
                        '0x9B1C95F8',
                        '0x9FF23EBF',
                        '0xA1154105',
                        '0xA21923E5',
                        '0xA8DB3175',
                        '0xB357E58A',
                        '0xC10B5450',
                        '0xD2C8F7CB',
                        '0xE5B31D9F',
                        '0xF373B920',
                        '0xFC6AF7AF'
                    },
                    anterior = 'Selas',
                    label = 'Lumley rancher',
                    preco = 50
                },
                [8] = {
                    Variacoes = {
                        '0xC76C46D9',
                        '0x6FEABF89',
                        '0x7A23C686',
                        '0x7C19770A',
                        '0x7C2C580C',
                        '0x88C363C5',
                        '0x8DD09A7C',
                        '0x93DA8768',
                        '0x9B1C95F8',
                        '0x9FF23EBF',
                        '0xA1154105',
                        '0xA21923E5',
                        '0xA8DB3175',
                        '0xB357E58A',
                        '0xC10B5450',
                        '0xD2C8F7CB',
                        '0xE5B31D9F',
                        '0xF373B920',
                        '0xFC6AF7AF'
                    },
                    anterior = 'Selas',
                    label = 'Ropping Beaver',
                    preco = 50
                }
            }
        }
    },
    [6] = {
        10,
        'Estribos',
        opcoes = {
            tipo = 'Estribos',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x3B3AB08',
                        '0x587DD49F',
                        '0x67AF7302',
                        '0x75178DD2',
                        '0x8246282F',
                        '0x8D0BC7DA',
                        '0x9EE8E174',
                        '0xBDF19F85',
                        '0xCB9A3AD6',
                        '0xD8AE54FE',
                        '0xE73FF221'
                    },
                    anterior = 'Estribos',
                    label = 'Todas',
                    preco = 50
                }
            }
        }
    },
    [7] = {
        10,
        'Saco de dormir',
        opcoes = {
            tipo = 'Saco_Dormir',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x12F0DF9F',
                        '0x18BB6B30',
                        '0x1B43F045',
                        '0x55A0E4FE',
                        '0x69B21ADD',
                        '0x7B55D476',
                        '0x8C9F7709',
                        '0x9FD99D7D',
                        '0xAC1F34C',
                        '0xD8258E14',
                        '0xFFB0391E'
                    },
                    anterior = 'Saco de dormir',
                    label = 'De Lã(comum)',
                    preco = 50
                },
                [2] = {
                    Variacoes = {
                        '0x45FEA6D8',
                        '0x69B29DC5',
                        '0x72FCB059',
                        '0x7C8A149A',
                        '0x84E5AFA',
                        '0x8DD7B735',
                        '0x98214B1C',
                        '0x9D868568',
                        '0xA643680C',
                        '0xD258EF10'
                    },
                    anterior = 'Saco de dormir',
                    label = 'De Lã(Acolchoada)',
                    preco = 50
                },
                [3] = {
                    Variacoes = {
                        '0x27543EBB',
                        '0x36BEDD90',
                        '0x4B7E0712',
                        '0x73D157B4',
                        '0x841C784A',
                        '0xA1FD8B43',
                        '0xB4532FEE',
                        '0xBC664014',
                        '0xD020E789'
                    },
                    anterior = 'Saco de dormir',
                    label = 'outros',
                    preco = 50
                }
            }
        }
    },
    [8] = {
        10,
        'Lanterna',
        opcoes = {
            tipo = 'Lanterna',
            categorias = {
                [1] = {
                    Variacoes = {'0x635E387C'},
                    anterior = 'Lanterna',
                    label = 'Comum',
                    preco = 50
                }
            }
        }
    },
    [9] = {
        10,
        'Mascara',
        opcoes = {
            tipo = 'Mascara',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0xFA5B72BB',
                        '0xF606EC4A',
                        '0xEEF65F11',
                        '0xEC10D626',
                        '0xE3278C28',
                        '0xDDCDB9A0',
                        '0xD70C73EA',
                        '0xC907FCA9',
                        '0xC70D8F40',
                        '0xBD887906',
                        '0xB567EBF5',
                        '0xB395D1C5',
                        '0xB0395F88',
                        '0xA45049C6',
                        '0x9DB125FC',
                        '0x9A11B219',
                        '0x9946F874',
                        '0x90A62272',
                        '0x8DCC1CBE',
                        '0x8DB38601',
                        '0x8C471684',
                        '0x872A0C5A',
                        '0x7BFA791B',
                        '0x7A773AC1',
                        '0x702A4AF3',
                        '0x6B355791',
                        '0x69CD996E',
                        '0x68FB97DE',
                        '0x68DB4FAD',
                        '0x62C5B02A',
                        '0x61BEAE08',
                        '0x4E22622C',
                        '0x4C8C83A4',
                        '0x406FC6C7',
                        '0x30044BAC',
                        '0x226B2F76',
                        '0x13AC6E51',
                        '0x08A78F53',
                        '0xF0ED62FF',
                        '0xF17728C7'
                    },
                    anterior = 'Mascara',
                    label = 'Comuns',
                    preco = 50
                }
            }
        }
    },
    [10] = {
        10,
        'Cabelos',
        opcoes = {
            tipo = 'Cabelos',
            categorias = {
                [1] = {
                    Variacoes = {
                        '0x1FDC6D0F',
                        '0x241D7FBD',
                        '0x3A7C2C86',
                        '0x483AC803',
                        '0x512377B',
                        '0x6038F7FF',
                        '0x6D9412B5',
                        '0x83563E39',
                        '0x96FE6589',
                        '0x9A640A3',
                        '0xB2FB934B',
                        '0xC929BFA7',
                        '0xCDC9C8E7',
                        '0xDCF5321',
                        '0xE02377D6',
                        '0xFF17AB82',
                        '0xFFF3B76A'
                    },
                    anterior = 'Cabelos',
                    label = 'Com dreadlocks',
                    preco = 50
                },
                [2] = {
                    Variacoes = {
                        '0x25627B98',
                        '0x2E378E8A',
                        '0x3BFE2A17',
                        '0x4FCC51B3',
                        '0x54A3CB0',
                        '0x5D596CCD',
                        '0x6F4510C4',
                        '0x7D902D5A',
                        '0x92B2579E',
                        '0x97105EF6',
                        '0xA0F4F423',
                        '0xA64BFD6D',
                        '0xB13D134B',
                        '0xCF434F57',
                        '0xD4E65BE5',
                        '0xDC62E996',
                        '0xE9FE04D0'
                    },
                    anterior = 'Cabelos',
                    label = 'Trançada',
                    preco = 50
                },
                [3] = {
                    Variacoes = {
                        '0x18199F48',
                        '0x354F6B7',
                        '0x3F1FEE4C',
                        '0x4F148D45',
                        '0x52DC15C8',
                        '0x5DE62AE8',
                        '0x648A3924',
                        '0x7098D141',
                        '0x86457C9A',
                        '0x960C1B33',
                        '0x99F5A3FA',
                        '0xA4E1B8DE',
                        '0xABA8475F',
                        '0xB288D42C',
                        '0xBD7B6B05',
                        '0xC15371C1',
                        '0xF2E555D8'
                    },
                    anterior = 'Cabelos',
                    label = 'Baixo',
                    preco = 50
                },
                [4] = {
                    Variacoes = {
                        '0x130E341A',
                        '0x16923E26',
                        '0x1A5A45B6',
                        '0x2FCAF0CB',
                        '0x419D9470',
                        '0x41EA9196',
                        '0x5445B9C0',
                        '0x5ED14B9F',
                        '0x66215D77',
                        '0x817B10F6',
                        '0xA7A4DD49',
                        '0xB5F379E6',
                        '0xD894BF28',
                        '0xE1435081',
                        '0xEA46E28C',
                        '0xFF020F3A'
                    },
                    anterior = 'Cabelos',
                    label = 'Medio',
                    preco = 50
                },
                [5] = {
                    Variacoes = {
                        '0x235DBF1',
                        '0x446A6F01',
                        '0x5F0395A3',
                        '0x5FE29755',
                        '0x632F2B7',
                        '0x6CB9310E',
                        '0x838E5EB8',
                        '0x94F58186',
                        '0x97D095F4',
                        '0xA193A97A',
                        '0xAA3FAC1A',
                        '0xAFB7C24',
                        '0xB881489D',
                        '0xC8646863',
                        '0xC9D16B31',
                        '0xE0BC27A6',
                        '0xFC74DF3B'
                    },
                    anterior = 'Cabelos',
                    label = 'Longo',
                    preco = 50
                }
            }
        }
    }
}
Tunning.Atual = {}
Tunning.Atual.Cavalos = {}
local confirmacao = 0
function preview(HorsePed)
    if (not Caudas) then
        n(0xD710A5007C2AC539, HorsePed, 0xA63CAE10, 0)
        n(0xCC8CA3E88256E58F, HorsePed, 0, 1, 1, 1, 0)
    end
    if (not Cabelos) then
        n(0xD710A5007C2AC539, HorsePed, 0xAA0217AB, 0)
        n(0xCC8CA3E88256E58F, HorsePed, 0, 1, 1, 1, 0)
    end
    if (type == 'Mantas') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Cornetas') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Alforjes') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Caudas') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end

    if (type == 'Cabelos') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Selas') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Estribos') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Saco_Dormir') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Lanterna') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
    if (type == 'Mascara') then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(typev), true, true, true)
    end
end
function ReloadHorseAtributes(HorsePed)
    if (not Caudas) then
        n(0xD710A5007C2AC539, HorsePed, 0xA63CAE10, 0)
    end
    if (not Cabelos) then
        n(0xD710A5007C2AC539, HorsePed, 0xAA0217AB, 0)
    end
    if (Mantas ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Mantas), true, true, true)
    end
    if (Cornetas ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Cornetas), true, true, true)
    end
    if (Alforjes ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Alforjes), true, true, true)
    end

    if (Caudas ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Caudas), true, true, true)
    end

    if (Cabelos ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Cabelos), true, true, true)
    end
    if (Selas ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Selas), true, true, true)
    end
    if (Estribos ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Estribos), true, true, true)
    end
    if (Saco_Dormir ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Saco_Dormir), true, true, true)
    end
    if (Lanterna ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Lanterna), true, true, true)
    end
    if (Mascara ~= 0) then
        n(0xD3A7B003ED343FD9, HorsePed, tonumber(Mascara), true, true, true)
    end
end
local delay = false
Core.CreateThread(
    function()
        Config = x_cavalosSV.SendCFG()
        WarMenu.CreateMenu('acoes', 'Seus Cavalos')
        WarMenu.SetSubTitle('acoes', 'Seus Cavalos')
        WarMenu.CreateMenu('acoesveh1', 'Seus Veículos')
        WarMenu.SetSubTitle('acoesveh1', 'Seus Veículos ')
        WarMenu.CreateSubMenu('acoesveh2', 'acoesveh1', 'Ações')
        WarMenu.CreateSubMenu('acoesveh3', 'acoesveh1', 'Ações')
        WarMenu.CreateSubMenu('acoes2', 'acoes', Cache['ActualSelectedHorseName'])
        WarMenu.CreateSubMenu('acoes3', 'acoes', Cache['ActualSelectedHorseName'])
        WarMenu.CreateMenu('principal', 'Estábulo')
        WarMenu.SetSubTitle('principal', 'Selecione uma opção')
        WarMenu.CreateSubMenu('cavalos_compra', 'principal', 'Todos os Cavalos')
        WarMenu.CreateSubMenu('carrocas_compra', 'principal', 'Todas as Carroças')
        WarMenu.CreateSubMenu('aprimoramento_central', 'principal', 'Selecione')
        WarMenu.CreateSubMenu('aprimoramentos_cavalos', 'aprimoramento_central', 'Selecione uma categoria!', '')
        WarMenu.CreateSubMenu('aprimoramento_cavalos0', 'aprimoramento_central', 'Selecione um deles...')
        for k, v in pairs(Tunning.Categorias.Cavalos) do
            WarMenu.CreateSubMenu(v[2], 'aprimoramentos_cavalos', 'selecione um tipo de manta', '')
            for k2, v2 in pairs(Tunning.Categorias.Cavalos[k].opcoes.categorias) do
                WarMenu.CreateSubMenu(v2.label, v2.anterior, 'Selecione uma opção!', '', '')
            end
        end
        while true do
            local W = 500

            if WarMenu.IsMenuOpened('acoesveh1') then
                W = 1
                --  'acoesveh1_ 2'
                for k, v in pairs(info2) do
                    local nameadd = ''
                    if Cache['actualspawnedcart'][v.name] then
                        nameadd = '*'
                    else
                        nameadd = ''
                    end
                    if WarMenu.Button('' .. v.name .. ' ' .. nameadd, '', '') then
                        if not Cache['actualspawnedcart'][v.name] then
                            CurrentCartAction = {Ped = k, Name = v.name, Dados = v}
                            WarMenu.OpenMenu('acoesveh2')
                        else
                            WarMenu.OpenMenu('acoesveh3')
                        end
                    end
                end
                WarMenu.Display()
            end
            for k, v in pairs(Tunning.Categorias.Cavalos) do
                for i_ = 1, #v.opcoes.categorias do
                    if WarMenu.IsMenuOpened(v.opcoes.categorias[i_].label) then
                        W = 1
                        for i = 1, #Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes do
                            if (Tunning.Categorias.Cavalos[k].opcoes.tipo) == 'Mantas' then
                                type = 'Mantas'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Cornetas') then
                                type = 'Cornetas'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Alforjes') then
                                type = 'Alforjes'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Caudas') then
                                type = 'Caudas'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Cabelos') then
                                type = 'Cabelos'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Selas') then
                                type = 'Selas'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Estribos') then
                                type = 'Estribos'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Saco_Dormir') then
                                type = 'Saco_Dormir'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Lanterna') then
                                type = 'Lanterna'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Mascara') then
                                type = 'Mascara'
                                typev =
                                    Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                    tonumber(WarMenu.Selected())
                                ]
                            end
                            local add_title = ''
                            if (v.opcoes.categorias[i_].Variacoes[typev]) then
                                add_tile = '*'
                            end
                            --(v.opcoes.categorias[i_].preco)
                            if WarMenu.Button('Variação: ' .. i .. add_title, '$' .. v.opcoes.categorias[i_].preco, '') then
                                if (delay) then
                                    TriggerEvent(
                                        'xFramework:Notify',
                                        'negado',
                                        'Você está efetuando operações rápido demais, aguarde para tentar novamente!'
                                    )
                                end
                                if not delay then
                                    if (confirmacao <= 0) then
                                        Cache['SelectedPurchase'] =
                                            Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[
                                            tonumber(WarMenu.Selected())
                                        ]
                                        TriggerEvent(
                                            'xFramework:Notify',
                                            'aviso',
                                            'Toque novamente para comprar novamente para confirmar a compra!'
                                        )
                                        confirmacao = 1
                                    else
                                        if (not delay) then
                                            if (Tunning.Categorias.Cavalos[k].opcoes.tipo) == 'Mantas' then
                                                Mantas = typev
                                                Upgrades['Mantas'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Cornetas') then
                                                Cornetas = typev
                                                Upgrades['Cornetas'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Alforjes') then
                                                Alforjes = typev
                                                Upgrades['Alforjes'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Caudas') then
                                                Caudas = typev
                                                Upgrades['Caudas'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Cabelos') then
                                                Cabelos = typev
                                                Upgrades['Cabelos'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Selas') then
                                                Selas = typev
                                                Upgrades['Selas'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Estribos') then
                                                Estribos = typev
                                                Upgrades['Estribos'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Saco_Dormir') then
                                                Saco_Dormir = typev
                                                Upgrades['Saco_Dormir'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Lanterna') then
                                                Lanterna = typev
                                                Upgrades['Lanterna'] = typev
                                            elseif (Tunning.Categorias.Cavalos[k].opcoes.tipo == 'Mascara') then
                                                Mascara = typev
                                                Upgrades['Mascara'] = typev
                                            end
                                            delay = true
                                            TriggerEvent('xFramework:Notify', 'sucesso', 'Comprou esta modificação!')
                                            Cache['SelectedPurcahse'] = ''
                                            confirmacao = 0
                                            Cache['NumberMenuSelected'] = tonumber(1)
                                            typev = ''
                                            x_cavalosSV.SendNewUpgrades(Upgrades, Cache['ActualTunningHorseName'])
                                        end
                                    end
                                end
                            end
                        end

                        local selected_hsh =
                            Tunning.Categorias.Cavalos[k].opcoes.categorias[i_].Variacoes[tonumber(WarMenu.Selected())]
                        preview(tunningHorse)
                        Cache['CanPedBeReset'] = true
                        WarMenu.Display()
                    end
                end
            end
            if WarMenu.IsMenuOpened('Lanterna') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[8].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end

                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Cabelos') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[10].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end

                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Mascara') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[9].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Saco de dormir') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[7].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Mantas') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()
                for k2, v2 in pairs(Tunning.Categorias.Cavalos[1].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Estribos') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()
                for k2, v2 in pairs(Tunning.Categorias.Cavalos[6].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Cornetas') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()
                for k2, v2 in pairs(Tunning.Categorias.Cavalos[2].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Selas') then
                W = 1
                -- 'espera'
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[5].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end

                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('Alforjes') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[3].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end

                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened('Caudas') then
                W = 1
                if Cache['CanPedBeReset'] then
                    Cache['CanPedBeReset'] = false
                    DeletePed(tunningHorse)
                    tunningHorse =
                        CreatePed(
                        Cache['lastTunHorse'],
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    Cache['lastTunHorse'] = Cache['lastTunHorse']
                    n(0x283978A15512B2FE, tunningHorse, true, true, true)
                    SetEntityCanBeDamaged(tunningHorse, false)
                    SetEntityInvincible(tunningHorse, true)
                    FreezeEntityPosition(tunningHorse, true)
                    SetEntityHeading(tunningHorse, lastHeading2)
                    SetModelAsNoLongerNeeded(tunningHorse)
                    ReloadHorseAtributes(tunningHorse)
                end
                Cache['NumberMenuSelected'] = WarMenu.Selected()

                for k2, v2 in pairs(Tunning.Categorias.Cavalos[4].opcoes.categorias) do
                    if WarMenu.Button(v2.label, '', '') then
                        WarMenu.OpenMenu(v2.label) -- Abrir Menu da Categoria
                    end
                end

                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('aprimoramentos_cavalos') then
                W = 1
                for k, v in pairs(Tunning.Categorias.Cavalos) do
                    if WarMenu.Button(v[2], '', '') then
                        -- ("open  menu >> ", v[2])
                        WarMenu.OpenMenu(v[2])
                    end
                end
                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened('aprimoramento_central') then
                W = 1
                if WarMenu.Button('Aprimorar um Cavalo', '', '') then
                    WarMenu.OpenMenu('aprimoramento_cavalos0')
                -- (WarMenu.IsMenuOpened('aprimoramento_cavalos0'))
                end
                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened('aprimoramento_cavalos0') then
                W = 1
                for k, v in pairs(info) do
                    if WarMenu.Button('' .. v.name, '', '') then
                        Mantas = nil
                        Cornetas = nil
                        Alforjes = nil
                        Caudas = nil
                        Cabelos = nil
                        Selas = nil
                        Estribos = nil
                        Saco_Dormir = nil
                        Lanterna = nil
                        Mascara = nil
                        Upgrades = {}
                        x_cavalosSV.AtualizarVariaveis(v.name)
                        Cache['ActualTunningHorseName'] = v.name
                        Cache['SelectedHorseAprimoramento'] = {k = k, v = v}
                        WarMenu.OpenMenu('aprimoramentos_cavalos')
                        RequestModel(k)
                        while not HasModelLoaded(k) do
                            -- (k)
                            RequestModel(k)
                            Wait(0)
                        end
                        if tunningHorse then
                            DeletePed(tunningHorse)
                        end
                        tunningHorse =
                            CreatePed(
                            k,
                            Config.Estabulos[nearStable].preview[1],
                            Config.Estabulos[nearStable].preview[2],
                            Config.Estabulos[nearStable].preview[3],
                            heading,
                            false,
                            true,
                            true,
                            true
                        )
                        Cache['lastTunHorse'] = k
                        n(0x283978A15512B2FE, tunningHorse, true)
                        SetEntityCanBeDamaged(tunningHorse, false)
                        SetEntityInvincible(tunningHorse, true)
                        FreezeEntityPosition(tunningHorse, true)
                        SetEntityHeading(tunningHorse, lastHeading2)
                        SetModelAsNoLongerNeeded(tunningHorse)
                        ReloadHorseAtributes(tunningHorse)
                        opened.cavalos = true
                        DestroyAllCams(true)
                        CamHorse =
                            CreateCamWithParams(
                            'DEFAULT_SCRIPTED_CAMERA',
                            Config.Estabulos[nearStable].cameras['camHorse'][1],
                            Config.Estabulos[nearStable].cameras['camHorse'][2],
                            Config.Estabulos[nearStable].cameras['camHorse'][3],
                            Config.Estabulos[nearStable].cameras['camHorse'][4],
                            Config.Estabulos[nearStable].cameras['camHorse'][5],
                            Config.Estabulos[nearStable].cameras['camHorse'][6],
                            50.00,
                            false,
                            0
                        )
                        SetCamActive(CamHorse, true)
                        RenderScriptCams(true, true, 1000, true, true, 0)
                    end
                end
                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened('acoes3') then
                W = 1
                if WarMenu.Button('Chamar para perto', '', 'Chamar o cavalo para próximo') then
                    TriggerEvent('xFramework:Notify', 'sucesso', 'Seu cavalo está indo para mais perto de você <3!')
                    n(0x6A071245EB0D1882, spawnedHorse, (PlayerPedId()), -1, 15.2, 2.0, 0, 0)
                end

                if WarMenu.Button('Mandar ir', '', 'Clique para ações!') then
                    local cx, cy, cz = table.unpack(GetEntityCoords(spawnedHorse))
                    Cache['px'], _, _ = table.unpack(GetEntityCoords(PlayerPedId()))
                    n(0x5BC448CB78FA3E88, spawnedHorse, cx + 130, cy, cz, 2.0, 0, false, 1, 0)
                    TriggerEvent('DeleteHorse', cx + 130, cy, cz)
                    WarMenu.CloseMenu()
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('acoes2') then
                W = 1
                if WarMenu.Button('Chamar', '', 'Clique para ações!') then
                    if (spawnedHorse == nil or spawnedHorse == '') then
                        Cache['PlayerspawnedHorses'][CurrentHorseAction.Name] = true
                        Cache['ActualSelectedHorseName'] = CurrentHorseAction.Name
                        x_cavalosSV.SpawnCavalo(CurrentHorseAction)
                        Cache['ActualTypeSpawn'] = 'cavalo'
                        WarMenu.CloseMenu()
                    else
                        TriggerEvent('xFramework:Notify', 'negado', 'Você só pode ter um cavalo fora do estabulo')
                        WarMenu.CloseMenu()
                    end
                end
                if WarMenu.Button('Renomear', '', 'Clique para ações!') then
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('acoesveh2') then
                W = 1
                if WarMenu.Button('Chamar', '', 'Clique para ações!') then
                    if (spawnedHorse == nil or spawnedHorse == '') then
                        Cache['actualspawnedcart'][CurrentCartAction.Name] = true
                        Cache['actualspawnedcartname'] = CurrentCartAction.Name
                        
                        x_cavalosSV.SpawnCarroca(CurrentCartAction)
                        Cache['ActualTypeSpawn'] = 'carroca'
                        WarMenu.CloseMenu()
                    else
                        TriggerEvent('xFramework:Notify', 'negado', 'Você só pode ter uma carroça fora do estabulo')
                        WarMenu.CloseMenu()
                    end
                end
                if WarMenu.Button('Renomear', '', 'Clique para ações!') then
                end
                WarMenu.Display()
            end
            -- acoesveh1
            if WarMenu.IsMenuOpened('acoes') then
                W = 1
                for k, v in pairs(info) do
                    local nameadd = ''
                    if Cache['PlayerspawnedHorses'][v.name] then
                        nameadd = '*'
                    else
                        nameadd = ''
                    end
                    if WarMenu.Button('' .. v.name .. ' ' .. nameadd, '', '') then
                        if not Cache['PlayerspawnedHorses'][v.name] then
                            WarMenu.OpenMenu('acoes2')
                            CurrentHorseAction = {Ped = k, Name = v.name, Dados = v}
                        else
                            WarMenu.OpenMenu('acoes3')
                        end
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('carrocas_compra') then
                W = 1
                DestroyAllCams(true)
                CamCarrocas =
                    CreateCamWithParams(
                    'DEFAULT_SCRIPTED_CAMERA',
                    Config.Estabulos[nearStable].cameras['camCart'][1],
                    Config.Estabulos[nearStable].cameras['camCart'][2],
                    Config.Estabulos[nearStable].cameras['camCart'][3],
                    Config.Estabulos[nearStable].cameras['camCart'][4],
                    Config.Estabulos[nearStable].cameras['camCart'][5],
                    Config.Estabulos[nearStable].cameras['camCart'][6],
                    50.00,
                    false,
                    0
                )
                SetCamActive(CamCarrocas, true)
                RenderScriptCams(true, true, 1000, true, true, 0)
                local Selected_Index = WarMenu.Selected()

                --  Spawnar Preview --
                local ActualSelectedIndex = WarMenu.Selected()
                local ActualSelectedTable = Config.carrocas[tonumber(ActualSelectedIndex)]

                local i = 1
                local hashveh = GetHashKey(ActualSelectedTable.name)
                --(hashveh)
                RequestModel(hashveh)
                while not HasModelLoaded(hashveh) do
                    RequestModel(hashveh)

                    i = i + 1
                    --(i)
                    if i > 400 then
                        error(
                            'Há algo de errado em Servidor.Framework.x_Cavalos.Lines(1171): OU: Configuração Servidor.Framework.Framework.Server.HorseConfig em ' ..
                                ActualSelectedTable.name .. ' :: NOME_INVALIDO'
                        )
                    end
                    Wait(0)
                end
                i = 1
                local x, y, z =
                    Config.Estabulos[nearStable].previewVehicle[1],
                    Config.Estabulos[nearStable].previewVehicle[2],
                    Config.Estabulos[nearStable].previewVehicle[3]
                --(x, y, z)
                if not Cache['lastSpawnVeh'][ActualSelectedTable.name] then
                    --("spawnando agora!")
                    DeleteVehicle(carrocaSpawn)
                    Cache['lastSpawnVeh'] = {[ActualSelectedTable.name] = true}
                    Cache['lastVehName'] = ActualSelectedTable.name
                    carrocaSpawn = CreateVehicle(ActualSelectedTable.name, x, y, z + 1, 0, false, true, true, true)
                    n(0xAF35D0D2583051B0, carrocaSpawn, true)
                    SetEntityCanBeDamaged(carrocaSpawn, false)
                    SetEntityInvincible(carrocaSpawn, true)
                    FreezeEntityPosition(carrocaSpawn, true)
                    SetModelAsNoLongerNeeded(carrocaSpawn)
         
                end
                for i = 1, #Config.carrocas do
                    if
                        WarMenu.Button(
                            Config.carrocas[tonumber(i)].label,
                            '$' .. Config.carrocas[tonumber(i)].preco,
                            Config.carrocas[tonumber(i)].descricao .. ''
                        )
                     then
                        if operationTimer <= 0 then
                            Core.CreateThread(
                                function()
                                    AddTextEntry('FMMC_MPM_TYP8', 'Escolha um nome para seu veiculo!')
                                    DisplayOnscreenKeyboard(1, 'FMMC_MPM_TYP8', '', '', '', '', '', 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Sleep(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        local inPut1 = GetOnscreenKeyboardResult()
                                        local index = tonumber(WarMenu.Selected())
                                        x_cavalosSV.Buy2(Config.carrocas[tonumber(i)].name, inPut1, index)
                                    end
                                end
                            )
                            operationTimer = 5
                        else
                            TriggerEvent(
                                'xFramework:Notify',
                                'negado',
                                'Você está efetuando operações na compra de carrocas rápido demais',
                                5000
                            )
                        end
                    end
                end
                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened('cavalos_compra') then
                W = 1

                -- -- (Config.Estabulos[nearStable].cameras['camHorse'][1] , Config.Estabulos[nearStable].cameras['camHorse'][2], Config.Estabulos[nearStable].cameras['camHorse'][3], Config.Estabulos[nearStable].cameras['camHorse'][4], Config.Estabulos[nearStable].cameras['camHorse'][5], Config.Estabulos[nearStable].cameras['camHorse'][6])
                opened.cavalos = true
                DestroyAllCams(true)
                CamHorse =
                    CreateCamWithParams(
                    'DEFAULT_SCRIPTED_CAMERA',
                    Config.Estabulos[nearStable].cameras['camHorse'][1],
                    Config.Estabulos[nearStable].cameras['camHorse'][2],
                    Config.Estabulos[nearStable].cameras['camHorse'][3],
                    Config.Estabulos[nearStable].cameras['camHorse'][4],
                    Config.Estabulos[nearStable].cameras['camHorse'][5],
                    Config.Estabulos[nearStable].cameras['camHorse'][6],
                    50.00,
                    false,
                    0
                )
                SetCamActive(CamHorse, true)
                RenderScriptCams(true, true, 1000, true, true, 0)
                local ActualSelectedIndex = WarMenu.Selected()
                local ActualSelectedTable = Config.cavalos[tonumber(ActualSelectedIndex)]
                if Cache['lastSpawnHorse'] and not Cache['lastSpawnHorse'][ActualSelectedTable.name] then
                    Cache['lastSpawnHorse'] = {[ActualSelectedTable.name] = false}
                end
                local i = 1
                RequestModel(ActualSelectedTable.name)
                while not HasModelLoaded(ActualSelectedTable.name) do
                    RequestModel(ActualSelectedTable.name)

                    i = i + 1
                    if i > 400 then
                        error(
                            'Há algo de errado em Servidor.Framework.x_Cavalos.Lines(126): OU: Configuração Servidor.Framework.Framework.Server.HorseConfig em ' ..
                                ActualSelectedTable.name .. ' :: NOME_INVALIDO'
                        )
                    end
                    Wait(0)
                end
                if not Cache['lastSpawnHorse'][ActualSelectedTable.name] then
                    if HorsePed then
                        DeletePed(HorsePed)
                    end
                    if tunningHorse then
                        DeletePed(tunningHorse)
                    end
                    Cache['lastSpawnHorse'] = {[ActualSelectedTable.name] = true}
                    Cache['lastHorseName'] = ActualSelectedTable.name
                    HorsePed =
                        CreatePed(
                        ActualSelectedTable.name,
                        Config.Estabulos[nearStable].preview[1],
                        Config.Estabulos[nearStable].preview[2],
                        Config.Estabulos[nearStable].preview[3],
                        heading,
                        false,
                        true,
                        true,
                        true
                    )
                    n(0x283978A15512B2FE, HorsePed, true)
                    SetEntityCanBeDamaged(HorsePed, false)
                    SetEntityInvincible(HorsePed, true)
                    FreezeEntityPosition(HorsePed, true)
                    SetEntityHeading(HorsePed, lastHeading)
                    SetModelAsNoLongerNeeded(horsePed)
                end

                for i = 1, #Config.cavalos do
                    if
                        WarMenu.Button(
                            i .. ': ' .. Config.cavalos[tonumber(i)].label,
                            '$' .. Config.cavalos[tonumber(i)].preco,
                            Config.cavalos[tonumber(i)].descricao
                        )
                     then
                        if operationTimer <= 0 then
                            Core.CreateThread(
                                function()
                                    AddTextEntry('FMMC_MPM_TYP9', 'Escolha um nome para seu pangaré!')
                                    DisplayOnscreenKeyboard(1, 'FMMC_MPM_TYP9', '', '', '', '', '', 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Sleep(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        local inPut1 = GetOnscreenKeyboardResult()
                                        local index = tonumber(WarMenu.Selected())
                                        x_cavalosSV.Buy(Config.cavalos[tonumber(i)].name, inPut1, index)
                                    end
                                end
                            )
                            operationTimer = 5
                        else
                            TriggerEvent(
                                'xFramework:Notify',
                                'negado',
                                'Você está efetuando operações na compra de cavalos rápido demais',
                                5000
                            )
                        end
                    end
                end
                WarMenu.Display()
            end
            if WarMenu.IsMenuOpened('principal') then
                if opened.cavalos then
                    DeletePed(HorsePed)
                    Cache['lastSpawnHorse'] = {[Cache['lastHorseName']] = false}
                    SetCamActive(CamHorse, false)
                    RenderScriptCams(false, true, 1000, true, true, 0)
                    DestroyCam(CamHorse, true)
                    if tunningHorse then
                        DeletePed(tunningHorse)
                    end
                    opened.cavalos = false
                end
                if (CamCarrocas) then
                    SetCamActive(CamCarrocas, false)
                    RenderScriptCams(false, true, 1000, true, true, 0)
                    DestroyCam(CamCarrocas, true)
                end
                if (carrocaSpawn and carrocaSpawn >= 1) then
                    DeleteVehicle(carrocaSpawn)
                end

                W = 1
                if WarMenu.MenuButton('Cavalos', 'cavalos_compra') then
                    WarMenu.OpenMenu('cavalos_compra')
                end
                if WarMenu.MenuButton('Carroças', 'carrocas_compra') then
                    WarMenu.OpenMenu('carrocas_compra')
                end
                if WarMenu.MenuButton('Aprimoramentos', 'aprimoramento_central') then
                    WarMenu.OpenMenu('aprimoramento_central')
                end

                WarMenu.Display()
            end
            Sleep(W)
        end
    end
)

Core.CreateThread(
    function()
        while true do
            local sleep = 500
            if opened.cavalos then
                sleep = 5
            end
            if
                IsControlJustPressed(0, 0xA65EBAB4) and opened.cavalos and HorsePed and HorsePed > 0 or
                    IsControlPressed(0, 0xA65EBAB4) and opened.cavalos and HorsePed and HorsePed > 0
             then
                SetEntityHeading(HorsePed, (GetEntityHeading(HorsePed)) - (10.0))
                lastHeading = (GetEntityHeading(HorsePed)) - (10.0)
            elseif
                IsControlJustPressed(0, 0xDEB34313) and opened.cavalos and HorsePed and HorsePed > 0 or
                    IsControlPressed(0, 0xDEB34313) and opened.cavalos and HorsePed and HorsePed > 0
             then
                SetEntityHeading(HorsePed, (GetEntityHeading(HorsePed)) + (10.0))
                lastHeading = (GetEntityHeading(HorsePed)) + (10.0)
            end
            --  tuning horse
            if
                IsControlJustPressed(0, 0xA65EBAB4) and opened.cavalos and tunningHorse and tunningHorse > 0 or
                    IsControlPressed(0, 0xA65EBAB4) and opened.cavalos and tunningHorse and tunningHorse > 0
             then
                SetEntityHeading(tunningHorse, (GetEntityHeading(tunningHorse)) - (10.0))
                lastHeading2 = (GetEntityHeading(tunningHorse)) - (10.0)
            elseif
                IsControlJustPressed(0, 0xDEB34313) and opened.cavalos and tunningHorse and tunningHorse > 0 or
                    IsControlPressed(0, 0xDEB34313) and opened.cavalos and tunningHorse and tunningHorse > 0
             then
                SetEntityHeading(tunningHorse, (GetEntityHeading(tunningHorse)) + (10.0))
                lastHeading2 = (GetEntityHeading(tunningHorse)) + (10.0)
            end
            Sleep(100)
        end
    end
)
Core.CreateThread(
    function()
        while true do
            Sleep(0)
            if operationTimer > 0 then
                Wait(tonumber(operationTimer * 1000))
                operationTimer = 0
            end
        end
    end
)

function Function.SpawnNewCarroca(ped, name)
end
function Function.SpawnedCoach()
    if Cache['ActualTypeSpawn'] == "carroca" then 
        return Cache['actualspawnedcartname'], Cache['actualcartped'], GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true)
    else
        return false
    end
end


local extramina = 0
function Function.SpawnNewHorse(ped, name)
    -- carregar entity do cavalo
    local Config = x_cavalosSV.SendCFG()
    local i = 0
    RequestModel(ped)
    while not HasModelLoaded(ped) do
        i = i + 1
        -- (' valor de i == '.. i.. " não pode passar de: 90000 para não acusar System_Error_397::400" )
        if i > 90000 then
            error(ped .. ' não é valido')
            return
        end
        RequestModel(ped)
        Sleep(1)
    end
    -- var
    local playerPed = PlayerPedId()
    Mantas = nil
    Cornetas = nil
    Alforjes = nil
    Caudas = nil
    Cabelos = nil
    Selas = nil
    Estribos = nil
    Saco_Dormir = nil
    Lanterna = nil
    Mascara = nil
    Upgrades = {}
    x_cavalosSV.AtualizarVariaveis(name)
    Cache['ActualHorsePed'] = ped
    -- print(nearStable)
    spawnedHorse =
        CreatePed(
        ped,
        Config.HorsePositions[selectedHorsePositionIndex].Retirar[1],
        Config.HorsePositions[selectedHorsePositionIndex].Retirar[2],
        Config.HorsePositions[selectedHorsePositionIndex].Retirar[3],
        GetEntityHeading(playerPed),
        1,
        0
    )
    local entity = spawnedHorse
    local default_stamina = GetAttributeCoreValue(spawnedHorse, 1)
    default_stamina = default_stamina - 50
    Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 1, default_stamina) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 0, default_stamina) --core
    n(0x6A071245EB0D1882, spawnedHorse, playerPed, -1, 15.2, 2.0, 0, 0)
    n(0x283978A15512B2FE, spawnedHorse, true)
    n(0x23f74c2fda6e7c61, -1230993421, spawnedHorse)
    n(0x5F57522BC1EB9D9D, spawnedHorse, GetHashKey('PLAYER_HORSE'))
    n(0xFD6943B6DF77E449, spawnedHorse, false)
    tag = n(0xE961BF23EAB76B12, spawnedHorse, name)
    n(0x931B241409216C1F, PlayerPedId(), spawnedHorse, 0)
    n(0x5F57522BC1EB9D9D, tag, GetHashKey('PLAYER_HORSE'))
    AddAttributePoints(spawnedHorse, 7, 950)
    n(0xA691C10054275290, PlayerPedId(), spawnedHorse, 0)
    n(0x931B241409216C1F, PlayerPedId(), spawnedHorse, 0)
    n(0xED1C764997A86D5A, PlayerPedId(), spawnedHorse)
    n(0xED1C764997A86D5A, PlayerPedId(), spawnedHorse)
    n(0xB8B6430EAD2D2437, spawnedHorse, 130495496)
    n(0xDF93973251FB2CA5, GetEntityModel(spawnedHorse), 1)
    n(0xAEB97D84CDF3C00B, spawnedHorse, 0)
    n(0x1913FE4CBF41C463, spawnedHorse, 211, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 208, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 209, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 400, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 297, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 136, false)
    n(0x1913FE4CBF41C463, spawnedHorse, 312, false)
    n(0x1913FE4CBF41C463, spawnedHorse, 113, false)
    n(0x1913FE4CBF41C463, spawnedHorse, 301, false)
    n(0x1913FE4CBF41C463, spawnedHorse, 277, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 319, true)
    n(0x1913FE4CBF41C463, spawnedHorse, 6, true)
    n(0x9FF1E042FA597187, spawnedHorse, 25, false)
    n(0x9FF1E042FA597187, spawnedHorse, 24, false)
    n(0xA691C10054275290, spawnedHorse, PlayerId())
    n(0x6734F0A6A52C371C, PlayerId(), 431)
    n(0x024EC9B649111915, spawnedHorse, 1)
    n(0xEB8886E1065654CD, spawnedHorse, 10, 'ALL', 10)
    local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
	local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
    newStamina = Stamina + x_cavalosSV.times(ped)
	Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 1, newStamina)
    extramina = newStamina
    print("extramina deve ser : " , extramina)
    -- Default Stamina --
    -- Depois o RELOADHORSEATRIBBUTES arruma isso --
    ReloadHorseAtributes(spawnedHorse)
end

function round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)
        if extramina > 0 then
            if GetAttributeCoreValue(spawnedHorse, 1) > extramina then 
                Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 1, extramina)
                print(">>>")
            end
            Wait(5000)
            if GetAttributeCoreValue(spawnedHorse, 1) <= 0 then
                print(Citizen.InvokeNative(0xC5286FFC176F28A2, spawnedHorse))
                if not Citizen.InvokeNative(0xC5286FFC176F28A2, spawnedHorse) and  Cache['ActualHorsePed'] ~= '' then
                    print "go #1"
                    for i = 1, extramina do 
                        if Cache['ActualHorsePed'] == '' then 
                            print "no go" 
                            break 
                        end 
                        while GetEntitySpeed(spawnedHorse) >= 7 do 
                            Wait(30000/2) 
                        end 
                        if i + 10 > extramina then goto c end
                        Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 1, i+10) -- pass : + 4
                        if GetAttributeCoreValue(spawnedHorse, 1) > extramina then 
                            break 
                        end
                        ::c::
                        Wait(500)
                    end
                end
            end 
        end
    end
end)

function Function.SpawnNewVehicle(ped, name)
    -- print('spawnando...', ped)
    local i = 0
    local Config = x_cavalosSV.SendCFG()
    local playerPed = PlayerPedId()
    local hashCart = GetHashKey(ped)
    RequestModel(ped)
    while not HasModelLoaded(ped) do
        i = i + 1
        -- (' valor de i == '.. i.. " não pode passar de: 90000 para não acusar System_Error_397::400" )
        if i > 90000 then
            error(ped .. '/' .. hashCart .. ' não é valido')
            return
        end
        RequestModel(ped)
        Wait(1)
    end
    local checkPos =
        GetClosestVehicle(
        Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[1],
        Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[2],
        Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[3],
        3.001,
        0,
        71
    )
    if not DoesEntityExist(checkPos) then
        spawnedHorse =
            CreateVehicle(
            ped,
            Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[1],
            Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[2],
            Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[3] + 1,
            Config.CarrocaPositions[selectedCarrocaPositionIndex].Retirar[4],
            true,
            true,
            false,
            true
        )
        n(0xAF35D0D2583051B0, spawnedHorse, true)
        n(0x23F74C2FDA6E7C61, -1236452613, spawnedHorse)
        n(0x6A071245EB0D1882, spawnedHorse, pPID, 4000, 5.0, 2.0, 0, 0)
        n(0x98EFA132A4117BE1, spawnedHorse, name)
        n(0x4A48B6E03BABB4AC, spawnedHorse, name)

        local hashP = GetHashKey('PLAYER')
        n(0xADB3F206518799E8, spawnedHorse, hashP)
        n(0xCC97B29285B1DC3B, spawnedHorse, 1)
        Cache['actualcartped'] = ped
    else
        TriggerEvent('xFramework:Notify', 'negado', 'Veículo spawnado no local, aguarde a retirada...')
    end
end

Core.CreateThread(
    function()
        while true do
            Sleep(1000)
            if (spawnedHorse and spawnedHorse > 0 and DoesEntityExist(spawnedHorse)) then
                -- Checar distância do cavalo
                local x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId()))
                local x2, y2, z2 = table.unpack(GetEntityCoords(spawnedHorse))
                local useZ = true
                if GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, useZ) < 15 and n(0xAAB0FE202E9FC9F0, spawnedHorse) then
                    n(0x93171DDDAB274EB8, tag, 2)
                elseif IsMpGamerTagActive(tag) then
                    n(0x93171DDDAB274EB8, tag, 0)
                end
            end
        end
    end
)

Core.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if confirmacao > 0 then
                Wait(10000)
                if (confirmacao > 0) then
                    confirmacao = 0
                end
                if confirmacao > 0 then
                    TriggerEvent('xFramework:Notify', 'aviso', 'Seu aviso de confirmação expirou!')
                end
            end
        end
    end
)
Core.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if delay then
                Wait(5000)
                delay = false
            end
        end
    end
)

RegisterNetEvent('trigger:0x1012-012')
AddEventHandler(
    'trigger:0x1012-012',
    function()
        local DataSeq = {}
        if (spawnedHorse and spawnedHorse > 0) then
            if (Cache['ActualTypeSpawn'] == 'cavalo') then
                DataSeq = CurrentHorseAction
            elseif (Cache['ActualTypeSpawn'] == 'carroca') then
                DataSeq = CurrentCartAction
            else
                error('Erro na linha 1647: Não foram encontradas coerências.')
                DataSeq = {['stop'] = true}
            end
        end
        if not DataSeq['stop'] then
            local Distance =
                GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true)
            if (Distance < 5.0) then
                -- print('Pode abrir o inventario do cavalo '..json.encode(DataSeq))
                x_cavalosSV.OpenInventoryTrunks(DataSeq, Cache['ActualTypeSpawn'])
            end
        end
    end
)

Core.CreateThread(
    function()
        local cfg = x_cavalosSV.SendCFG()
        while true do
            local W = 500
            if (spawnedHorse and spawnedHorse > 0) then
                W = 1
                local control = cfg.botao_inventario
                if (IsControlJustPressed(0, tonumber(control))) then
                    -- print('FBI open up')
                    TriggerEvent('trigger:0x1012-012')
                end
            else
                W = 500
            end
            Sleep(W)
        end
    end
)

function Function.AddStamina()
    if
        spawnedHorse and
            GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true) < 5.0
     then
        Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, -224471938, 0, 0)
        Wait(5000)
        local times = x_cavalosSV.times(Cache['ActualHorsePed'])
        local base = GetAttributeCoreValue(horse, 1)
        local value = base * 0.20
        local value = base + value
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, value)
        PlaySoundFrontend('Core_Fill_Up', 'Consumption_Sounds', true, 0)
        ClearPedTasks(PlayerPedId())
    end
end

function Function.WashHorse()
    if
        spawnedHorse and
            GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true) < 5.0
     then
        Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, GetHashKey('INTERACTION_BRUSH'), 0, 0)
        Wait(8000)
        ClearPedEnvDirt(spawnedHorse)
        ClearPedEnvDirt(spawnedHorse)
        ClearPedDamageDecalByZone(spawnedHorse, 10, 'ALL')
        ClearPedBloodDamage(spawnedHorse)
        ClearPedTasks(PlayerPedId())
    end
end

local Horses = {}
local BrushPrompt = {}
local LeadPrompt = {}
local FeedPrompt = {}

Citizen.CreateThread(
    function()
        while true do
            Wait(2000)
            local itemSet = CreateItemset(true)
            local size =
                Citizen.InvokeNative(
                0x59B57C4B06531E1E,
                GetEntityCoords(PlayerPedId()),
                20.0,
                itemSet,
                1,
                Citizen.ResultAsInteger()
            )
            if size > 0 then
                for index = 0, size - 1 do
                    local entity = GetIndexedItemInItemset(index, itemSet)
                    if GetPedType(entity) == 28 and spawnedHorse and entity == spawnedHorse then
                        local model = GetEntityModel(entity)
                        if Citizen.InvokeNative(0x772A1969F649E902, model) == 1 then -- IS_MODEL_A_HORSE
                            AddPrompts(entity)
                        end
                    end
                end
            end

            if IsItemsetValid(itemSet) then
                DestroyItemset(itemSet)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local id = PlayerId()
            if IsPlayerTargettingAnything(id) then
                local result, entity = GetPlayerTargetEntity(id)
                if PromptHasStandardModeCompleted(BrushPrompt[entity]) then -- 0x4CC0E2FE
                    local coords = GetEntityCoords(PlayerPedId())
                    local coordshorse = GetEntityCoords(entity)
                    local distance = #(coords - coordshorse)
                    if distance < 1.75 then
                        print('brush')
                        Brush(PlayerPedId(), entity)
                    end
                end
                if PromptHasStandardModeCompleted(LeadPrompt[entity]) then -- 0xE30CD707
                    local player = PlayerPedId()
                    local coords = GetEntityCoords(player)
                    local coordshorse = GetEntityCoords(entity)
                    local distance = #(coords - coordshorse)
                    if distance < 1.75 then
                        Citizen.InvokeNative(0x9A7A4A54596FE09D, player, entity)
                    end
                end
                if PromptHasStandardModeCompleted(FeedPrompt[entity]) then -- 0xE30CD707
                    local coords = GetEntityCoords(PlayerPedId())
                    local coordshorse = GetEntityCoords(entity)
                    local distance = #(coords - coordshorse)
                    if distance < 1.75 then
                    -- TriggerServerEvent('cryptos_horses:requestfeed', entity)
                    end
                end
            end
        end
    end
)

function AddPrompts(entity)
    local group = Citizen.InvokeNative(0xB796970BD125FCE8, entity, Citizen.ResultAsLong()) -- PromptGetGroupIdForTargetEntity

    local str = 'Alimentar'
    BrushPrompt[entity] = PromptRegisterBegin()
    PromptSetControlAction(BrushPrompt[entity], 0x63A38F2C)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(BrushPrompt[entity], str)
    PromptSetEnabled(BrushPrompt[entity], 1)
    PromptSetVisible(BrushPrompt[entity], 1)
    PromptSetStandardMode(BrushPrompt[entity], 1)
    PromptSetGroup(BrushPrompt[entity], group)
    PromptRegisterEnd(BrushPrompt[entity])

    local str2 = 'Conduzir'
    LeadPrompt[entity] = PromptRegisterBegin()
    PromptSetControlAction(LeadPrompt[entity], 0x17D3BFF5)
    str = CreateVarString(10, 'LITERAL_STRING', str2)
    PromptSetText(LeadPrompt[entity], str)
    PromptSetEnabled(LeadPrompt[entity], 1)
    PromptSetVisible(LeadPrompt[entity], 1)
    PromptSetStandardMode(LeadPrompt[entity], 1)
    PromptSetGroup(LeadPrompt[entity], group)
    PromptRegisterEnd(LeadPrompt[entity])

    local str3 = 'Escovar'
    FeedPrompt[entity] = PromptRegisterBegin()
    PromptSetControlAction(FeedPrompt[entity], 0x0D55A0F0)
    str = CreateVarString(10, 'LITERAL_STRING', str3)
    PromptSetText(FeedPrompt[entity], str)
    PromptSetEnabled(FeedPrompt[entity], 1)
    PromptSetVisible(FeedPrompt[entity], 1)
    PromptSetStandardMode(FeedPrompt[entity], 1)
    PromptSetGroup(FeedPrompt[entity], group)
    PromptRegisterEnd(FeedPrompt[entity])
end

function Function.moreStaminaEat(vl)
    if spawnedHorse then 
        if GetMount(PlayerPedId()) == spawnedHorse then 
            if x_cavalosSV.times(Cache['ActualHorsePed']) < 100 then
                local playerPed = PlayerPedId()
	            local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
	            local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
	            local newStamina = Stamina + vl
	            local isMounted = IsPedOnMount(playerPed)
	            TaskAnimalInteraction(PlayerPedId(), GetMount(PlayerPedId()),-224471938, 0, 0)
	            Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 1, newStamina)  
                PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
                x_cavalosSV.add_time(Cache['ActualHorsePed'], vl)
                extramina = newStamina
            else
                TriggerEvent("xFramework:Notify", "negado", "Passou dos limites: Você não pode mais dar frutas ao seu cavalo, pois a stamina dele já está alta!")
            end
        end
    else 
        print "cade seu cavalo?"
    end
end
function Function.Limpar(health)
    if spawnedHorse then 
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawnedHorse), true) < 3 then 
            local player = PlayerPedId()
            local horse = spawnedHorse
            local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
            health = Heal+health
            Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, GetHashKey("INTERACTION_BRUSH"), 0, 0)
            Wait(8000)
            ClearPedEnvDirt(horse)
            brushcount = 1
            Wait(8000)
            Citizen.InvokeNative(0xE3144B932DFDFF65, horse, 0.0, -1, 1, 1)
            ClearPedEnvDirt(horse)
            ClearPedDamageDecalByZone(horse ,10 ,"ALL")
            ClearPedBloodDamage(horse)
            Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, health)  
        end
    else
        print "cade seu cavalo ?"
    end
end



function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z+1.0)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.35, 0.35)
      SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 255)
        DisplayText(str,_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local count = 0 
        local playerHash = GetHashKey("PLAYER")
        if spawnedHorse then 
            -- print(GetEntityHealth(spawnedHorse))
            if GetEntityHealth(spawnedHorse) <= 0 then 
                TriggerEvent("xFramework:Notify", "aviso", "Seu cavalo agora está seguro no estábulo")
                DeleteEntity(spawnedHorse)
                x_cavalosSV.SyncDeleteHorse(spawnedHorse)
                spawnedHorse = nil
                tag = nil
                Cache['PlayerspawnedHorses'] = {}
                Cache['ActualSelectedHorseName'] = {}
                Cache['actualspawnedcart'] = {}
                Cache['actualspawnedcartname'] = {}
                Cache['actualcartped'] = ''
                Cache['ActualHorsePed'] = ''
                -- TriggerEvent("xFramework:Notify", 'sucesso', '[' ..(math.floor(aT/60))..'s]: Seu cavalo foi até o estabulo. Você pode chamá-lo novamente a qualquer momento com /cavalos!')
                aT = 0
                Cache['px'] = 0
            end
        end 
        if IsControlJustPressed(0, 0xCEFD9220) then
            Citizen.InvokeNative(0xBF25EB89375A37AD, 1, playerHash, playerHash)
            active = true 
            Wait(4000)
        end
        if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped, false) and active then 
            Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
            active = false
        elseif active and IsPedOnMount(ped) or IsPedInAnyVehicle(ped, false) then 
            if GetPedInVehicleSeat(GetMount(ped), -1) == ped then
                Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
            end
        end 
        Citizen.Wait(0)
    end
end)