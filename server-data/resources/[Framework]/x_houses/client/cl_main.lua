--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("x_houses")
FrameworkSV = Tunnel.getInterface("x_houses")
MultiCharacter = Tunnel.getInterface("x_houses")
__Casas__ = Tunnel.getInterface("x_houses")
--------------------------------------------------------
_Tunnel = {}
Tunnel.bindInterface("x_houses", _Tunnel)

local HouseBlips = {}

Citizen.CreateThread(function()
    Wait(2000)
    CreateHouseprompt()
	CreateWarderobeprompt()
    FrameworkSV.CheckHouses()

end)

RegisterCommand("homes", function()
    FrameworkSV.CheckHouses('test')
end )
function _Tunnel.PutBoughtHouses(bhouses)

 if bhouses ~= nil then
    for b, g in pairs (Config.Houses) do
        for h, j in pairs (bhouses) do
            if g.number == j then
                g.owned = true
                RemoveBlip(HouseBlips[g.number])
            end
        end
    end
	end
end

function _Tunnel.SetBlips(bhouses)
 if bhouses ~= nil then
    for b, g in pairs (Config.Houses) do
        for h, j in pairs (bhouses) do
            if g.number == j then
                g.owned = true
            end
        end
    end
	end
	 for k,v in pairs (Config.Houses) do
        if not v.owned then
            HouseBlips[v.number] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(HouseBlips[v.number], 444204045)
            SetBlipScale(HouseBlips[v.number], 0.3)
            Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlips[v.number], Config.BlipName)
            -->("tem dono::", v.owned)
        else
            -->("minha casa ", tonumber(__Casas__.myHouse()))
            if __Casas__.myHouse() and tonumber(__Casas__.myHouse()) == v.number then
                HouseBlips[v.number] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.pos.x, v.pos.y, v.pos.z)
                SetBlipSprite(HouseBlips[v.number], 444204045)
                SetBlipScale(HouseBlips[v.number], 0.3)
                Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlips[v.number], "A SUA CASA")
                TriggerServerEvent("station:ShareStationServer", v.number, v.kitchen.x , v.kitchen.y ,v.kitchen.z , "kitchen")	  
            else
                TriggerServerEvent("station:ShareStationServer", v.number, v.kitchen.x , v.kitchen.y ,v.kitchen.z , "kitchen")	  
            end
        end
    end
    Wait(10000)
    for k,v in pairs (Config.Houses) do
        -->("removendo ", k, v  )
       RemoveBlip(HouseBlips[v.number]) 
    end
end

local Housegroup = GetRandomIntInRange(0, 0xffffff)
local Warderobegroup = GetRandomIntInRange(0, 0xffffff)
local buying = 0
local active = false
local active2 = false
local Houseprompt
function CreateHouseprompt()
    Citizen.CreateThread(function()
        local str = Config.BuyText
        Houseprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Houseprompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Houseprompt, str)
        PromptSetEnabled(Houseprompt, true)
        PromptSetVisible(Houseprompt, true)
        PromptSetHoldMode(Houseprompt, true)
        PromptSetGroup(Houseprompt, Housegroup)
        PromptRegisterEnd(Houseprompt)
    end)
end

local Warderobeprompt
function CreateWarderobeprompt()
    Citizen.CreateThread(function()
        local str = Config.WarderobeText
        Warderobeprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Warderobeprompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Warderobeprompt, str)
        PromptSetEnabled(Warderobeprompt, true)
        PromptSetVisible(Warderobeprompt, true)
        PromptSetHoldMode(Warderobeprompt, true)
        PromptSetGroup(Warderobeprompt, Warderobegroup)
        PromptRegisterEnd(Warderobeprompt)
    end)
end


local targetHouse
local targetWarderobe
Citizen.CreateThread(function()
    while true do
        Wait(0)
		local cansleep = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs (Config.Houses) do
            if not v.owned then
                local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, v.buy.x, v.buy.y, v.buy.z)
				if dist < 10 then
					cansleep = false
				end
                if dist < 2.0 then
				if not active then
                    local HouseGroupName  = CreateVarString(10, 'LITERAL_STRING', Config.BuyText2 .. " ~t4~" .. tostring(v.name) .. "~q~ " .. Config.BuyText3 .. " ~t6~" .. tostring(v.price) .. "~q~$")
                    PromptSetActiveGroupThisFrame(Housegroup, HouseGroupName) 
                    if PromptHasHoldModeCompleted(Houseprompt) then
                        active = true
						targetHouse = k
                        FrameworkSV.BuyHouse(v.price, v.number )
                    end
					end
					else
					if active == true and targetHouse == k then
						active = false		
						-- -->('test')
					end
                end
				else
				local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, v.kitchen.x, v.kitchen.y, v.kitchen.z)
				if dist < 10 then
					cansleep = false
				end
                if dist < 1.0 then
				if not active2 then
                    local WarderobeGroupName  = CreateVarString(10, 'LITERAL_STRING', Config.WarderobeText2)
                    PromptSetActiveGroupThisFrame(Warderobegroup, WarderobeGroupName) 
                    if PromptHasHoldModeCompleted(Warderobeprompt) then
                        active2 = true
						targetWarderobe = k
					local __v = GetEntityMaxHealth(PlayerPedId())
                        SetEntityHealth(PlayerPedId(),__v)
                        -- -->("?")
                    end
					end
					else
					if active2 == true and targetWarderobe == k then
						active2 = false		
						-- -->('test')
					end
                end
				
            end
        end
		if cansleep then
			Wait(1000)
		end
    end
end)

function _Tunnel.BoughtHouse(price, id)

    local pedCoords2 = GetEntityCoords(PlayerPedId())
    PlaySoundFrontend("Gain_Point", "HUD_MP_PITP", true, 1)
   -- exports.ak_notification.DisplayTip(0, tostring(Config.BoughtText .. ": ~t6~" .. price .. "$~q~"), tonumber(20000))
    TriggerEvent("xFrmework:Notify","sucesso","Você comrpou essa casa por " ..price)
    buying = 1
    Citizen.CreateThread(function()
        cameraBars()
        Wait(0)
        DoScreenFadeOut(1500)
        Wait(1500)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pedCoords2.x, pedCoords2.y, pedCoords2.z+25.0, 300.00,0.00,0.00, 70.00, false, 0)
		PointCamAtCoord(cam, pedCoords2.x, pedCoords2.y, pedCoords2.z)
		SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
        DoScreenFadeIn(1000)
        Wait(3500)
        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pedCoords2.x+15.0, pedCoords2.y+10.0, pedCoords2.z+10.0, 300.00,0.00,0.00, 70.00, false, 0)
        PointCamAtCoord(cam2, pedCoords2.x, pedCoords2.y, pedCoords2.z)
        SetCamActiveWithInterp(cam2, cam, 5000, true, true)
        Wait(6000)
        cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pedCoords2.x+15.0, pedCoords2.y-10.0, pedCoords2.z+10.0, 300.00,0.00,0.00, 70.00, false, 0)
        PointCamAtCoord(cam3, pedCoords2.x, pedCoords2.y, pedCoords2.z)
        SetCamActiveWithInterp(cam3, cam2, 5000, true, true)
        Wait(7500)
        DoScreenFadeOut(1500)
        Wait(1500)
        DestroyAllCams()
        DoScreenFadeIn(1000)
        buying = 0
    end)
    Citizen.CreateThread(function()
        for z,c in pairs(Config.Houses) do
            if c.number == id then
                c.owned = true
				TriggerServerEvent("station:ShareStationServer", c.number, c.kitchen.x , c.kitchen.y ,c.kitchen.z , "kitchen")	
            end
        end
	
        FrameworkSV.CheckHouses()
    end)

end


function cameraBars()
	Citizen.CreateThread(function()
		while buying == 1 do
			Wait(0)
			N_0xe296208c273bd7f0(-1, -1, 0, 17, 0, 0)
		end
	end)
end


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
while true do
    local W = 500  
    for k,v in pairs (Config.Houses) do
        if(v['bau']) and v.owned then
            if GetDistanceBetweenCoords(v['bau'][1] ,v['bau'][2],v['bau'][3], GetEntityCoords(PlayerPedId()), true) < 5 then
                W = 1
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, v['bau'][1] - 0.6,v['bau'][2],v['bau'][3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,40,0,155,0,0,2,0,0,0,0)
                if GetDistanceBetweenCoords(v['bau'][1] ,v['bau'][2],v['bau'][3], GetEntityCoords(PlayerPedId()), true) < 2.2 then
                    W = 1 
   
                    DrawText3D( v['bau'][1] ,v['bau'][2],v['bau'][3]-1, "Pressione ~e~[E]~p~ para abrir o baú de sua casa ")
                    if IsControlJustPressed(0, 0xCEFD9220)then 
                        __Casas__.AbrirBau(v['number'])
                    end
                    end
                end
            end
        end 
        Citizen.Wait(W)
    end
end)

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
