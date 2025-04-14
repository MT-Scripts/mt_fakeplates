---@class clientUtils
---@field debug fun(message: string, type: string) function to show debug messages
---@field notify fun(message: string, type: string) function to throw a notification
---@field progressBar fun(label: string, duration: number, disable?: table, anim?: table, prop?: table): boolean function to show a progress bar
---@field giveKeys fun(vehicle: number, plate: string) function to give the vehicle keys to the player
local utils = {}

utils.debug = function(message, type)
    if GetResourceState('ox_lib') == 'started' then
        lib.print[type](message)
    else
        print(('[%s] %s'):format(type, message))
    end
end

utils.notify = function(message, type)
    if GetResourceState('ox_lib') == 'started' then
        lib.notify({ description = message, type = type })
    else
        utils.debug('No notification system found, check mt_fakeplates/modules/client.lua!', 'warn')
    end
end

utils.progressBar = function(label, duration, disable, anim, prop)
    if GetResourceState('ox_lib') == 'started' then
	    return lib.progressBar({ label = label, duration = duration, useWhileDead = false, canCancel = true, disable = disable, anim = anim, prop = prop })
    end
    utils.debug('No progressbar system detected, edit the mt_fakeplates/modules/utils/client.lua', 'error')
    return false
end

utils.giveKeys = function(vehicle, plate)
    if GetResourceState('Renewed-Vehiclekeys') == 'started' then
        exports['Renewed-Vehiclekeys']:addKey(plate)
    else
        utils.debug('No vehicle keys system detected, edit the mt_fakeplates/modules/utils/client.lua', 'error')
    end
end

return utils
