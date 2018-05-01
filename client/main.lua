local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX          = nil
local UsedAccessories = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetCountItem(itemname)
	local inventory = ESX.GetPlayerData().inventory
	local silencieux = 0
	for i=1, #inventory, 1 do
	  	if inventory[i].name == itemname then
			return inventory[i].count
	  	end
	end
	return 0
end

function OpenComponentsMenu()
	local elements = {
		{label = _U("silent"), value = "silent"},
		{label = _U("flashlight"), value = "flashlight"},
		{label = _U("grip"), value = "grip"},
		{label = _U("emag"), value = "emag"},
		{label = _U("vemag"), value = "vemag"},
		{label = _U("scope"), value = "scope"},
		{label = _U("ascope"), value = "ascope"},
		{label = _U("yusuf"), value = "yusuf"},
		{label = _U("lowrider"), value = "lowrider"},
		{label = _U("incendiary"), value = "incendiary"},
		{label = _U("tracer"), value = "tracer"},
		{label = _U("hollow"), value = "hollow"},
		{label = _U("fmj"), value = "fmj"},
		{label = _U("lazer_scope"), value = "lazer_scope"},
		{label = _U("compansator"), value = "compansator"},
		{label = _U("thermal_scope"), value = "thermal_scope"},
		{label = _U("nightvision_scope"), value = "nightvision_scope"},
		{label = _U("barrel"), value = "barrel"},
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'esx_weaponsaccessories',
        {
            title    = _U('accessories_select'),
            align    = 'top-left',
            elements = elements,
           
        },
       
        function(data, menu)
        	if data.current.value == "silent" then
        		TriggerEvent("esx_weaponsaccessories:unequipSilent")
        	elseif data.current.value == "flashlight" then
        		TriggerEvent("esx_weaponsaccessories:unequipFlashlight")
    		elseif data.current.value == "grip" then
        		TriggerEvent("esx_weaponsaccessories:unequipGrip")
        	elseif data.current.value == "emag" then
        		TriggerEvent("esx_weaponsaccessories:unequipEmag")
        	elseif data.current.value == "vemag" then
        		TriggerEvent("esx_weaponsaccessories:unequipVEmag")
        	elseif data.current.value == "scope" then
        		TriggerEvent("esx_weaponsaccessories:unequipScope")
        	elseif data.current.value == "ascope" then
        		TriggerEvent("esx_weaponsaccessories:unequipAdvancedcope")
        	elseif data.current.value == "yusuf" then
        		TriggerEvent("esx_weaponsaccessories:unequipYusuf")
        	elseif data.current.value == "lowrider" then
        		TriggerEvent("esx_weaponsaccessories:unequipLowrider")
        	elseif data.current.value == "incendiary" then
        		TriggerEvent("esx_weaponsaccessories:unequipIncendiary")
        	elseif data.current.value == "tracer" then
        		TriggerEvent("esx_weaponsaccessories:unequipTracer")
        	elseif data.current.value == "lazer_scope" then
        		TriggerEvent("esx_weaponsaccessories:unequipLazerScope")
        	elseif data.current.value == "compansator" then
        		TriggerEvent("esx_weaponsaccessories:unequipCompansator")
        	elseif data.current.value == "thermal_scope" then
        		TriggerEvent("esx_weaponsaccessories:unequipThermalScope")
        	elseif data.current.value == "nightvision_scope" then
        		TriggerEvent("esx_weaponsaccessories:unequipNightvisionScope")
        	elseif data.current.value == "barrel" then
        		TriggerEvent("esx_weaponsaccessories:unequipBarrel")
    		elseif data.current.value == "fmj" then
        		TriggerEvent("esx_weaponsaccessories:unequipFMJ")
        	elseif data.current.value == "hollow" then
        		TriggerEvent("esx_weaponsaccessories:unequipHollow")
        	end
        end,
        function(data, menu)  
            menu.close()
        end
    )
end

function IsMK2(item)
	for k, v in pairs(Config.WeaponsSkins) do
		if GetHashKey(k) == item then
			return true
		end
	end
	return false
end

function OpenWeaponsSkinsMenu()
	local elements = {}
	local i = 1
	ESX.UI.Menu.CloseAll()

	for k, v in pairs(Config.WeaponsSkins) do
		if GetHashKey(k) == GetSelectedPedWeapon(GetPlayerPed(-1)) then
			i = 1
			table.insert(elements, {label = "------------------------"})
			table.insert(elements, {label = "|         ".._U('skins').."         |"})
			table.insert(elements, {label = "------------------------"})
			table.insert(elements, {label = _U('reset'), reset = true})
			table.insert(elements, {label = "---------", reset = true})
			for ke, va in pairs(v.labels) do
				table.insert(elements, {label = GetLabelText(va), camo = v.hashes[i]})
				i = i + 1
			end
		end
	end
	if IsMK2(GetSelectedPedWeapon(GetPlayerPed(-1))) then
		table.insert(elements, {label = "-------------------------"})
		table.insert(elements, {label = "| ".._U('colors').." |"})
		table.insert(elements, {label = "-------------------------"})
		table.insert(elements, {label = _U('default'), istint = true, value = 0})
		table.insert(elements, {label = "-------------------------"})
		table.insert(elements, {label = _U('classic_gray'), istint = true, value = 1})
		table.insert(elements, {label = _U('classic_twotone'), istint = true, value = 2})
		table.insert(elements, {label = _U('classic_white'), istint = true, value = 3})
		table.insert(elements, {label = _U('classic_beige'), istint = true, value = 4})
		table.insert(elements, {label = _U('classic_green'), istint = true, value = 5})
		table.insert(elements, {label = _U('classic_blue'), istint = true, value = 6})
		table.insert(elements, {label = _U('classic_earth'), istint = true, value = 7})
		table.insert(elements, {label = _U('classic_brownandblack'), istint = true, value = 8})
		table.insert(elements, {label = _U('red_contrast'), istint = true, value = 9})
		table.insert(elements, {label = _U('blue_contrast'), istint = true, value = 10})
		table.insert(elements, {label = _U('yellow_contrast'), istint = true, value = 11})
		table.insert(elements, {label = _U('orange_contrast'), istint = true, value = 12})
		table.insert(elements, {label = _U('bold_pink'), istint = true, value = 13})
		table.insert(elements, {label = _U('bold_purpleandyellow'), istint = true, value = 14})
		table.insert(elements, {label = _U('bold_orange'), istint = true, value = 15})
		table.insert(elements, {label = _U('bold_greenandpurple'), istint = true, value = 16})
		table.insert(elements, {label = _U('bold_red'), istint = true, value = 17})
		table.insert(elements, {label = _U('bold_green'), istint = true, value = 18})
		table.insert(elements, {label = _U('bold_cyan'), istint = true, value = 19})
		table.insert(elements, {label = _U('bold_yellow'), istint = true, value = 20})
		table.insert(elements, {label = _U('bold_redandwhite'), istint = true, value = 21})
		table.insert(elements, {label = _U('bold_blueandwhite'), istint = true, value = 22})
		table.insert(elements, {label = _U('metallic_gold'), istint = true, value = 23})
		table.insert(elements, {label = _U('metallic_platinum'), istint = true, value = 24})
		table.insert(elements, {label = _U('metallic_grayandlilac'), istint = true, value = 25})
		table.insert(elements, {label = _U('metallic_purpleandlime'), istint = true, value = 26})
		table.insert(elements, {label = _U('metallic_red'), istint = true, value = 27})
		table.insert(elements, {label = _U('metallic_green'), istint = true, value = 28})
		table.insert(elements, {label = _U('metallic_blue'), istint = true, value = 29})
		table.insert(elements, {label = _U('metallic_whiteandaqua'), istint = true, value = 30})
		table.insert(elements, {label = _U('metallic_redandyellow'), istint = true, value = 31})
	else
		table.insert(elements, {label = _U('default'), istint = true, value = 0})
		table.insert(elements, {label = _U('green'), istint = true, value = 1})
		table.insert(elements, {label = _U('gold'), istint = true, value = 2})
		table.insert(elements, {label = _U('pink'), istint = true, value = 3})
		table.insert(elements, {label = _U('army'), istint = true, value = 4})
		table.insert(elements, {label = _U('lspd'), istint = true, value = 5})
		table.insert(elements, {label = _U('orange'), istint = true, value = 6})
		table.insert(elements, {label = _U('platinum'), istint = true, value = 7})
	end
	ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'esx_weaponsaccessories_skins',
	    {
	        title    = _U('skin_select'),
	        align    = 'top-left',
	        elements = elements,
	       
	    },
	   
	    function(data, menu)
	    	if data.current.reset == true then
	    		for k, v in pairs(Config.WeaponsSkins) do
					if GetHashKey(k) == GetSelectedPedWeapon(GetPlayerPed(-1)) then
						for ke, va in pairs(v.hashes) do
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)), va)
						end
					end
				end
	    	elseif data.current.camo == nil then
	    		SetPedWeaponTintIndex(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)), data.current.value)
	    	else
	    		GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)), data.current.camo)
	    	end
	    end,
	    function(data, menu)  
	        menu.close()
	    end
	)
end

-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("WEAPON_UNARMED") then
			if IsControlPressed(0, Keys['G']) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'esx_weaponsaccessories') then
	            OpenComponentsMenu()
	        end
	        if IsControlPressed(0, Keys['U']) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'esx_weaponsaccessories_skins') then
	            OpenWeaponsSkinsMenu()
	        end
	    end
    end
end)

RegisterNetEvent('esx_weaponsaccessories:equipSilent')
AddEventHandler('esx_weaponsaccessories:equipSilent', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Silent == nil or UsedAccessories.Silent < GetCountItem("silencieux") then
		if UsedAccessories.Silent == nil then
			UsedAccessories.Silent = 0
		end
		for k, v in pairs(Config.SilentWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Silent = UsedAccessories.Silent + 1
				ESX.ShowNotification(_U("silent_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("silent_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_silent"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipSilent')
AddEventHandler('esx_weaponsaccessories:unequipSilent', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.SilentWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Silent == nil or UsedAccessories.Silent < 0 then
					UsedAccessories.Silent = 0
				end
				UsedAccessories.Silent = UsedAccessories.Silent - 1
				ESX.ShowNotification(_U("silent_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipFlashlight')
AddEventHandler('esx_weaponsaccessories:equipFlashlight', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Flashlight == nil or UsedAccessories.Flashlight < GetCountItem("flashlight") then
		if UsedAccessories.Flashlight == nil then
			UsedAccessories.Flashlight = 0
		end
		for k, v in pairs(Config.FlashLightWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Flashlight = UsedAccessories.Flashlight + 1
				ESX.ShowNotification(_U("flashlight_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("flashlight_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_flashlight"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipFlashlight')
AddEventHandler('esx_weaponsaccessories:unequipFlashlight', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.FlashLightWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Flashlight == nil or UsedAccessories.Flashlight < 0 then
					UsedAccessories.Flashlight = 0
				end
				UsedAccessories.Flashlight = UsedAccessories.Flashlight - 1
				ESX.ShowNotification(_U("flashlight_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipGrip')
AddEventHandler('esx_weaponsaccessories:equipGrip', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Grip == nil or UsedAccessories.Grip < GetCountItem("grip") then
		if UsedAccessories.Grip == nil then
			UsedAccessories.Grip = 0
		end
		for k, v in pairs(Config.GripWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Grip = UsedAccessories.Grip + 1
				ESX.ShowNotification(_U("grip_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("grip_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_grip"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipGrip')
AddEventHandler('esx_weaponsaccessories:unequipGrip', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.GripWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Grip == nil or UsedAccessories.Grip < 0 then
					UsedAccessories.Grip = 0
				end
				UsedAccessories.Grip = UsedAccessories.Grip - 1
				ESX.ShowNotification(_U("grip_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipExtendedMag')
AddEventHandler('esx_weaponsaccessories:equipExtendedMag', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Emag == nil or UsedAccessories.Emag < GetCountItem("extended_magazine") then
		if UsedAccessories.Emag == nil then
			UsedAccessories.Emag = 0
		end
		for k, v in pairs(Config.ExtendedMagazineWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Emag = UsedAccessories.Emag + 1
				ESX.ShowNotification(_U("emag_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("emag_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_emag"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipEmag')
AddEventHandler('esx_weaponsaccessories:unequipEmag', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.ExtendedMagazineWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Emag == nil or UsedAccessories.Emag < 0 then
					UsedAccessories.Emag = 0
				end
				UsedAccessories.Emag = UsedAccessories.Emag - 1
				ESX.ShowNotification(_U("emag_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipVeryExtendedMag')
AddEventHandler('esx_weaponsaccessories:equipVeryExtendedMag', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.VEmag == nil or UsedAccessories.VEmag < GetCountItem("very_extended_magazine") then
		if UsedAccessories.VEmag == nil then
			UsedAccessories.VEmag = 0
		end
		for k, v in pairs(Config.VeryExtendedMagazineWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.VEmag = UsedAccessories.VEmag + 1
				ESX.ShowNotification(_U("vemag_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("vemag_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_vemag"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipVEmag')
AddEventHandler('esx_weaponsaccessories:unequipVEmag', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.VeryExtendedMagazineWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.VEmag == nil or UsedAccessories.VEmag < 0 then
					UsedAccessories.VEmag = 0
				end
				UsedAccessories.VEmag = UsedAccessories.VEmag - 1
				ESX.ShowNotification(_U("vemag_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipScope')
AddEventHandler('esx_weaponsaccessories:equipScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Scope == nil or UsedAccessories.Scope < GetCountItem("scope") then
		if UsedAccessories.Scope == nil then
			UsedAccessories.Scope = 0
		end
		for k, v in pairs(Config.ScopeWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Scope = UsedAccessories.Scope + 1
				ESX.ShowNotification(_U("scope_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("scope_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_scope"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipScope')
AddEventHandler('esx_weaponsaccessories:unequipScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.ScopeWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Scope == nil or UsedAccessories.Scope < 0 then
					UsedAccessories.Scope = 0
				end
				UsedAccessories.Scope = UsedAccessories.Scope - 1
				ESX.ShowNotification(_U("scope_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
			--TriggerServerEvent('esx_weaponsaccessories:silentEquiped')
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipAdvancedScope')
AddEventHandler('esx_weaponsaccessories:equipAdvancedScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.AdvancedScope == nil or UsedAccessories.AdvancedScope < GetCountItem("advanced_scope") then
		if UsedAccessories.AdvancedScope == nil then
			UsedAccessories.AdvancedScope = 0
		end
		for k, v in pairs(Config.AdvancedScopeWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.AdvancedScope = UsedAccessories.AdvancedScope + 1
				ESX.ShowNotification(_U("ascope_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("ascope_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_ascope"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipAdvancedScope')
AddEventHandler('esx_weaponsaccessories:unequipAdvancedcope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.AdvancedScopeWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.AdvancedScope == nil or UsedAccessories.AdvancedScope < 0 then
					UsedAccessories.AdvancedScope = 0
				end
				UsedAccessories.AdvancedScope = UsedAccessories.AdvancedScope - 1
				ESX.ShowNotification(_U("ascope_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipYusuf')
AddEventHandler('esx_weaponsaccessories:equipYusuf', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Yusuf == nil or UsedAccessories.Yusuf < GetCountItem("yusuf") then
		if UsedAccessories.Yusuf == nil then
			UsedAccessories.Yusuf = 0
		end
		for k, v in pairs(Config.YusufWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Yusuf = UsedAccessories.Yusuf + 1
				ESX.ShowNotification(_U("yusuf_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("yusuf_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_yusuf"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipYusuf')
AddEventHandler('esx_weaponsaccessories:unequipYusuf', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.YusufWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Yusuf == nil or UsedAccessories.Yusuf < 0 then
					UsedAccessories.Yusuf = 0
				end
				UsedAccessories.Yusuf = UsedAccessories.Yusuf - 1
				ESX.ShowNotification(_U("yusuf_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipLowrider')
AddEventHandler('esx_weaponsaccessories:equipLowrider', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Lowrider == nil or UsedAccessories.Lowrider < GetCountItem("lowrider") then
		if UsedAccessories.Lowrider == nil then
			UsedAccessories.Lowrider = 0
		end
		for k, v in pairs(Config.LowriderWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Lowrider = UsedAccessories.Lowrider + 1
				ESX.ShowNotification(_U("lowrider_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("lowrider_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_lowrider"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipLowrider')
AddEventHandler('esx_weaponsaccessories:unequipLowrider', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.LowriderWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Lowrider == nil or UsedAccessories.Lowrider < 0 then
					UsedAccessories.Lowrider = 0
				end
				UsedAccessories.Lowrider = UsedAccessories.Lowrider - 1
				ESX.ShowNotification(_U("lowrider_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipIncendiary')
AddEventHandler('esx_weaponsaccessories:equipIncendiary', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Incendiary == nil or UsedAccessories.Incendiary < GetCountItem("incendiary") then
		if UsedAccessories.Incendiary == nil then
			UsedAccessories.Incendiary = 0
		end
		for k, v in pairs(Config.IcendiaryWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Incendiary = UsedAccessories.Incendiary + 1
				ESX.ShowNotification(_U("incendiary_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("icendiary_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_incendiary"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipIncendiary')
AddEventHandler('esx_weaponsaccessories:unequipIncendiary', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.IcendiaryWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Incendiary == nil or UsedAccessories.Incendiary < 0 then
					UsedAccessories.Incendiary = 0
				end
				UsedAccessories.Incendiary = UsedAccessories.Incendiary - 1
				ESX.ShowNotification(_U("incendiary_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipTracer')
AddEventHandler('esx_weaponsaccessories:equipTracer', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Tracer == nil or UsedAccessories.Tracer < GetCountItem("tracer") then
		if UsedAccessories.Tracer == nil then
			UsedAccessories.Tracer = 0
		end
		for k, v in pairs(Config.TracerWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Tracer = UsedAccessories.Tracer + 1
				ESX.ShowNotification(_U("tracer_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("tracer_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_tracer"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipTracer')
AddEventHandler('esx_weaponsaccessories:unequipTracer', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.TracerWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Tracer == nil or UsedAccessories.Tracer < 0 then
					UsedAccessories.Tracer = 0
				end
				UsedAccessories.Tracer = UsedAccessories.Tracer - 1
				ESX.ShowNotification(_U("tracer_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipHollow')
AddEventHandler('esx_weaponsaccessories:equipHollow', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.HollowPoint == nil or UsedAccessories.HollowPoint < GetCountItem("hollow") then
		if UsedAccessories.HollowPoint == nil then
			UsedAccessories.HollowPoint = 0
		end
		for k, v in pairs(Config.HollowPointWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.HollowPoint = UsedAccessories.HollowPoint + 1
				ESX.ShowNotification(_U("incendiary_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("icendiary_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_hollow"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipHollow')
AddEventHandler('esx_weaponsaccessories:unequipHollow', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.HollowPointWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.HollowPoint == nil or UsedAccessories.HollowPoint < 0 then
					UsedAccessories.HollowPoint = 0
				end
				UsedAccessories.HollowPoint = UsedAccessories.HollowPoint - 1
				ESX.ShowNotification(_U("silent_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipFMJ')
AddEventHandler('esx_weaponsaccessories:equipFMJ', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.FMJ == nil or UsedAccessories.FMJ < GetCountItem("fmj") then
		if UsedAccessories.FMJ == nil then
			UsedAccessories.FMJ = 0
		end
		for k, v in pairs(Config.FMJWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.FMJ = UsedAccessories.FMJ + 1
				ESX.ShowNotification(_U("incendiary_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("icendiary_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_fmj"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipFMJ')
AddEventHandler('esx_weaponsaccessories:unequipFMJ', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.FMJWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.FMJ == nil or UsedAccessories.FMJ < 0 then
					UsedAccessories.FMJ = 0
				end
				UsedAccessories.FMJ = UsedAccessories.FMJ - 1
				ESX.ShowNotification(_U("silent_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipLazerScope')
AddEventHandler('esx_weaponsaccessories:equipLazerScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.LazerScope == nil or UsedAccessories.LazerScope < GetCountItem("lazer_scope") then
		if UsedAccessories.LazerScope == nil then
			UsedAccessories.LazerScope = 0
		end
		for k, v in pairs(Config.LazerScopeWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.LazerScope = UsedAccessories.LazerScope + 1
				ESX.ShowNotification(_U("lazer_scope_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("lazer_scope_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_lazer_scope"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipLazerScope')
AddEventHandler('esx_weaponsaccessories:unequipLazerScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.LazerScopeWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.LazerScope == nil or UsedAccessories.LazerScope < 0 then
					UsedAccessories.LazerScope = 0
				end
				UsedAccessories.LazerScope = UsedAccessories.LazerScope - 1
				ESX.ShowNotification(_U("lazer_scope_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipCompansator')
AddEventHandler('esx_weaponsaccessories:equipCompansator', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Compansator == nil or UsedAccessories.Compansator < GetCountItem("compansator") then
		if UsedAccessories.Compansator == nil then
			UsedAccessories.Compansator = 0
		end
		for k, v in pairs(Config.CompensatorWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Compansator = UsedAccessories.Compansator + 1
				ESX.ShowNotification(_U("compansator_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("compansator_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_compansator"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipCompansator')
AddEventHandler('esx_weaponsaccessories:unequipCompansator', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.CompensatorWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Compansator == nil or UsedAccessories.Compansator < 0 then
					UsedAccessories.Compansator = 0
				end
				UsedAccessories.Compansator = UsedAccessories.Compansator - 1
				ESX.ShowNotification(_U("compansator_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipThermalScope')
AddEventHandler('esx_weaponsaccessories:equipThermalScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.ThermalScope == nil or UsedAccessories.ThermalScope < GetCountItem("thermal_scope") then
		if UsedAccessories.ThermalScope == nil then
			UsedAccessories.ThermalScope = 0
		end
		for k, v in pairs(Config.ThermalScopeWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.ThermalScope = UsedAccessories.ThermalScope + 1
				ESX.ShowNotification(_U("thermal_scope_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("thermal_scope_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_thermal_scope"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipThermalScope')
AddEventHandler('esx_weaponsaccessories:unequipThermalScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.ThermalScopeWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.ThermalScope == nil or UsedAccessories.ThermalScope < 0 then
					UsedAccessories.ThermalScope = 0
				end
				UsedAccessories.ThermalScope = UsedAccessories.ThermalScope - 1
				ESX.ShowNotification(_U("thermal_scope_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipNightVisionScope')
AddEventHandler('esx_weaponsaccessories:equipNightVisionScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.NightvisionScope == nil or UsedAccessories.NightvisionScope < GetCountItem("nightvision_scope") then
		if UsedAccessories.NightvisionScope == nil then
			UsedAccessories.NightvisionScope = 0
		end
		for k, v in pairs(Config.NightVisionScopeWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.NightvisionScope = UsedAccessories.NightvisionScope + 1
				ESX.ShowNotification(_U("nightvision_scope_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("nightvision_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_nightvision_scope"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipNightvisionScope')
AddEventHandler('esx_weaponsaccessories:unequipNightvisionScope', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.NightVisionScopeWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.NightvisionScope == nil or UsedAccessories.NightvisionScope < 0 then
					UsedAccessories.NightvisionScope = 0
				end
				UsedAccessories.NightvisionScope = UsedAccessories.NightvisionScope - 1
				ESX.ShowNotification(_U("nightvision_scope_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:equipBarrel')
AddEventHandler('esx_weaponsaccessories:equipBarrel', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	if UsedAccessories.Barrel == nil or UsedAccessories.Barrel < GetCountItem("barrel") then
		if UsedAccessories.Barrel == nil then
			UsedAccessories.Barrel = 0
		end
		for k, v in pairs(Config.BarrelsWeapons) do
			if GetHashKey(k) == CurrentWeaponHash then
				GiveWeaponComponentToPed(PlayerPed, GetHashKey(k), GetHashKey(v))
				EquipableWeapon = true
				UsedAccessories.Barrel = UsedAccessories.Barrel + 1
				ESX.ShowNotification(_U("barrel_equiped"))
			end
		end

		if not EquipableWeapon then
			ESX.ShowNotification(_U("barrel_not_available"))
		end
	else
		ESX.ShowNotification(_U("not_enough_barrel"))
	end
end)

RegisterNetEvent('esx_weaponsaccessories:unequipBarrel')
AddEventHandler('esx_weaponsaccessories:unequipBarrel', function()
	local PlayerPed = GetPlayerPed(-1)
	local CurrentWeaponHash = GetSelectedPedWeapon(PlayerPed)
	local EquipableWeapon = false

	for k, v in pairs(Config.BarrelsWeapons) do
		if GetHashKey(k) == CurrentWeaponHash then
			if HasPedGotWeaponComponent(PlayerPed, CurrentWeaponHash, GetHashKey(v)) then
				RemoveWeaponComponentFromPed(PlayerPed, CurrentWeaponHash, GetHashKey(v))
				if UsedAccessories.Barrels == nil or UsedAccessories.Barrels < 0 then
					UsedAccessories.Barrels = 0
				end
				UsedAccessories.Barrels = UsedAccessories.Barrels - 1
				ESX.ShowNotification(_U("barrel_unequiped"))
			else
				ESX.ShowNotification(_U("no_weapon_component"))
			end
		end
	end
end)

RegisterNetEvent('esx_weaponsaccessories:looseComponent')
AddEventHandler('esx_weaponsaccessories:looseComponent', function(component, number)
	if component == "silent" then
		if UsedAccessories.Silent > number then
			for k, v in pairs(Config.SilentWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Silent = UsedAccessories.Silent - 1
					break
				end
			end
		end
	elseif component == "flashlight" then
		if UsedAccessories.Flashlight > number then
			for k, v in pairs(Config.FlashlightWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Flashlight = UsedAccessories.Flashlight - 1
					break
				end
			end
		end
	elseif component == "grip" then
		if UsedAccessories.Grip > number then
			for k, v in pairs(Config.GripWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Grip = UsedAccessories.Grip - 1
					break
				end
			end
		end
	elseif component == "extended_magazine" then
		if UsedAccessories.Emag > number then
			for k, v in pairs(Config.ExtendedMagazineWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Emag = UsedAccessories.Emag - 1
					break
				end
			end
		end
	elseif component == "very_extended_magazine" then
		if UsedAccessories.VEmag > number then
			for k, v in pairs(Config.VeryExtendedMagazineWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.VEmag = UsedAccessories.VEmag - 1
					break
				end
			end
		end
	elseif component == "scope" then
		if UsedAccessories.Scope > number then
			for k, v in pairs(Config.ScopeWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Scope = UsedAccessories.Scope - 1
					break
				end
			end
		end
	elseif component == "advanced_scope" then
		if UsedAccessories.AdvancedScope > number then
			for k, v in pairs(Config.AdvancedScopeWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.AdvancedScope = UsedAccessories.AdvancedScope - 1
					break
				end
			end
		end
	elseif component == "yusuf" then
		if UsedAccessories.Yusuf > number then
			for k, v in pairs(Config.YusufWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Yusuf = UsedAccessories.Yusuf - 1
					break
				end
			end
		end
	elseif component == "lowrider" then
		if UsedAccessories.Lowrider > number then
			for k, v in pairs(Config.LowriderWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Lowrider = UsedAccessories.Lowrider - 1
					break
				end
			end
		end
	elseif component == "incendiary" then
		if UsedAccessories.Incendiary > number then
			for k, v in pairs(Config.IncendiaryWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Incendiary = UsedAccessories.Incendiary - 1
					break
				end
			end
		end
	elseif component == "tracer_clip" then
		if UsedAccessories.Tracer > number then
			for k, v in pairs(Config.TracerWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Tracer = UsedAccessories.Tracer - 1
					break
				end
			end
		end
	elseif component == "hollow" then
		if UsedAccessories.HollowPoints > number then
			for k, v in pairs(Config.HollowPointWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.HollowPoints = UsedAccessories.HollowPoints - 1
					break
				end
			end
		end
	elseif component == "fmj" then
		if UsedAccessories.FMJ > number then
			for k, v in pairs(Config.FMJWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.FMJ = UsedAccessories.FMJ - 1
					break
				end
			end
		end
	elseif component == "lazer_scope" then
		if UsedAccessories.LazerScope > number then
			for k, v in pairs(Config.LazerScopeWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.LazerScope = UsedAccessories.LazerScope - 1
					break
				end
			end
		end
	elseif component == "compansator" then
		if UsedAccessories.Compensator > number then
			for k, v in pairs(Config.CompensatorWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Compensator = UsedAccessories.Compensator - 1
					break
				end
			end
		end
	elseif component == "nightvision_scope" then
		if UsedAccessories.NightvisionScope > number then
			for k, v in pairs(Config.NightVisionScopeWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.NightvisionScope = UsedAccessories.NightvisionScope - 1
					break
				end
			end
		end
	elseif component == "thermal_scope" then
		if UsedAccessories.ThermalScope > number then
			for k, v in pairs(Config.ThermalScopeWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.ThermalScope = UsedAccessories.ThermalScope - 1
					break
				end
			end
		end
	elseif component == "barrel" then
		if UsedAccessories.Barrel > number then
			for k, v in pairs(Config.BarrelsWeapons) do
				if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(k), false) and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v)) then
					RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
					UsedAccessories.Barrel = UsedAccessories.Barrel - 1
					break
				end
			end
		end
	end
end)