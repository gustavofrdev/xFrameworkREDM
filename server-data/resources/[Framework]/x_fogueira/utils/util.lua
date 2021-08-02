
--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

local global_settings = {}
local local_variables = {}
local memory_objects_table = {}


--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function GetEntityCoords( e )
	print("eae")
    return Citizen.InvokeNative(0xA86D5F069399F44D, e, Citizen.ResultAsVector())
end

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Net_RequestObject( model )
  Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Net_DelObject( object, deleteLocalVariable, saveMemory )
	DeleteEntity(global_settings["Client:Utils:SpawnedProp"]);
	if deleteLocalVariable  
	then 
		if saveMemory then memory_objects_table["Client:Utils:SpawnProp.Memory"] = global_settings["Client:Utils:SpawnedProp"] end ;
	global_settings["Client:Utils:SpawnedProp"] = nil;
	end

end  

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Net_CreateObjectInCoords( object, cordsTable )
	print("tentativa:39")
	local x=cordsTable.x;local y = cordsTable.y; local z = cordsTable.z;
	print('^2',x,y,z)
	local objectSettings         = {}
	local playerSettings         = {}
	local unbug                  = 0 
	objectSettings.thisModelHash = GetHashKey(object);
	objectSettings.objectModel   = object;
	playerSettings.thisPlayerPed = PlayerPedId();
	while not HasModelLoaded( objectSettings.thisModelHash )  
		do Wait(1)
		unbug=unbug+1
		Net_RequestObject( 	objectSettings.thisModelHash )
		if(unbug == 1000) 
		then print("^1['Client:UnbugAlerts:Linha47:UtilsSystem: [...]=> Function:net_createObjectInCoords:Sayed']:Sistema desligado. Valor de 'unbug' passou de 10.000 MS");
			print("^1['Client:UnbugAlerts:Linha47:UtilsSystem: [...]=> Function:net_createObjectInCoords:Sayed']:Confira se o prop do objeto está correto.")
			unbug=0
			return;
		end 
	end
	print("^2['Client:UnbugAlerts:SucessPropSpawn']: "..json.encode(objectSettings).. " OK!")
	print("Parametros para spawn:",objectSettings.thisModelHash,x,y,z)
	objectSettings.createdObj = CreateObject(objectSettings.thisModelHash,x,y,z,true,true,false)
	SetEntityLodDist(objectSettings.createdObj  , 40)
	SetEntityHeading(objectSettings.createdObj ,1)
	PlaceObjectOnGroundProperly(objectSettings.createdObj)
	SetEntityAsMissionEntity(objectSettings.createdObj, true, true)
	FreezeEntityPosition(objectSettings.createdObj , true)
	SetModelAsNoLongerNeeded(objectSettings.thisModelHash)
	global_settings["Client:Utils:SpawnedProp"] = objectSettings.createdObj
	print("Cordenada da fogueira:", GetEntityCoords(objectSettings.createdObj))
	end
 
--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Client_CreateTimer( maxTime, onCreate )
	print('oi2')
	local_variables.onTimer = onCreate
	local_variables.timerTime = maxTime
	Citizen.CreateThread ( function ()
	while local_variables.onTimer  
	do	Citizen.Wait ( 1000 )
		local_variables.timerTime = local_variables.timerTime - 1;
		maxTime = maxTime - 1; 
		if ( local_variables.timerTime == 0 or maxTime    == 0 or local_variables.timerTime == 0 and maxTime == 0 )
		then local_variables.onTimer   = false; onCreate = false; local_variables.timerTime = nil;maxTime   = nil
		end
		end 
	end)
end

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Client_GetTimer( already )
	if local_variables.onTimer  
	then return local_variables.timerTime; end
end

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!


--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function Client_GetSpawnedOBJ()
	if ( global_settings["Client:Utils:SpawnedProp"] )  
	then return global_settings["Client:Utils:SpawnedProp"], true
	else 
		return "Não há nenhum prop/fogueira spawnada", false 
	end
end

--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end