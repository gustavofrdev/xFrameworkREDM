local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkSV = Proxy.getInterface("_xFramework")
FrameworkCL = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_multicharacter")
CharCreator = Tunnel.getInterface("x_charactercreator")
_Tunnel = {}
Tunnel.bindInterface("x_multicharacter", _Tunnel)

--------------------------------------------------------------------
-- functions Tunnel <> --
--------------------------------------------------------------------

function generateRG()
    local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#"DDLLLDDD" do
		local char = string.sub("DDLLLDDD",i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
    return number
end
function _Tunnel.SpawnCharacter(characterID)
    local source = source 
    FrameworkSV.IdLoad(source, tonumber(characterID))
    local CharacterJSON = FrameworkSV.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @charid", {["@charid"] = tonumber(characterID)})
        print(json.decode(CharacterJSON[1].characterdata))
          CharacterJSON = json.decode(CharacterJSON[1].characterdata)
          CharCreator.SetPersonagem(source, CharacterJSON)
          Wait(100) --> Apenas precaução
          CharCreator.LoadPersonagem(source)
          FrameworkSV.SpawnInLastLoc(tonumber(characterID))

end

function _Tunnel.PlayerLogin()
    -- print("playerlogin")
    local source = source 
    local steam = FrameworkSV.GetPlayerActualSteam(source)
    exports.ghmattimysql:execute("SELECT id,idade,name,firstname,RG FROM xframework_personagens WHERE ownerhex = @steam", {["@steam"] = steam}, function(w)
        MultiCharacter.sendCharactersData(source, w)
        -- print(is)
        end)

end

function index(isSecondPlayer)
    local index = 1 
    if isSecondPlayer then index = 2 end 
    return index 
end
function _Tunnel.CreateNewCharacter(isSecondPlayer)
    local source = source 
    local index = index(isSecondPlayer)
    if index == 2 then 
        if not FrameworkSV.isVipInUserData(FrameworkSV.GetPlayerActualSteam(source)) then 
            TriggerClientEvent("xFramework:Notify", source, "negado", "Adquira VIP para poder criar o segundo personagem.")
            return
        end
    end
    TriggerClientEvent("x_multicharacter:Continue", source)
    local steam = FrameworkSV.GetPlayerActualSteam(source)
    local criar = FrameworkSV.SQLExecute("INSERT into xframework_personagens(RG, ownerhex) VALUES(@RG,@HEX)", {["@RG"] = generateRG(), ["@HEX"] = steam })
    while not criar do Wait(0) end -- Esperar os valores chegarem até a database!
    local id = FrameworkSV.SQLExecute("SELECT id FROM xframework_personagens WHERE ownerhex = @HEX", {["@HEX"] = steam})
    FrameworkSV.IdLoad(source, id[index].id)
    CharCreator.CriarPersonagem(source, id[index].id)
    FrameworkSV.NewCharacter(id[index].id)
end 

RegisterServerEvent("x_multicharacter:resetPlayer")
AddEventHandler("x_multicharacter:resetPlayer", function(playerId, playerUserId)
    CharCreator.CriarPersonagem_2(playerId, playerUserId)
end)