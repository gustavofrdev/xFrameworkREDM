

local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tools = module('Server/CallBack/Callback_Tools')
chatSV = Tunnel.getInterface('chat')
chatCL = Proxy.getInterface('chat')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')
Function = {}
Proxy.addInterface('chat', Function)
Tunnel.bindInterface('chat', Function)
local isRDR = not TerraingridActivate and true or false

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local hideChat = false
local curDelayTime = 3
local group = 'user'
AddEventHandler('onClientResourceStart', function(name)
end)

AddEventHandler('onClientResourceStart', function(name)
end)--Doublox#9803---
RegisterNetEvent('chatMessage')
RegisterNetEvent('chatMessageA')
RegisterNetEvent('chatMessageG')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addMessageA')
RegisterNetEvent('chat:addMessageG')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')
RegisterCommand('hidechat', function()
  hideChat = not hideChat
end)--Doublox#9803---
--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  if hideChat == false then 
    local args = { text }
    if author ~= "" then
      table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  end
end)
    
RegisterNetEvent('setGroupStaff')
AddEventHandler('setGroupStaff', function(groupe)
group = groupe
end)

AddEventHandler('ReportAntiSpam', function()
  if not antispam then
  antispam = true
  Citizen.Wait(600 * 1000)
  antispam = false
  end
  end)


hide = 0 
RegisterCommand('chatmute', function()
    TriggerEvent('dbx:mute')
    hide = 0
end)

RegisterCommand('chatunmute', function()
    hide = hide + 1
end)

RegisterNetEvent('dbx:mute')
AddEventHandler('dbx:mute', function()
Citizen.CreateThread(function()
  while true do
    if hide == 0 then 
      Citizen.Wait(50)
      TriggerEvent('chat:clear')
    else
        break
    end
    end
  end)
end)       	

RegisterCommand('clearchat', function()
      Citizen.Wait(50)
      TriggerEvent('chat:clear')
          end)
    
--Doublox#9803---
AddEventHandler('chatMessageA', function(author, color, text)
  if hideChat == false then
    local args = { text }
    if author ~= "" then
      table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'ON_MESSAGEA',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  end
end)

AddEventHandler('chatMessageG', function(author, color, text)
  if hideChat == false then
    local args = { text }
    if author ~= "" then
      table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'ON_MESSAGEG',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  end
end)--Doublox#9803---

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  if hideChat == false then
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        templateId = 'print',
        multiline = true,
        args = { msg }
      }
    })
  end
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)--Doublox#9803---

AddEventHandler('chat:addMessageA', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGEA',
    message = message
  })
end)

AddEventHandler('chat:addMessageG', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGEG',
    message = message
  })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)--Doublox#9803---

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)
--Doublox#9803---
AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()
--Doublox#9803---
    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      if not delayChat then 
        DelayChat()
        TriggerServerEvent('_chat:messageEntered', chatSV.nomes().nome.. " ".. chatSV.nomes().sobrenome, { r, g, b }, data.message)
      else 
        TriggerEvent("xFramework:Notify","negado","Não floode o chat, se acalme")
        EndTextCommandThefeedPostTicker(false, true)
      end
    end
  end

  cb('ok')
end)
--Doublox#9803---
RegisterNUICallback('chatResultA', function(data, cb)
    chatInputActive = false
    SetNuiFocus(false, false)
  
    if not data.canceled then
      local id = PlayerId()
  --Doublox#9803---
      --deprecated
      local r, g, b = 0, 0x99, 255
  
      if data.message:sub(1, 1) == '/' then
        ExecuteCommand(data.message:sub(2))
      else
        if not delayChat then 
          DelayChat()
          TriggerServerEvent('_chat:messageEnteredA', chatSV.nomes().nome.. " ".. chatSV.nomes().sobrenome, { r, g, b }, data.message)
        else 
          TriggerEvent("xFramework:Notify","negado","Não floode o chat, se acalme")
          EndTextCommandThefeedPostTicker(false, true)
        end
      end
    end
  
    cb('ok')
end)

RegisterNUICallback('chatResultG', function(data, cb)
    chatInputActive = false
    SetNuiFocus(false, false)
  
    if not data.canceled then
      local id = PlayerId()
  --Doublox#9803---
      --deprecated
      local r, g, b = 0, 0x99, 255
  
      if data.message:sub(1, 1) == '/' then
        ExecuteCommand(data.message:sub(2))
      else
        if not delayChat then 
          DelayChat()
          TriggerServerEvent('_chat:messageEnteredG', "!Anon ["..chatSV.id().."]", { r, g, b }, data.message)
        else 
          TriggerEvent("xFramework:Notify","negado","Não floode o chat, se acalme")
          EndTextCommandThefeedPostTicker(false, true)
        end
      end
    end
  
    cb('ok')
  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}
--Doublox#9803---
    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')
--Doublox#9803---
      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)

  while true do
    Wait(0)
--Doublox#9803---
    if not chatInputActive then
      if IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
      ExecuteCommand("jfiowjriwoj3")
        chatInputActive = true
        chatInputActivating = true
        --SetNuiFocus(true, true)
        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) then
        ExecuteCommand("jfiowjriwoj3")
        SetNuiFocus(true, true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end
--Doublox#9803---
      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)

RegisterCommand('res', function()
  SetNuiFocus(false, false)
end)

function DelayChat()
  return true 
  --> HardCoded!
end

----------------------------------------------------
--Doublox#9803---
---------------------------------------------
