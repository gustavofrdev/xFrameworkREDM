
local x, y, z = 0, 0, 0
local loadnpc = function(personagem)
    local i = 1
    personagem = GetHashKey(personagem)
    while not HasModelLoaded(personagem) do
        i = i + 1
        RequestModel(personagem)
        if i > 200 then
            error(
                'Há algo de errado com o ped(NÃO EXISTENTE/ERRO DIGITAÇÃO). Isso fez com que o script parasse de rodar. Por favor, verifique o problema.'
            )
            break
        end
        Citizen.Wait(10)
    end
end
Citizen.CreateThread(function()
    while true do 
        local Wait = 500
        local playerCoords = GetEntityCoords(PlayerPedId());
            for k, v in pairs(config.spawnPositions) do 
                if GetDistanceBetweenCoords(playerCoords, v["BlipPos"][1],v["BlipPos"][2],v["BlipPos"][3], true) < 4.0 then 
                    Wait = 1
                    Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, v["BlipPos"][1] - 0.6,v["BlipPos"][2],v["BlipPos"][3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                   if GetDistanceBetweenCoords(playerCoords, v["BlipPos"][1],v["BlipPos"][2],v["BlipPos"][3], true) < 1.0 then 
                    DrawText3D( v["BlipPos"][1] - 0.6,v["BlipPos"][2],v["BlipPos"][3]-1, "Pressione ~e~[G]~p~ para acessar a lista de cavalos dos medicos")
                        if IsControlJustPressed(0, 0x760A9C6F) then 
                            if x_medicosSv.permissao() then 
                                print("ok")
                            WarMenu.OpenMenu("Cavalos-medicos")
                            x, y, z =  v["Positions"][1], v["Positions"][2], v["Positions"][3]
                            end
                        end
                   end
                end
            end
        Citizen.Wait(Wait)
    end
end)


Citizen.CreateThread(function()
WarMenu.CreateMenu("Cavalos-medicos", "Cavalos medicos")
while true do 
        if WarMenu.IsMenuOpened("Cavalos-medicos") then 
            for k, v in pairs(config.medHorses) do
                if WarMenu.Button(v) then
                    loadnpc(k)

                    spawnNewMedHorse(k, {x = x, y = y, z = z})
                end
            end
            if WarMenu.Button("Devolver Cavalo") then
                devolverCavaloMethod()
            end
            WarMenu.Display()
        end
        Citizen.Wait(0);
    end
end )
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
