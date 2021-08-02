fnc  = {}

fnc.Spawn = function(name, x, y, z, heading)

        if not DoesEntityExist(ped) then
    
        local model = GetHashKey( name )
       
        RequestModel( model )

        while not HasModelLoaded( model ) do
            Wait(500)
        end
                
        local ped = CreatePed( model, x,y,z, heading,  false, true, false, false)           

                SetModelAsNoLongerNeeded(name)
                SetEntityAsMissionEntity(ped, true, true)            
	         Citizen.InvokeNative(0x283978A15512B2FE, ped, true)	
	            RequestCollisionAtCoord( x,y,z)
                SetPedCanBeTargettedByPlayer(ped, GetPlayerPed(), false)
                SetBlockingOfNonTemporaryEvents(ped, true)
       
    return ped
  end
end

fnc.NPCText = function(text, s1, s2, x, y, r, g, b, font)
    SetTextScale(s1, s2)
    SetTextColor(r, g, b, 255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1, 0, 0, 0, 200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

Citizen.CreateThread(function()   
      if not DoesEntityExist(butcher01) then        
         butcher01 = fnc.Spawn( Config.Butcher, Config.Butcher01_Pos, Config.Butcher01_Heading )
     end
      if not DoesEntityExist(butcher02) then
         butcher02 = fnc.Spawn( Config.Butcher, Config.Butcher02_Pos , Config.Butcher02_Heading )        
      end
      if not DoesEntityExist(butcher03) then
         butcher03 = fnc.Spawn( Config.Butcher, Config.Butcher03_Pos, Config.Butcher03_Heading )        
      end
      if not DoesEntityExist(butcher04) then
         butcher04 = fnc.Spawn( Config.Butcher, Config.Butcher04_Pos, Config.Butcher04_Heading )      
      end
      if not DoesEntityExist(butcher05) then
         butcher05 = fnc.Spawn( Config.Butcher, Config.Butcher05_Pos, Config.Butcher05_Heading )         
      end
      if not DoesEntityExist(butcher06) then
         butcher06 = fnc.Spawn( Config.Butcher, Config.Butcher06_Pos, Config.Butcher06_Heading )      
      end      
end)



Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher01) then    
             SetEntityAsNoLongerNeeded(butcher01)
             Citizen.Wait(20000)         
             DeletePed(butcher01)                      
             Citizen.Wait(120000) 
             butcher01 = fnc.Spawn( Config.Butcher , Config.Butcher01_Pos, Config.Butcher01_Heading )                   
       end      
 end
end)

Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher02) then    
             SetEntityAsNoLongerNeeded(butcher02)
             Citizen.Wait(20000)         
             DeletePed(butcher02)                       
             Citizen.Wait(120000) 
             butcher02 = fnc.Spawn( Config.Butcher , Config.Butcher02_Pos , Config.Butcher02_Heading )                       
       end      
 end
end)

Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher03) then    
             SetEntityAsNoLongerNeeded(butcher03)
             Citizen.Wait(20000)     
             DeletePed(butcher03)                        
             Citizen.Wait(120000) 
             butcher03 = fnc.Spawn( Config.Butcher , Config.Butcher03_Pos, Config.Butcher03_Heading )
                       
       end      
 end
end)

Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher04) then    
             SetEntityAsNoLongerNeeded(butcher04)
             Citizen.Wait(20000)         
             DeletePed(butcher04)                      
             Citizen.Wait(120000) 
             butcher04 = fnc.Spawn( Config.Butcher , Config.Butcher04_Pos, Config.Butcher04_Heading )
                        
       end      
 end
end)

Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher05) then    
             SetEntityAsNoLongerNeeded(butcher05)
             Citizen.Wait(20000)        
             DeletePed(butcher05)                         
             Citizen.Wait(120000) 
             butcher05 = fnc.Spawn( Config.Butcher , Config.Butcher05_Pos, Config.Butcher05_Heading )                      
       end      
 end
end)

Citizen.CreateThread(function() -- Added Butchers
   while true do
     Citizen.Wait(5000)              
        if IsEntityDead(butcher06) then    
             SetEntityAsNoLongerNeeded(butcher06)
             Citizen.Wait(20000)        
             DeletePed(butcher06)                         
             Citizen.Wait(120000) 
             butcher06 = fnc.Spawn( Config.Butcher , Config.Butcher06_Pos, Config.Butcher06_Heading )                      
       end      
 end
end)    

