ESX = nil

local Accessories = {
	"silent",
	"flashlight",
	"grip",
	"extended_magazine",
	"very_extended_magazine",
	"scope",
	"advanced_scope",
	"yusuf",
	"lowrider",
	"incendiary",
	"tracer_clip",
	"hollow",
	"fmj",
	"lazer_scope",
	"compansator",
	"nightvision_scope",
	"thermal_scope",
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('silent', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipSilent', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipFlashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipGrip', source)
end)

ESX.RegisterUsableItem('extended_magazine', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipExtendedMag', source)
end)

ESX.RegisterUsableItem('very_extended_magazine', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipVeryExtendedMag', source)
end)

ESX.RegisterUsableItem('scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipScope', source)
end)

ESX.RegisterUsableItem('advanced_scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipAdvancedScope', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipYusuf', source)
end)

ESX.RegisterUsableItem('lowrider', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipLowrider', source)
end)

ESX.RegisterUsableItem('incendiary', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipIncendiary', source)
end)

ESX.RegisterUsableItem('tracer_clip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipTracer', source)
end)

ESX.RegisterUsableItem('hollow', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipHollow', source)
end)

ESX.RegisterUsableItem('fmj', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipFMJ', source)
end)

ESX.RegisterUsableItem('lazer_scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipLazerScope', source)
end)

ESX.RegisterUsableItem('compansator', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipCompansator', source)
end)

ESX.RegisterUsableItem('nightvision_scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipNightVisionScope', source)
end)

ESX.RegisterUsableItem('thermal_scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipThermalScope', source)
end)

ESX.RegisterUsableItem('barrel', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_weaponsaccessories:equipBarrel', source)
end)

function TableHasValue(table, item)
	for k, v in pairs(table) do
		if v == item then
			return true
		end
	end
	return false
end

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    if TableHasValue(Accessories, item.name) then
        TriggerClientEvent('esx_weaponsaccessories:looseComponent', source, item.name, item.count)
    end
end)