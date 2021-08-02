local t_alert = {"negado","aviso","sucesso"}

RegisterNetEvent("xFramework:Notify")
AddEventHandler("xFramework:Notify",function(data_type, data_text, time)
    local data_icon = ""

        data_icon = "fas fa-exclamation-triangle"
    -- end
    if not time then time = 10000 end
    local data_position = "row-reverse"
    GTA_NUI_ShowNotification({
        text = data_text,
        type = data_type,
        icon = data_icon,
        time = time,
        position = data_position
    })
end)
function GTA_NUI_ShowNotification(setup)
    local text = setup.text or " "
    local config_alert = setup.type or t_alert[1]
    local typeAlert = t_alert[config_alert]
    local icon = setup.icon or "fas fa-check fa-2x"
    local position = setup.position or "row-reverse"
    SendNUIMessage({
        type = "notification_main",
        activate = true,
        data_type = config_alert,
        data_text = text,
        data_icon = icon,
        data_time = setup.time,
        data_position = position
    })
end
RegisterNUICallback("main", function()
    TriggerServerEvent("GTA_Notif:PlayOnSource", 'blop', 0.3) --> play sound.
end)
RegisterNUICallback("error", function()
    -- print("NUI WANTED ERROR : Text empty or type notif not valid.")
end)