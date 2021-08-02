local jailed, jailedTime = false, 0;
local jail_missions_status = {stage = 0}
local missionStarted = false;
local sv_manage = false 
local sv_manage2 = false 
function _Framework.Prender(time)
    local cfg = FrameworkSV.JailConfig()
    local ped = PlayerPedId();
    SetEntityCoords(ped, cfg.posicao[1], cfg.posicao[2], cfg.posicao[3])
    jailed = true 
    jailedTime = time
end


-- TODO: Checar se o player está fugindo da cadeira através de bug 
Citizen.CreateThread(function()
local cfg = FrameworkSV.JailConfig()
while true do 
    Citizen.Wait(5000)
    if jailed then 
        local pC = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(pC, cfg.posicao[1], cfg.posicao[2], cfg.posicao[3], true) > 50 then 
                SetEntityCoords(PlayerPedId(), cfg.posicao[1], cfg.posicao[2], cfg.posicao[3])
                TriggerEvent("xFramework:Notify", "aviso", cfg.pegoMsg)
            end
        end
    end
end)
Citizen.CreateThread(function()
local cfg = FrameworkSV.JailConfig()
    while true do 
       local Wa = 500
        if jailed then 
            local pC = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(pC,cfg.job.posicoes.Start[1],cfg.job.posicoes.Start[2],cfg.job.posicoes.Start[3], true) < 5 and not missionStarted then  
                Wa = 1
                if IsControlJustPressed(0, 0x760A9C6F) then 
                    TriggerEvent("xFramework:Notify", "aviso", cfg.msg1)
                    missionStarted = true
                end
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153,cfg.job.posicoes.Start[1] - 0.6,cfg.job.posicoes.Start[2],cfg.job.posicoes.Start[3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                DrawText3D(cfg.job.posicoes.Start[1],cfg.job.posicoes.Start[2],cfg.job.posicoes.Start[3], cfg.startMsg)
            end
            if GetDistanceBetweenCoords(pC,cfg.job.posicoes.Analise[1],cfg.job.posicoes.Analise[2],cfg.job.posicoes.Analise[3], true) < 5 and jail_missions_status.stage == 0 and missionStarted then  
                Wa = 1
                if IsControlJustPressed(0, 0x760A9C6F) then 
                    if not sv_manage then 
                    missionStarted = true
                    jail_missions_status.stage = 1
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetEntityCoordsNoOffset(PlayerPedId(), cfg.job.posicoes.Analise[1],cfg.job.posicoes.Analise[2],cfg.job.posicoes.Analise[3])
                    SetEntityHeading(PlayerPedId(), cfg.job.posicoes.Analise[4])
                    exports["x_progress"]:startUI(4900, "Separando maçães")
                    Wait(5000)
                    exports["x_progress"]:startUI(6000, "Pegando saco...")
                    ExecuteCommand(cfg.job.anicoes.PegarSaco)
                    Wait(6000)
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent("xFramework:Notify", "aviso", cfg.msg2)
                    FrameworkSV.sv_manage_jail()
                else
                    TriggerEvent("xFramework:Notify", "aviso", "Aguarde...")
                    end
                end 
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153,cfg.job.posicoes.Analise[1] - 0.6,cfg.job.posicoes.Analise[2],cfg.job.posicoes.Analise[3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                DrawText3D(cfg.job.posicoes.Analise[1],cfg.job.posicoes.Analise[2],cfg.job.posicoes.Analise[3]-1, cfg.startMsg2)
            end
            if GetDistanceBetweenCoords(pC,cfg.job.posicoes.Final[1],cfg.job.posicoes.Final[2],cfg.job.posicoes.Final[3], true) < 5 and jail_missions_status.stage == 1 and missionStarted then  
                Wa = 1
                if IsControlJustPressed(0, 0x760A9C6F) then 
                    if not sv_manage2 then  
                    missionStarted = true
                    jail_missions_status.stage = 1
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetEntityCoordsNoOffset(PlayerPedId(), cfg.job.posicoes.Final[1],cfg.job.posicoes.Final[2],cfg.job.posicoes.Final[3])
                    SetEntityHeading(PlayerPedId(), cfg.job.posicoes.Final[4])
                    exports["x_progress"]:startUI(6000, "Entregando saco...")
                    ExecuteCommand(cfg.job.anicoes.JogarSaco)
                    Wait(6000)
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent("xFramework:Notify", "aviso", cfg.msg3)
                    jailedTime = jailedTime - cfg.job.reducaoPenalPass
                    jail_missions_status.stage = 0
                    missionStarted = false
                    local string = cfg.faltam 
                    local str = string.gsub(string, "(time_prisao)", jailedTime)
                    TriggerEvent("xFramework:Notify", "aviso", str)
                    FrameworkSV.sv_manage_jail2()
                    else 
                        TriggerEvent("xFramework:Notify", "aviso", "Aguarde...")
                    end
                end 
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153,cfg.job.posicoes.Final[1] - 0.6,cfg.job.posicoes.Final[2],cfg.job.posicoes.Final[3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                DrawText3D(cfg.job.posicoes.Final[1],cfg.job.posicoes.Final[2],cfg.job.posicoes.Final[3]-1, cfg.startMsg3)
            end
        end
        Citizen.Wait(Wa)
    end
end)

-- TODO: Tempo da cadeia
Citizen.CreateThread(function()
local cfg = FrameworkSV.JailConfig()
    while true do 
        Citizen.Wait(60000)
        if jailed then 
            if jailedTime - 1 <= 0 then 
                jailedTime = 0
                local string = cfg.faltam 
                local str = string.gsub(string, "(time_prisao)", jailedTime)
                TriggerEvent("xFramework:Notify", "aviso", str)
                jailed = false 
                jailedTime = 0 
                jail_missions_status.stage = 0
                missionStarted = false
                SetEntityCoordsNoOffset(PlayerPedId(), cfg.saida[1], cfg.saida[2], cfg.saida[3])
            else
                jailedTime = jailedTime - 1
                local string = cfg.faltam 
                local str = string.gsub(string, "(time_prisao)", jailedTime)
                TriggerEvent("xFramework:Notify", "aviso", str)
            end 
        end
    end
end)

RegisterNetEvent("sv_manage_jail_sync")
AddEventHandler("sv_manage_jail_sync", function(s)
sv_manage = s
end)
RegisterNetEvent("sv_manage_jail_sync2")
AddEventHandler("sv_manage_jail_sync2", function(s2)
sv_manage2 = s2
end)

-- utilidades!



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