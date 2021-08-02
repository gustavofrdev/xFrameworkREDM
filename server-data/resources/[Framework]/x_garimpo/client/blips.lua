-- created by RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
-- youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA

---------------- add blips to your map
local blips = {

	-- add gold panning/mining blips to map
	{ name = 'Área do Garimpo', sprite = -1289383059, x= -470.84, y = 1013.52, z = 87.88 }, -- gold panning 1
	{ name = 'Área do Garimpo', sprite = -1289383059, x= -1638.22, y = -1081.3, z = 66.1 }, -- gold panning 2
	{ name = 'Área do Garimpo', sprite = -1289383059, x= -2573.9, y = 923.53, z = 165.98 }, -- gold panning 3
	-- { name = 'Smelt Gold', sprite = 1754365229, x= -359.7, y = 747.73, z = 116.42 }, -- smelt nuggets into gold bars
	-- { name = 'Fence', sprite = -1179229323, x= 2859.27, y = -1200.64, z = 49.59 }, -- fence saint denis / sell bars of gold
	-- you can add more if you need!
}

-- do not touch code below
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)