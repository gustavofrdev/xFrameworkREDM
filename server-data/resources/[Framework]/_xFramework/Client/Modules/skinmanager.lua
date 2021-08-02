local isAnimalPed = false
local IsAttacking = false
local cache;

function VerifyPedType(ped)
    if IsModelValid(ped) then 
        local ped = CreatePed(ped,  -644.74, -1341.54, -20.43, 0, false, false, false, false)
        SetEntityVisible(ped, false)
        local r = IsPedHuman(ped)
        DeleteEntity(ped)
        return r
    end
end
function _Framework.Skin(ped, old)
    local hash = GetHashKey(ped)
    if IsModelValid(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(100) end
        if not VerifyPedType(hash) then TriggerEvent("xFramework:Notify", "negado", "Para setar animais, utilize /Animal <animal_ped> ... Retrocedendo cache["..old.."]") return end
        Citizen.InvokeNative(0xED40380076A31506, PlayerId(), hash, false)
        if not IsPedHuman(PlayerPedId()) then 
            FrameworkSV.changeDbCl(old)
            TriggerEvent("Character:Reload")
             TriggerEvent('load::Clothes')
        end
        FrameworkSV.changeDbCl(ped)
        if ped ~= "mp_male" and ped ~= "mp_female" then 
            SetVariation(0)
        else
             TriggerEvent("Character:Reload")
             TriggerEvent('load::Clothes')
        end
    else
        TriggerEvent("xFramework:Notify", "negado", " O modelo <"..ped.. " / " .. hash .. "> não é válido.")
    end
end
function SetVariation(i)
    SetPedOutfitPreset(PlayerPedId(),i,0)
end

function _Framework.Animal(model)
    local hash = GetHashKey(model)
    if IsModelValid(hash) then 
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(100) end
        if VerifyPedType(hash) then TriggerEvent("xFramework:Notify", "negado", "Para setar humanos, utilize apenas /ped ") return end
        Citizen.InvokeNative(0xED40380076A31506, PlayerId(), hash, false)
        Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
        SetEntityInvincible(PlayerPedId(), true)
        SetModelAsNoLongerNeeded(hash)
        SetPedConfigFlag(PlayerPedId(), 43, true)
        isAnimalPed = true
    else
        TriggerEvent("xFramework:Notify", " O modelo <"..ped.. " / " .. hash .. "> não é válido.")
    end
end
function SetControlContext(pad, context)
	Citizen.InvokeNative(0x2804658EB7D8A50B, pad, context)
end

function GetPedCrouchMovement(ped)
	return Citizen.InvokeNative(0xD5FE956C70FF370B, ped)
end

function SetPedCrouchMovement(ped, state, immediately)
	Citizen.InvokeNative(0x7DE9692C6F64CFE8, ped, state, immediately)
end
Citizen.CreateThread(function()
	while true do
		if isAnimalPed then
          
            DrawTxt(
                'Pressione [J] para assumir a forma humana novamente.',
                0.50,
                0.90,
                0.5,
                0.5,
                true,
                255,
                255,
                255,
                255,
                true
            )
			SetControlContext(2, `OnMount`)

			DisableFirstPersonCamThisFrame()

            if IsControlJustPressed(0, 0xF3830D8E) then 
                TriggerEvent("Character:Reload")
                TriggerEvent('load::Clothes')
                isAnimalPed = false 
                SetEntityInvincible(PlayerPedId(), false)
            end
			if IsControlJustPressed(0, `INPUT_ATTACK`) then
				Attack()
			end

			if IsControlJustPressed(0, `INPUT_HORSE_MELEE`) then
				ToggleCrouch()
			end
		end

		Citizen.Wait(0)
	end
end)
function Attack()
	if IsAttacking then
		return
	end

	local playerPed = PlayerPedId()

	if IsPedDeadOrDying(playerPed) or IsPedRagdoll(playerPed) then
		return
	end

	local attackType = GetAttackType(playerPed)

	if attackType then
		local target = GetClosestPed(playerPed, attackType.radius)

		if target then
			IsAttacking = true

			MakeEntityFaceEntity(playerPed, target)

			PlayAnimation(attackType.animation)

			if IsPedAPlayer(target) then
				TriggerServerEvent("xFramework::Animais <attack>", GetPlayerServerIdFromPed(target), -1)
			elseif NetworkGetEntityIsNetworked(target) and not NetworkHasControlOfEntity(target) then
				TriggerServerEvent("xFramework::Animais <attack>", -1, PedToNet(target))
			else
				ApplyAttackToTarget(playerPed, target, attackType)
			end

			Citizen.SetTimeout(2000, function()
				IsAttacking = false
			end)
		end
	end
end
RegisterNetEvent("xFramework::Animais <attack>(C)")
AddEventHandler("xFramework::Animais <attack>(C)", function(attacker, entity)
	local attackerPed = GetPlayerPed(GetPlayerFromServerId(attacker))
	local attackType = GetAttackType(attackerPed)

	if entity == -1 then
		if IsPvpEnabled() then
			ApplyAttackToTarget(attackerPed, PlayerPedId(), attackType)
		end
	else
		ApplyAttackToTarget(attackerPed, NetToPed(entity), attackType)
	end
end)

function ToggleCrouch()
	local playerPed = PlayerPedId()

	SetPedCrouchMovement(playerPed, not GetPedCrouchMovement(playerPed), true)
end


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(3, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    n(0xADA9255D, 1)
    DisplayText(str, x, y)
end


function PlayAnimation(anim)
	if not DoesAnimDictExist(anim.dict) then
		--"Invalid animation dictionary: " .. anim.dict)
		return
	end

	RequestAnimDict(anim.dict)

	while not HasAnimDictLoaded(anim.dict) do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), anim.dict, anim.name, 4.0, 4.0, -1, 0, 0.0, false, false, false, "", false)

	RemoveAnimDict(anim.dict)
end

function IsPvpEnabled()
	return GetRelationshipBetweenGroups(`PLAYER`, `PLAYER`) == 5
end

function IsValidTarget(ped)
	return not IsPedDeadOrDying(ped) and not (IsPedAPlayer(ped) and not IsPvpEnabled())
end

function GetClosestPed(playerPed, radius)
	local playerCoords = GetEntityCoords(playerPed)

	local itemset = CreateItemset(true)
	local size = Citizen.InvokeNative(0x59B57C4B06531E1E, playerCoords, radius, itemset, 1, Citizen.ResultAsInteger())

	local closestPed
	local minDist = radius

	if size > 0 then
		for i = 0, size - 1 do
			local ped = GetIndexedItemInItemset(i, itemset)

			if playerPed ~= ped and IsValidTarget(ped) then
				local pedCoords = GetEntityCoords(ped)
				local distance = #(playerCoords - pedCoords)

				if distance < minDist then
					closestPed = ped
					minDist = distance
				end
			end
		end
	end

	if IsItemsetValid(itemset) then
		DestroyItemset(itemset)
	end

	return closestPed
end

function MakeEntityFaceEntity(entity1, entity2)
	local p1 = GetEntityCoords(entity1)
	local p2 = GetEntityCoords(entity2)

	local dx = p2.x - p1.x
	local dy = p2.y - p1.y

	local heading = GetHeadingFromVector_2d(dx, dy)

	SetEntityHeading(entity1, heading)
end
AttackTypes = {
	{
		models = {
			`A_C_SharkTiger`,
			`A_C_SharkHammerhead_01`
		},
		animation = {
			dict = "creatures_reptile@alligator@melee@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 2.0,
		damage = 75
	},
	{
		models = {
			`A_C_Alligator_01`,
			`MP_A_C_Alligator_01`
		},
		animation = {
			dict = "creatures_reptile@alligator@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 25
	},
	{
		models = {
			`A_C_Alligator_02`
		},
		animation = {
			dict = "amb_creatures_reptile@gator_giant@nip_attack",
			name = "nip"
		},
		radius = 3.0,
		force = 2.0,
		damage = 25
	},
	{
		models = {
			`A_C_Badger_01`
		},
		animation = {
			dict = "creatures_mammal@badger@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Bear_01`,
			`A_C_BearBlack_01`,
			`MP_A_C_Bear_01`
		},
		animation = {
			dict = "creatures_mammal@bear@melee@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 5.0,
		damage = 30
	},
	{
		models = {
			`A_C_Beaver_01`,
			`MP_A_C_Beaver_01`
		},
		animation = {
			dict = "creatures_mammal@beaver@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Cougar_01`,
			`A_C_Panther_01`,
			`MP_A_C_Cougar_01`,
			`MP_A_C_Panther_01`
		},
		animation = {
			dict = "creatures_mammal@cougar@melee@streamed_core",
			name = "attack"
		},
		radius = 2.0,
		force = 3.0,
		damage = 20
	},
	{
		models = {
			`A_C_Coyote_01`,
			`MP_A_C_Coyote_01`
		},
		animation = {
			dict = "creatures_mammal@coyote@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 25
	},
	{
		models = {
			`A_C_DogAmericanFoxhound_01`,
			`A_C_DogAustralianShepherd_01`,
			`A_C_DogBluetickCoonhound_01`,
			`A_C_DogCatahoulaCur_01`,
			`A_C_DogChesBayRetriever_01`,
			`A_C_DogCollie_01`,
			`A_C_DogHobo_01`,
			`A_C_DogHound_01`,
			`A_C_DogHusky_01`,
			`A_C_DogLab_01`,
			`A_C_DogLion_01`,
			`A_C_DogPoodle_01`,
			`A_C_DogRufus_01`,
			`A_C_DogStreet_01`,
			`MP_A_C_DogAmericanFoxhound_01`
		},
		animation = {
			dict = "creatures_mammal@dog_pers@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 20
	},
	{
		models = {
			`A_C_Muskrat_01`
		},
		animation = {
			dict = "creatures_mammal@muskrat@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Raccoon_01`
		},
		animation = {
			dict = "creatures_mammal@raccoon@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Wolf`,
			`MP_A_C_Wolf_01`,
			`A_C_LionMangy_01`
		},
		animation = {
			dict = "creatures_mammal@wolf@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 30
	},
	{
		models = {
			`A_C_Wolf_Medium`
		},
		animation = {
			dict = "creatures_mammal@wolf_medium@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 25
	},
	{
		models = {
			`A_C_Wolf_Small`
		},
		animation = {
			dict = "creatures_mammal@wolf_small@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 20
	}
}
function GetAttackType(playerPed)
	local playerModel = GetEntityModel(playerPed)

	for _, attackType in ipairs(AttackTypes) do
		for _, model in ipairs(attackType.models) do
			if playerModel == model then
				return attackType
			end
		end
	end
end

function ApplyAttackToTarget(attacker, target, attackType)
	if attackType.force > 0 then
		SetPedToRagdoll(target, 1000, 1000, 0, 0, 0, 0)
		SetEntityVelocity(target, GetEntityForwardVector(attacker) * attackType.force)
	end

	if attackType.damage > 0 then
		ApplyDamageToPed(target, attackType.damage, 1, -1, 0)
	end
end

function GetPlayerServerIdFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return GetPlayerServerId(player)
		end
	end
end