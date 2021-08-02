local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
ClothingServer = Tunnel.getInterface('clothing')
_Framework = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface('x_charactercreator')
_Tunnel = {}
Tunnel.bindInterface('x_charactercreator', _Tunnel)
local inCriacao = false
local Alturas = {0.8,0.85,0.90,0.95,1.0,1.05,1.1,1.15,1.20}
-------------------------------------------------------------------
-- Default Character <> --
-------------------------------------------------------------------
local DefaultCharacterData = {
  gender = "mp_male", CorPele = 2, CorOlhos = 2, Rosto = 1, Perfil = 1, CabeloModel = -1,
  Barba = -1, face_width = 1, eyebrow_height = 1, eyebrow_width = 1, eyebrow_depth = 1,
  ears_width = 1, ears_angle = 1, ears_height = 1, earlobe_size = 1, cheekbones_height =1,
  cheekbones_width = 1, cheekbones_depth = 1, jaw_height = 1, jaw_width = 1, jaw_depth = 1,
  chin_height = 1, chin_width = 1, chin_depth = 1, eyelid_height = 1, eyelid_width = 1,
  eyes_depth = 1, eyes_angle = 1, eyes_distance = 1, nose_width = 1, nose_size = 1,
  nose_height = 1, nose_angle = 1, nose_curvature = 1, nostrils_distance = 1, mouth_width = 1,
  mouth_depth = 1, mouth_x_pos = 1, mouth_y_pos = 1, upper_lip_height = 1, upper_lip_width = 1,
  upper_lip_depth = 1, lower_lip_height = 1, lower_lip_width = 1, lower_lip_depth = 1, velhice = -1,
  opacidadevelhice = 1, cicatriz = -1, opacidadecicatriz = 1, sardas = -1, opacidadesardas = 1,
  toupeiras = -1, sobrancelha = -1, palhetasobrancelha = 1, sobrancelhaopacidade = 1, altura = 1.1,
  delineados = 1, palhetadelineados = 1, opacidadedelineados = 1, sombras = 1, palhetasombras = 1, 
  opacidadesombras = 1, batom = 1, palhetabatom =1, opacidadebatom = 1, blush = 1, opacidadeblush = 1,
  palhetablush = 1
}

local m_default = {gunbelts = 3,belt_buckles = 1,gauntlets = 1,cloaks = 1,chaps = 1,hats = 1,vests = 1,suspenders = 1,coats = 1,
                  loadouts = 1,jewelry_bracelets = 1,accessories = 1,armor = 1,spats = 1,holsters_left = 1,boots = 7,jewelry_rings_left = 1,
                  boot_accessories = 1,ponchos = 1,pants = 46,neckties = 1,neckwear = 1,coats_closed = 1,belts = 1,shirts_full = 7,
                  jewelry_rings_right = 1,masks = 1,dresses = 1,eyewear = 1,satchels = 1,gloves = 1}

local f_default = {accessories = 1,neckwear = 1,suspenders = 1,gauntlets = 1,masks = 1,
                  jewelry_rings_left = 1,shirts_full = 11,satchels = 1,vests = 1,belt_buckles = 1,ponchos = 1,
                  boots = 5,spats = 1,chaps = 1,eyewear = 1,gunbelts = 1,neckties = 1,coats_closed = 1,skirts = 1,
                  loadouts = 1,boot_accessories = 1,bows = 1,cloaks = 1,hats = 1,
                  belts = 1,pants = 15,holsters_left = 1,coats_closed = 1,skirts = 1,
                  jewelry_bracelets = 1,coats = 1,jewelry_rings_right = 1}

function Instance(case)
  if case == true then
    Citizen.InvokeNative(0x17E0198B3882C2CB)
  elseif case == false then
    Citizen.InvokeNative(0xD0AFAFF5A51D72F7)
  end
end
-------------------------------------------------------------------
-- Variaveis <> --
-------------------------------------------------------------------
local isSkinCreatorOpened = false
local adding = true
local adding2 = true
local sex = 1
local maleheads = {}
local maletorsos = {}
local malelegs = {}
local maleeyes = {}
local malehairs = {}
local mustache = {}
local femaleheads = {}
local femaletorsos = {}
local femalelegs = {}
local femaleeyes = {}
local femalehairs = {}
local eye
local skin
local plec
local face
local size
local faces
local hair
local beard
local overlay_ped = PlayerPedId()
local cam

local textureId = -1
local overlay_opacity = 1.0
local user_id
local boolean = true



function teleportPlayerToStart()

  local x, y, z = -325.75, 761.14, 121.44
  SetEntityCoords(PlayerPedId(), x, y, z )
  SetEntityHeading(PlayerPedId(), 192.244)
  TriggerEvent("load::Clothes")
end


--------------------------------------------------------------------
-- functions <> --
--------------------------------------------------------------------
function requestModel(model)
  Citizen.CreateThread(
  function()
    RequestModel(model)
  end
  )
end
function CreateNewEvent(eventLabel, eventFunc)
  RegisterNetEvent(eventLabel)
  AddEventHandler(eventLabel, eventFunc)
end

function toggleOverlayChange(_name,_visibility,_tx_id,_tx_normal,_tx_material,_tx_color_type,_tx_opacity,_tx_unk,_palette_id,_palette_color_primary,_palette_color_secondary,_palette_color_tertiary,_var,_opacity, _targets)
  Citizen.CreateThread(function()
  local name = _name
  local visibility = _visibility
  local tx_id = _tx_id
  local tx_normal = _tx_normal
  local tx_material = _tx_material
  local tx_color_type = _tx_color_type
  local tx_opacity = _tx_opacity
  local tx_unk = _tx_unk
  local palette_id = _palette_id
  local palette_color_primary = _palette_color_primary
  local palette_color_secondary = _palette_color_secondary
  local palette_color_tertiary = _palette_color_tertiary
  local var = _var
  local opacity = _opacity
  local target = _targets

  for k,v in pairs(overlay_all_layers) do
    if v.name==name then
      v.visibility = visibility
      if visibility ~= 0 then
        v.tx_normal = tx_normal
        v.tx_material = tx_material
        v.tx_color_type = tx_color_type
        v.tx_opacity =  tx_opacity
        v.tx_unk =  tx_unk
        if tx_color_type == 0  then
          print(_name, "falha fatal.") 
          v.palette = color_palettes[palette_id][1]
          v.palette_color_primary = palette_color_primary
          v.palette_color_secondary = palette_color_secondary
          v.palette_color_tertiary = palette_color_tertiary
        end
        if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
          v.var = var
          v.tx_id = overlays_info[name][1].id
        else
          v.var = 0
          v.tx_id = overlays_info[name][tx_id].id
        end
        v.opacity = opacity
      end
    end
  end
  local ped = target
  if IsPedMale(ped) then
    current_texture_settings = texture_types["male"]
  else
    current_texture_settings = texture_types["female"]
  end
  if textureId ~= -1 then
    Citizen.InvokeNative(0xB63B9178D0F58D82,textureId)  -- reset texture
    Citizen.InvokeNative(0x6BEFAA907B076859,textureId)  -- remove texture
  end
  textureId = Citizen.InvokeNative(0xC5E7204F322E49EB,current_texture_settings.albedo, current_texture_settings.normal, current_texture_settings.material)  -- create texture
  for k,v in pairs(overlay_all_layers) do
    if v.visibility ~= 0 then
      local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02,textureId, v.tx_id , v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity,v.tx_unk) -- create overlay
      if v.tx_color_type == 0 then
        Citizen.InvokeNative(0x1ED8588524AC9BE1,textureId,overlay_id,v.palette)    -- apply palette
        Citizen.InvokeNative(0x2DF59FFE6FFD6044,textureId,overlay_id,v.palette_color_primary,v.palette_color_secondary,v.palette_color_tertiary)  -- apply palette colours
      end
      Citizen.InvokeNative(0x3329AAE2882FC8E4,textureId,overlay_id, v.var)  -- apply overlay variant
      Citizen.InvokeNative(0x6C76BC24F8BB709A,textureId,overlay_id, v.opacity) -- apply overlay opacity
    end
  end
  while not Citizen.InvokeNative(0x31DC8D3F216D8509,textureId) do  -- wait till texture fully loaded
    Citizen.Wait(0)
  end
  Citizen.InvokeNative(0x0B46E25761519058,ped,`heads`,textureId)  -- apply texture to current component in category "heads"
  Citizen.InvokeNative(0x92DAABA2C1C10B0E,textureId)      -- update texture
  Citizen.InvokeNative(0xCC8CA3E88256E58F,ped, 0, 1, 1, 1, false)  -- refresh ped components
  end)
end

local headingss = 274.00

-- FinishedCreator
function destory()
  DoScreenFadeOut(500)

  SetCamActive(cam, false)
  RenderScriptCams(false, true, 500, true, true)
  DisplayHud(true)
  DisplayRadar(true)
  DestroyAllCams(true)
  Wait(500)
  DoScreenFadeIn(500)
end

function camera(zoom, offset)
  DestroyAllCams(true)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local heading = 0.0
  local zoomOffset = zoom
  local camOffset = offset
  local angle = heading * math.pi / 180.0
  local theta = {
    x = math.cos(angle),
    y = math.sin(angle)
  }
  -- print(theta.x)
  local pos = {
    x = coords.x + (zoomOffset * theta.x),
    y = coords.y + (zoomOffset * theta.y)
  }
  -- print(pos.x)
  local angleToLook = heading - 140.0
  if angleToLook > 360 then
    angleToLook = angleToLook - 360
  elseif angleToLook < 0 then
    angleToLook = angleToLook + 360
  end
  -- print(angleToLook)
  angleToLook = angleToLook * math.pi / 180.0
  local thetaToLook = {
    x = math.cos(angleToLook),
    y = math.sin(angleToLook)
  }
  -- print(thetaToLook.x)
  local posToLook = {
    x = coords.x + (zoomOffset * thetaToLook.x),
    y = coords.y + (zoomOffset * thetaToLook.y)
  }
  -- print(posToLook.x)
  local add = 2.0
  if zoom == 0.9 then
    add = 0.5
  else
    add = 3.0
  end
  SetEntityHeading(playerPed, 250.00)
  cam =
  CreateCamWithParams(
  'DEFAULT_SCRIPTED_CAMERA',
  pos.x,
  pos.y,
  coords.z + camOffset,
  300.00,
  0.00,
  0.00,
  40.00,
  false,
  0
  )
  PointCamAtCoord(cam, posToLook.x, posToLook.y + add, coords.z + camOffset)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)
  DisplayHud(false)
  DisplayRadar(false)
end

function SetCharacter(data, uid)
  if uid ~= nil then
    user_id = uid
  end
  while adding or adding2 do  print('aguardando ADDING ou ADDING2, JA CARREGARÁ PERSONAGEM') Wait(0) end
    plec = 1
    if data.gender ~= "mp_female" and data.gender ~= "mp_male" then 
      print "caiu aqui ..."
        FrameworkCL.Skin(data.gender)
        print(data.custom_ped_variation)
        SetPedOutfitPreset(PlayerPedId(),tonumber(data.custom_ped_variation),0)
        TriggerEvent("select-selected-ped_outfit_selector", tonumber(data.custom_ped_variation))
        if not uid then TriggerEvent("loadMakeup") end
      return
    end
    if data.gender == "mp_female" then
      plec = 2
    end

    local model = 'mp_male'
    DefaultCharacterData.gender = data.gender
    local player = PlayerId()
    if plec == 1 then
      model = 'mp_male'
      sex = 1
    elseif plec == 2 then
      model = 'mp_female'
      sex = 2
    end
    local model2 = GetHashKey(model)
    while not HasModelLoaded(model2) do
      Wait(500)
      RequestModel(model2)
    end
    Citizen.InvokeNative(0xED40380076A31506, PlayerId(), model2)
    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, PlayerPedId(), 0, 0) -- SetPedOutfitPreset

    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId()) do -- wait till outfit fully loaded
      Citizen.Wait(0)
    end
    if IsPedMale(PlayerPedId()) then
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. maletorsos[1]),
      false,
      true,
      true
      )
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. malelegs[1]),
      false,
      true,
      true
      )
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. maleheads[1]),
      false,
      true,
      true
      )
      Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
    else
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. femaletorsos[1]),
      false,
      true,
      true
      )
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. femalelegs[1]),
      false,
      true,
      true
      )
      Citizen.InvokeNative(
      0xD3A7B003ED343FD9,
      PlayerPedId(),
      tonumber('0x' .. femaleheads[1]),
      false,
      true,
      true
      )
    end
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)


    skin = data.CorPele
    local torso = '0x' .. maletorsos[1]
    local legs = '0x' .. malelegs[1]
    local head = '0x' .. maleheads[1]
    texture_types['male'].albedo = GetHashKey('mp_head_mr1_sc08_c0_000_ab')
    if IsPedMale(PlayerPedId()) then
      -- print("macho")
      -- print('test skory')
      if tonumber(data.CorPele) == 1 then
        torso = '0x' .. maletorsos[1]
        legs = '0x' .. malelegs[1]
        head = '0x' .. maleheads[1]
        texture_types['male'].albedo = GetHashKey('mp_head_mr1_sc08_c0_000_ab')
      elseif tonumber(data.CorPele) == 2 then
        torso = '0x' .. maletorsos[10]
        legs = '0x' .. malelegs[10]
        head = '0x' .. maleheads[10]
        texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc03_c0_000_ab')
      elseif tonumber(data.CorPele) == 3 then
        torso = '0x' .. maletorsos[3]
        legs = '0x' .. malelegs[3]
        head = '0x' .. maleheads[3]
        texture_types['male'].albedo = GetHashKey('head_mr1_sc02_rough_c0_002_ab')
      elseif tonumber(data.CorPele) == 4 then
        torso = '0x' .. maletorsos[11]
        legs = '0x' .. malelegs[11]
        head = '0x' .. maleheads[11]
        texture_types['male'].albedo = GetHashKey('head_mr1_sc04_rough_c0_002_ab')
      elseif tonumber(data.CorPele) == 5 then
        torso = '0x' .. maletorsos[8]
        legs = '0x' .. malelegs[8]
        head = '0x' .. maleheads[8]
        texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc01_c0_000_ab')
      elseif tonumber(data.CorPele) == 6 then
        torso = '0x' .. maletorsos[30]
        legs = '0x' .. malelegs[30]
        head = '0x' .. maleheads[30]
        texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc05_c0_000_ab')
      else
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end

      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso), false, true, true)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs), false, true, true)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(head), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    else
      local torso2 = '0x' .. femaletorsos[1]
      local legs2 = '0x' .. femalelegs[1]
      local head2 = '0x' .. femalelegs[1]
      texture_types['female'].albedo = GetHashKey('mp_head_fr1_sc08_c0_000_ab')
      if tonumber(data.CorPele) == 1 then
        torso2 = '0x' .. femaletorsos[1]
        legs2 = '0x' .. femalelegs[1]
        head2 = '0x' .. femaleheads[1]
        texture_types['female'].albedo = GetHashKey('mp_head_fr1_sc08_c0_000_ab')
      elseif tonumber(data.CorPele) == 2 then
        torso2 = '0x' .. femaletorsos[10]
        legs2 = '0x' .. femalelegs[10]
        head2 = '0x' .. femaleheads[10]
        texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc03_c0_000_ab')
      elseif tonumber(data.CorPele) == 3 then
        torso2 = '0x' .. femaletorsos[3]
        legs2 = '0x' .. femalelegs[3]
        head2 = '0x' .. femaleheads[3]
        texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc03_c0_000_ab')
      elseif tonumber(data.CorPele) == 4 then
        torso2 = '0x' .. femaletorsos[11]
        legs2 = '0x' .. femalelegs[11]
        head2 = '0x' .. femaleheads[11]
        texture_types['female'].albedo = GetHashKey('head_fr1_sc02_rough_c0_002_ab')
      elseif tonumber(data.CorPele) == 5 then
        torso2 = '0x' .. femaletorsos[8]
        legs2 = '0x' .. femalelegs[8]
        head2 = '0x' .. femaleheads[8]
        texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc01_c0_000_ab')
      elseif tonumber(data.CorPele) == 6 then
        torso2 = '0x' .. femaletorsos[30]
        legs2 = '0x' .. femalelegs[30]
        head2 = '0x' .. femaleheads[30]
        texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc05_c0_000_ab')
      else
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end

      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso2), false, true, true)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs2), false, true, true)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(head2), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end


    print('olho')
    eye = data.CorOlhos
    if IsPedMale(PlayerPedId()) then
      local oczy = '0x' .. maleeyes[tonumber(eye)]
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(oczy), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    else
      local oczy2 = '0x' .. femaleeyes[tonumber(eye)]
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(oczy2), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end


    face = data.Rosto

    local twarz = '0x' .. maleheads[tonumber(face)]
    local twarz2 = '0x' .. femaleheads[tonumber(face)]
    if IsPedMale(PlayerPedId()) then
      ---- print (face)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    else
      ---- print (face)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz2), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end



    local BODY_TYPES = {
      32611963,
      -20262001,
      -369348190,
      -1241887289,
      61606861
    }
    -- print('perfil:' .. data.Perfil, BODY_TYPES[tonumber(data.Perfil)])
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), BODY_TYPES[tonumber(data.Perfil)])
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)



    hair = data.CabeloModel
    if tonumber(hair) > 1 then
      if IsPedMale(PlayerPedId()) then
        local wlosy = '0x' .. malehairs[tonumber(hair)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(wlosy), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        local wlosy2 = '0x' .. femalehairs[tonumber(hair)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(wlosy2), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    else
      Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0) -- Set target category, here the hash is for hats
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end


    beard = data.Barba
    if data.Barba ~= -1 then
      if IsPedMale(PlayerPedId()) then
        local broda = '0x' .. mustache[tonumber(beard)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(broda), false, true, true)
        -- end
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    end


    local features = {
      0x84D6,
      0x3303,
      0x2FF9,
      0x4AD1,
      0xC04F,
      0xB6CE,
      0x2844,
      0xED30,
      0x6A0B,
      0xABCF,
      0x358D,
      0x8D0A,
      0xEBAE,
      0x1DF6,
      0x3C0F,
      0xC3B2,
      0xE323,
      0x8B2B,
      0x1B6B,
      0xEE44,
      0xD266,
      0xA54E,
      0x6E7F,
      0x3471,
      0x03F5,
      0x34B1,
      0xF156,
      0x561E,
      0xF065,
      0xAA69,
      0x7AC3,
      0x1A00,
      0x91C1,
      0xC375,
      0xBB4D,
      0xB0B0,
      0x5D16
    }
    local value = data.face_width + 0.001
    -- print(data.face_width + 0)
    if data.face_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[1], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.eyebrow_height / 40
    -- print(data.eyebrow_height + 0)
    if data.eyebrow_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[2], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.eyebrow_width / 40
    -- print(data.eyebrow_width + 0)
    if data.eyebrow_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[3], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.eyebrow_depth / 50
    -- print(data.eyebrow_depth + 0)
    if data.eyebrow_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[4], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.ears_width  / 20
    -- print(data.ears_width  + 0)
    if data.ears_width  == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[5], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.ears_angle  / 20
    -- print(data.ears_angle  + 0)
    if data.ears_angle  == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[6], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.ears_height / 20
    -- print(data.ears_height + 0)
    if data.ears_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[7], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.earlobe_size  / 20
    -- print(data.earlobe_size  + 0)
    if data.earlobe_size  == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[8], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.cheekbones_height / 40
    -- print(data.cheekbones_height + 0)
    if data.cheekbones_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[9], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.cheekbones_width / 40
    -- print(data.cheekbones_width + 0)
    if data.cheekbones_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[10], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    -- print(data.cheekbones_depth + 0)
    if data.cheekbones_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[11], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.jaw_height / 40
    -- print(data.jaw_height + 0)
    if data.jaw_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[12], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.jaw_width / 40
    -- print(data.jaw_width + 0)
    if data.jaw_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[13], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.jaw_depth  / 40
    -- print(data.jaw_depth  + 0)
    if data.jaw_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[14], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.chin_height / 40
    -- print(data.chin_height + 0)
    if data.chin_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[15], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.chin_width / 40
    -- print(data.chin_width + 0)
    if data.chin_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[16], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.chin_depth / 40
    -- print(data.chin_depth + 0)
    if data.chin_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[17], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.eyelid_height / 40
    -- print(data.eyelid_height + 0)
    if data.eyelid_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[18], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.eyelid_width / 40
    -- print(data.eyelid_width + 0)
    if data.eyelid_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[19], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.eyes_depth / 40
    -- print(data.eyes_depth + 0)
    if data.eyes_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[20], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.eyes_angle / 40
    -- print(data.eyes_angle + 0)
    if data.eyes_angle == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[21], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.eyes_distance / 40
    -- print(data.eyes_distance + 0)
    if data.eyes_distance == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[22], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nose_width / 40
    -- print(data.nose_width + 0)
    if data.nose_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[23], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nose_size / 40
    if data.nose_size == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[24], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nose_height / 40
    -- print(data.nose_height + 0)
    if data.nose_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[25], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nose_angle / 40
    -- print(data.nose_angle + 0)
    if data.nose_angle == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[26], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nose_curvature / 40
    -- print(data.nose_curvature + 0)
    if data.nose_curvature == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[27], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.nostrils_distance / 40
    -- print(data.nostrils_distance + 0)
    if data.nostrils_distance == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[28], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.mouth_width / 40
    -- print(data.mouth_width + 0)
    if data.mouth_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[29], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.mouth_depth / 40
    -- print(data.mouth_depth + 0)
    if data.mouth_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[30], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.mouth_x_pos / 40
    -- print(data.mouth_x_pos + 0)
    if data.mouth_x_pos == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[31], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.mouth_y_pos / 40
    -- print(data.mouth_y_pos + 0)
    if data.mouth_y_pos == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[32], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.upper_lip_height / 30
    -- print(data.upper_lip_height + 0)
    if data.upper_lip_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[33], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

    local value = data.upper_lip_width / 30
    -- print(data.upper_lip_width + 0)
    if data.upper_lip_width == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[34], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.upper_lip_depth / 30
    -- print(data.upper_lip_depth + 0)
    if data.upper_lip_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[35], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.lower_lip_height / 30
    -- print(data.lower_lip_height + 0)
    if data.lower_lip_height == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[36], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.lower_lip_width  / 30
    -- print(data.lower_lip_width  + 0)
    if data.lower_lip_width  == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[37], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    local value = data.lower_lip_depth / 30
    if data.lower_lip_depth == 1/50 then value = 1 end
    Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[38], value)
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    visibility = 0
    for k, v in pairs(data) do 
      print(k, ":", v)
    end
    if tonumber(data.velhice) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("ageing",visibility,tonumber(data.velhice),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadevelhice/100), PlayerPedId())
    if tonumber(data.cicatriz) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("scars",visibility,tonumber(data.cicatriz),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadecicatriz/100), PlayerPedId())
    if tonumber(data.sardas) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("freckles",visibility,tonumber(data.sardas),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadesardas/100), PlayerPedId())
    if tonumber(data.toupeiras) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("moles",visibility,tonumber(data.toupeiras),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(100/100), PlayerPedId())
    if tonumber(data.sobrancelha) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    print(json.encode(data))
    toggleOverlayChange("eyebrows",visibility,tonumber(data.sobrancelha),0,0,0,1.0,0,tonumber(data.palhetasobrancelha),0,0,0,tonumber(0), tonumber(data.sobrancelhaopacidade/100) , PlayerPedId())
    DefaultCharacterData.altura = data.altura
    Wait(1000)
    if not uid then TriggerEvent("loadMakeup") end
    face = data.Rosto
    print(face, " << Deve ser 6")
    if data.face == 6 then print "test passed" else print "test fail!" end
    local twarz = '0x' .. maleheads[tonumber(face)]
    local twarz2 = '0x' .. femaleheads[tonumber(face)]
    if IsPedMale(PlayerPedId()) then
      ---- print (face)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    else
      ---- print (face)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz2), false, true, true)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end
    if tonumber(data.velhice) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("ageing",visibility,tonumber(data.velhice),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadevelhice/100), PlayerPedId())
    if tonumber(data.cicatriz) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("scars",visibility,tonumber(data.cicatriz),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadecicatriz/100), PlayerPedId())
    -- visibility = 0
    if tonumber(data.sardas) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("freckles",visibility,tonumber(data.sardas),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadesardas/100), PlayerPedId())
    -- visibility = 0
    if tonumber(data.toupeiras) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    toggleOverlayChange("moles",visibility,tonumber(data.toupeiras),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(100/100), PlayerPedId())
    -- visibility = 0
    if tonumber(data.sobrancelha) >0 then
      visibility = 1
    else 
      visibility = 0 
    end
    print(json.encode(data))
    toggleOverlayChange("eyebrows",visibility,tonumber(data.sobrancelha),0,0,0,1.0,0,tonumber(data.palhetasobrancelha),0,0,0,tonumber(0), tonumber(data.sobrancelhaopacidade/100) , PlayerPedId())
    DefaultCharacterData.altura = data.altura
  end

  RegisterNetEvent("__OVERLAYS__")
  AddEventHandler("__OVERLAYS__", function()
    local data = DefaultCharacterData;
    toggleOverlayChange("ageing",visibility,tonumber(data.velhice),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadevelhice/100), PlayerPedId())
    visibility = 0
    if tonumber(data.cicatriz) >0 then
      visibility = 1
    end
    toggleOverlayChange("scars",visibility,tonumber(data.cicatriz),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadecicatriz/100), PlayerPedId())
    visibility = 0
    if tonumber(data.sardas) >0 then
      visibility = 1
    end
    toggleOverlayChange("freckles",visibility,tonumber(data.sardas),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadesardas/100), PlayerPedId())
    visibility = 0
    if tonumber(data.toupeiras) >0 then
      visibility = 1
    end
    toggleOverlayChange("moles",visibility,tonumber(data.toupeiras),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(100/100), PlayerPedId())
    visibility = 0
    if tonumber(data.sobrancelha) >0 then
      visibility = 1
    end
    print(json.encode(data))
    toggleOverlayChange("eyebrows",visibility,tonumber(data.sobrancelha),0,0,0,1.0,0,tonumber(data.palhetasobrancelha),0,0,0,tonumber(0), tonumber(data.sobrancelhaopacidade/100) , PlayerPedId())
  end)

  --------------------------------------------------------------------
  -- Objetos Assincronos <> --
  --------------------------------------------------------------------
  Citizen.CreateThread(
  function()
    while adding do
      Citizen.Wait(0)
      ---- print("Dzieje sie")
      for i, v in ipairs(MaleComp) do
        -- print('ADICIONANDO 1')
        if v.category == 'heads' then
          table.insert(maleheads, v.Hash)
        elseif v.category == 'torsos' then
          table.insert(maletorsos, v.Hash)
        elseif v.category == 'legs' then
          table.insert(malelegs, v.Hash)
        elseif v.category == 'eyes' then
          table.insert(maleeyes, v.Hash)
        elseif v.category == 'hair' then
          table.insert(malehairs, v.Hash)
        elseif v.category == 'mustache' then
          table.insert(mustache, v.Hash)
        else
        end
      end
      -- print('Adicionado 1', json.encode(maleheads))
      adding = false
    end
  end
  )

  Citizen.CreateThread(
  function()
    while adding2 do
      Citizen.Wait(0)
      -- print('ADICIONANDO 2')
      ---- print("Dzieje sie 2")
      for i, v in ipairs(FemaleComp) do
        if v.category == 'heads' then
          table.insert(femaleheads, v.Hash)
        elseif v.category == 'torsos' then
          table.insert(femaletorsos, v.Hash)
        elseif v.category == 'legs' then
          table.insert(femalelegs, v.Hash)
        elseif v.category == 'eyes' then
          table.insert(femaleeyes, v.Hash)
        elseif v.category == 'hair' then
          table.insert(femalehairs, v.Hash)
        else
        end
      end
      -- print('Adicionado 2')
      adding2 = false
    end
  end
  )

  --------------------------------------------------------------------
  -- Front End Testing <> --
  --------------------------------------------------------------------


  --------------------------------------------------------------------
  -- NUI CallBacks <> --
  --------------------------------------------------------------------

  RegisterNUICallback(
  'Changes',
  function(data)
    inCriacao = true
    print(json.encode(data))
    if data.camera == "Orelha" then
      camera(0.9,0.6)
    elseif data.camera == "Olhos" then
      camera(0.9,0.6)
    elseif data.camera == "Nariz" then
      camera(0.9,0.6)
    elseif data.camera == "Queixo" then
      camera(0.9,0.6)
    elseif data.camera == "Bochecha" then
      camera(0.9,0.6)
    elseif data.camera == "Labios" then
      camera(0.9,0.6)
    elseif data.camera == "Boca" then
      camera(0.9,0.6)
    elseif data.camera == "Pele" then
      camera(2.8,-0.15)
    elseif data.camera == "Corpo" then
      camera(2.8,-0.15)
    elseif data.camera == "Cabelo" then
      camera(0.9,0.6)
    elseif data.camera == "Barba" then
      camera(0.9,0.6)
    elseif data.camera == "Sobrancelha" then
      camera(0.9,0.6)
    elseif data.camera == "Marcas na Pele" then
      camera(0.9,0.6)
    elseif data.camera == "Torso" then
      camera(2.8,-0.15)
    elseif data.camera == "Cabeça" then
      camera(0.9,0.6)
    end

    print(json.encode(data))


    if data.mudandoGenero then
      plec = 1
      if data.gender == "mp_female" then
        plec = 2
      end

      local model = 'mp_male'
      DefaultCharacterData.gender = data.gender
      local player = PlayerId()
      if plec == 1 then
        model = 'mp_male'
        sex = 1
      elseif plec == 2 then
        model = 'mp_female'
        sex = 2
      end
      local model2 = GetHashKey(model)
      while not HasModelLoaded(model2) do
        Wait(500)
        RequestModel(model2)
      end
      Citizen.InvokeNative(0xED40380076A31506, PlayerId(), model2)
      Citizen.InvokeNative(0x77FF8D35EEC6BBC4, PlayerPedId(), 0, 0) -- SetPedOutfitPreset

      while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId()) do -- wait till outfit fully loaded
        Citizen.Wait(0)
      end
      if IsPedMale(PlayerPedId()) then
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. maletorsos[1]),
        false,
        true,
        true
        )
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. malelegs[1]),
        false,
        true,
        true
        )
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. maleheads[1]),
        false,
        true,
        true
        )
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
      else
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. femaletorsos[1]),
        false,
        true,
        true
        )
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. femalelegs[1]),
        false,
        true,
        true
        )
        Citizen.InvokeNative(
        0xD3A7B003ED343FD9,
        PlayerPedId(),
        tonumber('0x' .. femaleheads[1]),
        false,
        true,
        true
        )
      end
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
    end 
     
     local visi = 1
    if data.MudandoCorpo then
      skin = data.CorPele
      DefaultCharacterData.CorPele = data.CorPele
      local torso = '0x' .. maletorsos[1]
      local legs = '0x' .. malelegs[1]
      local head = '0x' .. maleheads[1]
      texture_types['male'].albedo = GetHashKey('mp_head_mr1_sc08_c0_000_ab')
      if IsPedMale(PlayerPedId()) then
        -- print("macho")
        -- print('test skory')
        if tonumber(data.CorPele) == 1 then
          torso = '0x' .. maletorsos[1]
          legs = '0x' .. malelegs[1]
          head = '0x' .. maleheads[1]
          texture_types['male'].albedo = GetHashKey('mp_head_mr1_sc08_c0_000_ab')
        elseif tonumber(data.CorPele) == 2 then
          torso = '0x' .. maletorsos[10]
          legs = '0x' .. malelegs[10]
          head = '0x' .. maleheads[10]
          texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc03_c0_000_ab')
        elseif tonumber(data.CorPele) == 3 then
          torso = '0x' .. maletorsos[3]
          legs = '0x' .. malelegs[3]
          head = '0x' .. maleheads[3]
          texture_types['male'].albedo = GetHashKey('head_mr1_sc02_rough_c0_002_ab')
        elseif tonumber(data.CorPele) == 4 then
          torso = '0x' .. maletorsos[11]
          legs = '0x' .. malelegs[11]
          head = '0x' .. maleheads[11]
          texture_types['male'].albedo = GetHashKey('head_mr1_sc04_rough_c0_002_ab')
        elseif tonumber(data.CorPele) == 5 then
          torso = '0x' .. maletorsos[8]
          legs = '0x' .. malelegs[8]
          head = '0x' .. maleheads[8]
          texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc01_c0_000_ab')
        elseif tonumber(data.CorPele) == 6 then
          torso = '0x' .. maletorsos[30]
          legs = '0x' .. malelegs[30]
          head = '0x' .. maleheads[30]
          texture_types['male'].albedo = GetHashKey('MP_head_mr1_sc05_c0_000_ab')
        else
          Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end

        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso), false, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs), false, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(head), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        local torso2 = '0x' .. femaletorsos[1]
        local legs2 = '0x' .. femalelegs[1]
        local head2 = '0x' .. femalelegs[1]
        texture_types['female'].albedo = GetHashKey('mp_head_fr1_sc08_c0_000_ab')
        if tonumber(data.CorPele) == 1 then
          torso2 = '0x' .. femaletorsos[1]
          legs2 = '0x' .. femalelegs[1]
          head2 = '0x' .. femaleheads[1]
          texture_types['female'].albedo = GetHashKey('mp_head_fr1_sc08_c0_000_ab')
        elseif tonumber(data.CorPele) == 2 then
          torso2 = '0x' .. femaletorsos[10]
          legs2 = '0x' .. femalelegs[10]
          head2 = '0x' .. femaleheads[10]
          texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc03_c0_000_ab')
        elseif tonumber(data.CorPele) == 3 then
          torso2 = '0x' .. femaletorsos[3]
          legs2 = '0x' .. femalelegs[3]
          head2 = '0x' .. femaleheads[3]
          texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc03_c0_000_ab')
        elseif tonumber(data.CorPele) == 4 then
          torso2 = '0x' .. femaletorsos[11]
          legs2 = '0x' .. femalelegs[11]
          head2 = '0x' .. femaleheads[11]
          texture_types['female'].albedo = GetHashKey('head_fr1_sc02_rough_c0_002_ab')
        elseif tonumber(data.CorPele) == 5 then
          torso2 = '0x' .. femaletorsos[8]
          legs2 = '0x' .. femalelegs[8]
          head2 = '0x' .. femaleheads[8]
          texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc01_c0_000_ab')
        elseif tonumber(data.CorPele) == 6 then
          torso2 = '0x' .. femaletorsos[30]
          legs2 = '0x' .. femalelegs[30]
          head2 = '0x' .. femaleheads[30]
          texture_types['female'].albedo = GetHashKey('MP_head_fr1_sc05_c0_000_ab')
        else
          Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end

        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso2), false, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs2), false, true, true)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(head2), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    end
    if data.MudandoOlho then
      print('olho')
      eye = data.CorOlhos
      DefaultCharacterData.CorOlhos = data.CorOlhos
      if IsPedMale(PlayerPedId()) then
        local oczy = '0x' .. maleeyes[tonumber(eye)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(oczy), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        local oczy2 = '0x' .. femaleeyes[tonumber(eye)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(oczy2), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    end

    if data.MudandoCabeca then
      face = data.Rosto
      DefaultCharacterData.Rosto = data.Rosto
      local twarz = '0x' .. maleheads[tonumber(face)]
      local twarz2 = '0x' .. femaleheads[tonumber(face)]
      if IsPedMale(PlayerPedId()) then
        ---- print (face)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        ---- print (face)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(twarz2), false, true, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    end
    if data.MudandoCorpo then

      local BODY_TYPES = {
        32611963,
        -20262001,
        -369348190,
        -1241887289,
        61606861
      }
      -- print('perfil:' .. data.Perfil, BODY_TYPES[tonumber(data.Perfil)])
      Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), BODY_TYPES[tonumber(data.Perfil)])
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      DefaultCharacterData.Perfil = data.Perfil
    end

    if data.MudandoCabelo then
      hair = data.CabeloModel
      DefaultCharacterData.CabeloModel = data.CabeloModel
      if tonumber(hair) > 1 then
        if IsPedMale(PlayerPedId()) then
          local wlosy = '0x' .. malehairs[tonumber(hair)]
          Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(wlosy), false, true, true)
          Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        else
          local wlosy2 = '0x' .. femalehairs[tonumber(hair)]
          Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(wlosy2), false, true, true)
          Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        end
      else
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x864B03AE, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      end
    end
    if data.MudandoBarba then
      beard = data.Barba
      DefaultCharacterData.Barba = data.Barba
      -- SetCharacter(DefaultCharacterData)
      print(data.Barba)
      if tonumber(data.Barba) == tonumber(-1) then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), false, false, true, true)
        SetCharacter(DefaultCharacterData)
        return
      end
      if IsPedMale(PlayerPedId()) then
        local broda = '0x' .. mustache[tonumber(beard)]
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(broda), false, true, true)
        -- end
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
      else
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xF8016BCA, 0) -- Set target category, here the hash is for hats
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)

      end
    end

    local features = {
      0x84D6,
      0x3303,
      0x2FF9,
      0x4AD1,
      0xC04F,
      0xB6CE,
      0x2844,
      0xED30,
      0x6A0B,
      0xABCF,
      0x358D,
      0x8D0A,
      0xEBAE,
      0x1DF6,
      0x3C0F,
      0xC3B2,
      0xE323,
      0x8B2B,
      0x1B6B,
      0xEE44,
      0xD266,
      0xA54E,
      0x6E7F,
      0x3471,
      0x03F5,
      0x34B1,
      0xF156,
      0x561E,
      0xF065,
      0xAA69,
      0x7AC3,
      0x1A00,
      0x91C1,
      0xC375,
      0xBB4D,
      0xB0B0,
      0x5D16
    }

    if data.MudandoCabeca then
      DefaultCharacterData.face_width = data.face_width
      local value = data.face_width + 0.001
      -- print(data.face_width + 0)
      if data.face_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[1], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end
    if data.MudandoSobrancelha then
      DefaultCharacterData.eyebrow_height = data.eyebrow_height
      local value = data.eyebrow_height / 40
      -- print(data.eyebrow_height + 0)
      if data.eyebrow_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[2], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoSobrancelha then
      DefaultCharacterData.eyebrow_width = data.eyebrow_width
      local value = data.eyebrow_width / 40
      -- print(data.eyebrow_width + 0)
      if data.eyebrow_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[3], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoSobrancelha then
      DefaultCharacterData.eyebrow_depth = data.eyebrow_depth
      local value = data.eyebrow_depth / 50
      -- print(data.eyebrow_depth + 0)
      if data.eyebrow_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[4], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOrelha then
      DefaultCharacterData.ears_width = data.ears_width
      local value = data.ears_width  / 20
      -- print(data.ears_width  + 0)
      if data.ears_width  == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[5], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end
    if data.MudandoOrelha then
      DefaultCharacterData.ears_angle = data.ears_angle
      local value = data.ears_angle  / 20
      -- print(data.ears_angle  + 0)
      if data.ears_angle  == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[6], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOrelha then
      DefaultCharacterData.MudandoOrelha = data.MudandoOrelha
      local value = data.ears_height / 20
      -- print(data.ears_height + 0)
      if data.ears_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[7], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOrelha then
      DefaultCharacterData.earlobe_size = data.earlobe_size
      local value = data.earlobe_size  / 20
      -- print(data.earlobe_size  + 0)
      if data.earlobe_size  == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[8], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end


    if data.MudandoBochecha then
      DefaultCharacterData.cheekbones_height = data.cheekbones_height
      local value = data.cheekbones_height / 40
      -- print(data.cheekbones_height + 0)
      if data.cheekbones_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[9], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoBochecha then
      DefaultCharacterData.cheekbones_width = data.cheekbones_width
      local value = data.cheekbones_width / 40
      -- print(data.cheekbones_width + 0)
      if data.cheekbones_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[10], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoBochecha then
      local value = data.cheekbones_depth / 50
      -- print(data.cheekbones_depth + 0)
      if data.cheekbones_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[11], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.jaw_height = data.jaw_height
      local value = data.jaw_height / 40
      -- print(data.jaw_height + 0)
      if data.jaw_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[12], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.jaw_width = data.jaw_width
      local value = data.jaw_width / 40
      -- print(data.jaw_width + 0)
      if data.jaw_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[13], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.jaw_depth = data.jaw_depth
      local value = data.jaw_depth  / 40
      -- print(data.jaw_depth  + 0)
      if data.jaw_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[14], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.chin_height = data.chin_height
      local value = data.chin_height / 40
      -- print(data.chin_height + 0)
      if data.chin_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[15], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.chin_width = data.chin_width
      local value = data.chin_width / 40
      -- print(data.chin_width + 0)
      if data.chin_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[16], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoQueixo then
      DefaultCharacterData.chin_depth = data.chin_depth
      local value = data.chin_depth / 40
      -- print(data.chin_depth + 0)
      if data.chin_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[17], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOlho then
      DefaultCharacterData.eyelid_height = data.eyelid_height
      local value = data.eyelid_height / 40
      -- print(data.eyelid_height + 0)
      if data.eyelid_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[18], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOlho then
      DefaultCharacterData.eyelid_width = data.eyelid_width
      local value = data.eyelid_width / 40
      -- print(data.eyelid_width + 0)
      if data.eyelid_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[19], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOlho then
      DefaultCharacterData.eyes_depth = data.eyes_depth
      local value = data.eyes_depth / 40
      -- print(data.eyes_depth + 0)
      if data.eyes_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[20], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOlho then
      DefaultCharacterData.eyes_angle = data.eyes_angle
      local value = data.eyes_angle / 40
      -- print(data.eyes_angle + 0)
      if data.eyes_angle == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[21], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoOlho then
      DefaultCharacterData.eyes_distance = data.eyes_distance
      local value = data.eyes_distance / 40
      -- print(data.eyes_distance + 0)
      if data.eyes_distance == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[22], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    -- Nariz
    if data.MudandoNariz then
      DefaultCharacterData.nose_width = data.nose_width
      local value = data.nose_width / 40
      -- print(data.nose_width + 0)
      if data.nose_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[23], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoNariz then
      DefaultCharacterData.nose_size = data.nose_size
      local value = data.nose_size / 40

      -- print(data.nose_size + 0)
      if data.nose_size == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[24], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoNariz then
      DefaultCharacterData.nose_height = data.nose_height
      local value = data.nose_height / 40
      -- print(data.nose_height + 0)
      if data.nose_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[25], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoNariz then
      DefaultCharacterData.nose_angle = data.nose_angle
      local value = data.nose_angle / 40
      -- print(data.nose_angle + 0)
      if data.nose_angle == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[26], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoNariz then
      DefaultCharacterData.nose_curvature = data.nose_curvature
      local value = data.nose_curvature / 40
      -- print(data.nose_curvature + 0)
      if data.nose_curvature == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[27], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoNariz then
      DefaultCharacterData.nostrils_distance = data.nostrils_distance
      local value = data.nostrils_distance / 40
      -- print(data.nostrils_distance + 0)
      if data.nostrils_distance == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[28], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    -- Boca

    if data.MudandoBoca then
      DefaultCharacterData.mouth_width = data.mouth_width
      local value = data.mouth_width / 40
      -- print(data.mouth_width + 0)
      if data.mouth_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[29], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoBoca then
      DefaultCharacterData.mouth_depth = data.mouth_depth
      local value = data.mouth_depth / 40
      -- print(data.mouth_depth + 0)
      if data.mouth_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[30], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoBoca then
      DefaultCharacterData.mouth_x_pos = data.mouth_x_pos
      local value = data.mouth_x_pos / 40
      -- print(data.mouth_x_pos + 0)
      if data.mouth_x_pos == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[31], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoBoca then
      DefaultCharacterData.mouth_y_pos = data.mouth_y_pos
      local value = data.mouth_y_pos / 40
      -- print(data.mouth_y_pos + 0)
      if data.mouth_y_pos == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[32], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    -- lábios


    if data.MudandoLabios then
      DefaultCharacterData.upper_lip_height = data.upper_lip_height
      local value = data.upper_lip_height / 30
      -- print(data.upper_lip_height + 0)
      if data.upper_lip_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[33], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoLabios then
      DefaultCharacterData.upper_lip_width = data.upper_lip_width
      local value = data.upper_lip_width / 30
      -- print(data.upper_lip_width + 0)
      if data.upper_lip_width == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[34], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoLabios then
      DefaultCharacterData.upper_lip_depth = data.upper_lip_depth
      local value = data.upper_lip_depth / 30
      -- print(data.upper_lip_depth + 0)
      if data.upper_lip_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[35], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoLabios then
      DefaultCharacterData.lower_lip_height = data.lower_lip_height
      local value = data.lower_lip_height / 30
      -- print(data.lower_lip_height + 0)
      if data.lower_lip_height == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[36], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoLabios then
      DefaultCharacterData.lower_lip_width = data.lower_lip_width
      local value = data.lower_lip_width  / 30
      -- print(data.lower_lip_width  + 0)
      if data.lower_lip_width  == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[37], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.MudandoLabios then
      DefaultCharacterData.lower_lip_depth = data.lower_lip_depth
      local value = data.lower_lip_depth / 30
      -- print(data.lower_lip_depth + 0)
      if data.lower_lip_depth == 1/50 then value = 1 end
      Citizen.InvokeNative(0x5653AB26C82938CF, PlayerPedId(), features[38], value)
      Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end

    if data.Marcas then
      DefaultCharacterData.velhice = data.velhice
      DefaultCharacterData.opacidadevelhice = data.opacidadevelhice
      visibility = 0
      if tonumber(data.velhice) >0 then
        visibility = 1
      end
      toggleOverlayChange("ageing",visibility,tonumber(data.velhice),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadevelhice/100), PlayerPedId())
    end

    if data.Marcas then
      DefaultCharacterData.cicatriz = data.cicatriz
      DefaultCharacterData.opacidadecicatriz = data.opacidadecicatriz
      visibility = 0
      if tonumber(data.cicatriz) >0 then
        visibility = 1
      end
      toggleOverlayChange("scars",visibility,tonumber(data.cicatriz),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadecicatriz/100), PlayerPedId())
    end

    if data.Marcas then
      DefaultCharacterData.sardas = data.sardas
      DefaultCharacterData.opacidadesardas = data.opacidadesardas
      visibility = 0
      if tonumber(data.sardas) >0 then
        visibility = 1
      end
      toggleOverlayChange("freckles",visibility,tonumber(data.sardas),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(data.opacidadesardas/100), PlayerPedId())
    end

    if data.Marcas then
      DefaultCharacterData.toupeiras = data.toupeiras
      visibility = 0
      if tonumber(data.toupeiras) >0 then
        visibility = 1
      end
      toggleOverlayChange("moles",visibility,tonumber(data.toupeiras),0,0,1,1.0,0,tonumber(0),0,0,0,tonumber(0), tonumber(100/100), PlayerPedId())
    end


    if data.MudandoSobrancelha then

      visibility = 0
      if tonumber(data.sobrancelha) >0 then
        visibility = 1
      end
      print(json.encode(data))
      toggleOverlayChange("eyebrows",visibility,tonumber(data.sobrancelha),0,0,0,1.0,0,tonumber(data.palhetasobrancelha),0,0,0,tonumber(0), tonumber(data.sobrancelhaopacidade/100) , PlayerPedId())
      DefaultCharacterData.sobrancelha = data.sobrancelha
      DefaultCharacterData.palhetasobrancelha = data.palhetasobrancelha
      DefaultCharacterData.sobrancelhaopacidade = data.sobrancelhaopacidade
    end
    if data.MudandoCorpo then
      DefaultCharacterData.altura = Alturas[tonumber(data.Altura)]
    end
  end)
  RegisterNUICallback(
  'rotate',
  function(data)
    local playerPed = PlayerPedId()
    -- print(data.key)
    if data.key == 'left' then
      headingss = headingss + 10
    else
      headingss = headingss - 10
    end
    SetEntityHeading(playerPed, headingss)
  end
  )

  RegisterNUICallback('FinishedCreator', function(finishData, playerID)
  --k(PlayerPedId(),false)
  DoScreenFadeOut(500)
  Instance(false)
  local idade = tonumber(finishData.age)
  local nome  = finishData.charName
  local character = json.encode(DefaultCharacterData)
  SetNuiFocus(false, false)
  inCriacao = false
  SendNUIMessage({action = 'closeCreator'})
  DisplayHud(true)
  DisplayRadar(true)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
  MultiCharacter._sendCharacterMode(character, user_id, nome, idade)
  SetNuiFocus(false, false)
  inCriacao = false
  SendNUIMessage({action = 'closeCreator'})
  DisplayHud(true)
  DisplayRadar(true)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
  boolean = false
  Wait(2500)
  DoScreenFadeIn(1000)
  local def;
  if IsPedMale(PlayerPedId()) then 
    def = m_default;
  else 
    def = f_default 
  end
    ClothingServer.setClothes(json.encode(def))
    TriggerEvent("incriacaostatuts", false)
    Wait(500)
    TriggerEvent("load::Clothes")
  end)

  local modoReset = false 
  Citizen.CreateThread(function()
  --k(PlayerPedId(),true)
  Instance(true)
  while true do
    DeveEsperar = 5000
    if GetEntityModel(PlayerPedId()) == -171876066 or GetEntityModel(PlayerPedId()) == -1481695040 then 
      local DeveEsperar = false 
      if inCriacao == true then 
        DeveEsperar = 0  
      elseif inCriacao == false then  
        DeveEsperar = 5000 
      end
      if modoReset then 
        DeveEsperar = 500 
      end
      local altura = DefaultCharacterData.altura
      Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), tonumber(altura))
      Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
    end
    Citizen.Wait(DeveEsperar)
  end
  end )
  CreateNewEvent("Camera-RR", function()
  Wait(2500)
  camera(0.9,0.6)
  end)

  function _Tunnel.CriarPersonagem(user_id1)
    print(user_id1)
    DoScreenFadeOut(500)
    Instance(true)
    teleportPlayerToStart()
    SetCharacter(DefaultCharacterData, tonumber(user_id1))
    camera(0.9,0.6)
    TriggerEvent("Camera-RR")
    Wait(500)
    DoScreenFadeIn(500)
    SendNUIMessage({action = 'showCreator'})
    SetNuiFocus(true, true)
  end
  function _Tunnel.CriarPersonagem_2(user_id1)
    print(user_id1)
    DoScreenFadeOut(500)
    Instance(true)
    teleportPlayerToStart()
    modoReset = true 
    SetCharacter({  gender = "mp_male", CorPele = 2, CorOlhos = 2, Rosto = 1, Perfil = 1, CabeloModel = -1,
    Barba = -1, face_width = 1, eyebrow_height = 1, eyebrow_width = 1, eyebrow_depth = 1,
    ears_width = 1, ears_angle = 1, ears_height = 1, earlobe_size = 1, cheekbones_height =1,
    cheekbones_width = 1, cheekbones_depth = 1, jaw_height = 1, jaw_width = 1, jaw_depth = 1,
    chin_height = 1, chin_width = 1, chin_depth = 1, eyelid_height = 1, eyelid_width = 1,
    eyes_depth = 1, eyes_angle = 1, eyes_distance = 1, nose_width = 1, nose_size = 1,
    nose_height = 1, nose_angle = 1, nose_curvature = 1, nostrils_distance = 1, mouth_width = 1,
    mouth_depth = 1, mouth_x_pos = 1, mouth_y_pos = 1, upper_lip_height = 1, upper_lip_width = 1,
    upper_lip_depth = 1, lower_lip_height = 1, lower_lip_width = 1, lower_lip_depth = 1, velhice = -1,
    opacidadevelhice = 1, cicatriz = -1, opacidadecicatriz = 1, sardas = -1, opacidadesardas = 1,
    toupeiras = -1, sobrancelha = -1, palhetasobrancelha = 1, sobrancelhaopacidade = 1, altura = 1.1,
    delineados = 1, palhetadelineados = 1, opacidadedelineados = 1, sombras = 1, palhetasombras = 1, 
    opacidadesombras = 1, batom = 1, palhetabatom =1, opacidadebatom = 1, blush = 1, opacidadeblush = 1,
    palhetablush = 1 }, tonumber(user_id1))
    camera(0.9,0.6)
    TriggerEvent("Camera-RR")
    Wait(500)
    DoScreenFadeIn(500)
    SendNUIMessage({action = 'showCreator'})
    SetNuiFocus(true, true)
  end
  function _Tunnel.SetPersonagem(personagem)
    print(personagem)
    if not personagem or personagem == "" or personagem == nil or personagem == "null" then 
      personagem = {  gender = "mp_male", CorPele = 2, CorOlhos = 2, Rosto = 1, Perfil = 1, CabeloModel = -1,
      Barba = -1, face_width = 1, eyebrow_height = 1, eyebrow_width = 1, eyebrow_depth = 1,
      ears_width = 1, ears_angle = 1, ears_height = 1, earlobe_size = 1, cheekbones_height =1,
      cheekbones_width = 1, cheekbones_depth = 1, jaw_height = 1, jaw_width = 1, jaw_depth = 1,
      chin_height = 1, chin_width = 1, chin_depth = 1, eyelid_height = 1, eyelid_width = 1,
      eyes_depth = 1, eyes_angle = 1, eyes_distance = 1, nose_width = 1, nose_size = 1,
      nose_height = 1, nose_angle = 1, nose_curvature = 1, nostrils_distance = 1, mouth_width = 1,
      mouth_depth = 1, mouth_x_pos = 1, mouth_y_pos = 1, upper_lip_height = 1, upper_lip_width = 1,
      upper_lip_depth = 1, lower_lip_height = 1, lower_lip_width = 1, lower_lip_depth = 1, velhice = -1,
      opacidadevelhice = 1, cicatriz = -1, opacidadecicatriz = 1, sardas = -1, opacidadesardas = 1,
      toupeiras = -1, sobrancelha = -1, palhetasobrancelha = 1, sobrancelhaopacidade = 1, altura = 1.1,
      delineados = 1, palhetadelineados = 1, opacidadedelineados = 1, sombras = 1, palhetasombras = 1, 
      opacidadesombras = 1, batom = 1, palhetabatom =1, opacidadebatom = 1, blush = 1, opacidadeblush = 1,
      palhetablush = 1 }
      print "Não há dados de personagem para o seu player... peça um reset se quiser."
    end
    Instance(false)
    local _Cache = DefaultCharacterData
    if not personagem or personagem == "" or personagem == nil or personagem == "null" then 
      DefaultCharacterData = { gender = "mp_male", CorPele = 2, CorOlhos = 2, Rosto = 1, Perfil = 1, CabeloModel = -1,
      Barba = -1, face_width = 1, eyebrow_height = 1, eyebrow_width = 1, eyebrow_depth = 1,
      ears_width = 1, ears_angle = 1, ears_height = 1, earlobe_size = 1, cheekbones_height =1,
      cheekbones_width = 1, cheekbones_depth = 1, jaw_height = 1, jaw_width = 1, jaw_depth = 1,
      chin_height = 1, chin_width = 1, chin_depth = 1, eyelid_height = 1, eyelid_width = 1,
      eyes_depth = 1, eyes_angle = 1, eyes_distance = 1, nose_width = 1, nose_size = 1,
      nose_height = 1, nose_angle = 1, nose_curvature = 1, nostrils_distance = 1, mouth_width = 1,
      mouth_depth = 1, mouth_x_pos = 1, mouth_y_pos = 1, upper_lip_height = 1, upper_lip_width = 1,
      upper_lip_depth = 1, lower_lip_height = 1, lower_lip_width = 1, lower_lip_depth = 1, velhice = -1,
      opacidadevelhice = 1, cicatriz = -1, opacidadecicatriz = 1, sardas = -1, opacidadesardas = 1,
      toupeiras = -1, sobrancelha = -1, palhetasobrancelha = 1, sobrancelhaopacidade = 1, altura = 1.1,
      delineados = 1, palhetadelineados = 1, opacidadedelineados = 1, sombras = 1, palhetasombras = 1, 
      opacidadesombras = 1, batom = 1, palhetabatom =1, opacidadebatom = 1, blush = 1, opacidadeblush = 1,
      palhetablush = 1

      }
    else
    DefaultCharacterData = personagem
    end
    if not personagem or personagem == "" or personagem == nil or personagem == "null" then 
      boolean = false
      _Cache = false
      return true
    else 
    while DefaultCharacterData == _Cache do Wait(0) end
      boolean = false
      _Cache = false
      return true
    end
  end
    function _Tunnel.LoadPersonagem()
      --k(PlayerPedId(),false)
      Instance(false)
      boolean = false
      SetCharacter(DefaultCharacterData, nil)
    end
    RegisterNetEvent("Character:Reload")
    AddEventHandler("Character:Reload", function()
      SetCharacter(DefaultCharacterData, nil)
    end)

