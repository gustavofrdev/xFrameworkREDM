local noclip = false
local velocidade     = 0.8
local noclip_ativado = false
function _Framework.ToggleNoclip()
  noclip_ativado = not noclip_ativado
    if noclip_ativado then
      SetEntityInvincible(PlayerPedId(), true)
      SetEntityVisible(PlayerPedId(), false, false)

    else
      SetEntityInvincible(PlayerPedId(), false)
      SetEntityVisible(PlayerPedId(), true, false)
    end
  end

  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)

    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end

    return x,y,z
  end
  function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
  end

  Citizen.CreateThread(function()
  while true do
    local sleep = 500
    if noclip_ativado then
      sleep = 0
      local ped = PlayerPedId()
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = velocidade
      local speedWithBonus = speed + 4
      if IsControlPressed(0, 0x8FFC75D6) then
        -- --('bonus speed')
        speed = speedWithBonus
      end
      if IsControlJustReleased(0, 0x8FFC75D6) then
        speed = velocidade
      end
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      if IsControlPressed(0, 0x8FD015D8) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end
      if IsControlPressed(0, 0xD27782E3) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end
      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
    Citizen.Wait(sleep)
  end
  end)