RegisterCommand('cv',function()
    if x_policiaSv.permissao() then
        local player = FrameworkCL.GetNearestPlayer(3)
        print(player)
        if player > 0 then
            x_policiaSv.cv(player)
        end
    end
end)

RegisterCommand('rv',function()
    if x_policiaSv.permissao() then
        local player = FrameworkCL.GetNearestPlayer(3)
        print(player)
        if player > 0 then
            x_policiaSv.rv(player)
        end
    end
end)

