local TRAIN_HASHES = {
--    -1719006020 -- PASSENGER AND CARGO TRAIN [Carts - 10] -- [This one is pretty fast too]
    987516329 -- SMALLER PASSENGER TRAIN - [Carts - 6]
}

CURRENT_TRAIN = nil

local stops = {
    {["dst"] = 18.30, ["dst2"] = 4.0, ["x"] = -2508.27,  ["y"] = -2406.18,   ["z"] = 60.22, ["time"] = 60000, ["name"] = "Macfarlane's Station"},
    {["dst"] = 178.70, ["dst2"] = 4.0, ["x"] = -3749.28,  ["y"] = -2632.60, ["z"] = -13.86,  ["time"] = 60000, ["name"] = "Armadillo Station"},
	{["dst"] = 178.70, ["dst2"] = 4.0, ["x"] = -4373.65,  ["y"] = -3093.07, ["z"] = -10.05,  ["time"] = 60000, ["name"] = "Mercer Station"},
	{["dst"] = 172.32, ["dst2"] = 4.0, ["x"] = -5235.92,  ["y"] = -3488.70, ["z"] = -21.10,  ["time"] = 60000, ["name"] = "Benedict Station"},
 
} 

local trainspawned = false
-- RegisterCommand("sp", function()
-- TriggerEvent("Trainroute")
-- Wait(500)
-- SetEntityCoords(PlayerPedId(), GetEntityCoords(CURRENT_TRAIN))
-- end)
Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local game = NetworkIsGameInProgress()
        if game == 1 then
            TriggerServerEvent('train:playerActivated')
            return
        end
    end
end)

RegisterNetEvent('Trainroute')
AddEventHandler('Trainroute', function(n)
    DeleteAllTrains()
    SetRandomTrains(false) 

        --this is requestmodel--
    local n = math.random(#TRAIN_HASHES)
    local trainHash = TRAIN_HASHES[n]
    local trainWagons = N_0x635423d55ca84fc8(trainHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.InvokeNative(0xFA28FE3A6246FC30,trainWagonModel,1)
            Citizen.Wait(100)
        end
    end
    --spawn--
    local ped = PlayerPedId()
    local train = N_0xc239dbd9a57d2a71(trainHash, -27773.64, -2044.22, 76.77, 0, 1, 1, 1)
    local coords = GetEntityCoords(train)
    local trainV = vector3(coords.x, coords.y, coords.z)
    Citizen.InvokeNative(0xBA8818212633500A, train, 0, 1) -- this makes the train undrivable for players
         
    --blip--
    local blipname = "Trem"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname) -- SetBlipNameFromPlayerString (teste qualquer erro desligar)
    trainspawned = true
    CURRENT_TRAIN = train
    trainroute()
end)


function trainroute()
    while trainspawned == true do --this is the loop for the train to stop at stations
        for i = 1, #stops do
            local coords = GetEntityCoords(CURRENT_TRAIN)
            local trainV = vector3(coords.x, coords.y, coords.z)
            local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
    
            --speed--
            local stopspeed = 0.0
            local cruisespeed = 5.0
            local fullspeed = 10.0
            if distance < stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                Wait(200)
                if distance < stops[i]["dst2"] then
                    SetTrainCruiseSpeed(CURRENT_TRAIN, stopspeed)
                    Wait(stops[i]["time"])
                    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                    Wait(10000)
                end
            elseif distance > stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, fullspeed)
                Wait(25)
            end
        end
    end
end
