---@class serverUtils
---@field debug fun(message: string | table, type: string) function to print a message to the console
---@field addItem fun(src: number, item: string, quantity: number, metadata?: table) function to give the item to the player
---@field removeItem fun(src: number, item: string, quantity?: number, slot?: number, metadata?: table) function to remove the item from the player
---@field notify fun(src: number, message: string, type: string) function to notify the player
---@field canCarryItem fun(src: number, item: string, quantity: integer | number) function to check if the player can carry that item quantity
---@field getItemCount fun(src: number, item: string): number function get item quantity from player's inventory by its name
---@field createLog fun(src: number, name: string, message: string) function to create a log system
---@field setItemMetadata fun(id: string | number, slot: number, metadata: table) function to set an item metadata
---@field isOwnedVehicle fun(plate: string): boolean function to check if the vehicle is owned
---@field updateVehicleFakeplateDatabase fun(src: number, plate: string, newPlate: string): boolean function to update the vehicle fakeplate in the database
local utils = {}

utils.debug = function(message, type)
    if GetResourceState('ox_lib') == 'started' then
       lib.print[type](message)
    else
        print(message)
    end
end

utils.canCarryItem = function(src, item, quantity)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:CanCarryItem(src, item, tonumber(quantity))
    else
        utils.debug('No inventory system detected, check mt_fakeplates/modules/utils/server.lua!!', 'error')
    end
end

utils.notify = function(src, message, type)
    if GetResourceState('ox_lib') == 'started' then
        TriggerClientEvent('ox_lib:notify', src, { description = message, type = type })
    else
        print('No notify system detected, edit the mt_fakeplates/modules/utils/server.lua')
    end
end

utils.addItem = function(src, item, quantity, metadata)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:AddItem(src, item, quantity, metadata)
    else
        utils.debug('No inventory system detected, check mt_fakeplates/modules/utils/server.lua!!', 'error')
    end
end

utils.removeItem = function(src, item, quantity, slot, metadata)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:RemoveItem(src, item, quantity, metadata, slot)
    else
        utils.debug('No inventory system detected, check mt_fakeplates/modules/utils/server.lua!!', 'error')
    end
end

utils.getItemCount = function(src, item)
    if GetResourceState('ox_inventory') == 'started' then
       return exports.ox_inventory:GetItemCount(src, item)
    else
        utils.debug('No inventory system detected, check mt_fakeplates/modules/utils/server.lua!!', 'error')
    end
    return 0
end

utils.createLog = function(src, name, message)
    if GetResourceState('ox_lib') == 'started' then
        lib.logger(src, name, message)
    else
        utils.debug('No log system detected, check mt_fakeplates/modules/utils/server.lua!!', 'error')
    end
end

utils.setItemMetadata = function(id, slot, metadata)
    exports.ox_inventory:SetMetadata(id, slot, metadata)
end

utils.isOwnedVehicle = function(plate)
    local result = MySQL.scalar.await('SELECT plate FROM `player_vehicles` WHERE plate = ? OR fakeplate = ?', { plate, plate })
    return result
end

utils.updateVehicleFakeplateDatabase = function(src, plate, newPlate)
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return false end

    local affectedRows = MySQL.update.await('UPDATE player_vehicles SET fakeplate = ? WHERE citizenid = ? AND plate = ?', {
        newPlate, player.PlayerData.citizenid, plate
    })

    if not (affectedRows > 0) then
        affectedRows = MySQL.update.await('UPDATE player_vehicles SET fakeplate = ? WHERE citizenid = ? AND fakeplate = ?', {
            nil, player.PlayerData.citizenid, plate
        })
    end

    return affectedRows > 0
end

utils.updateVehicleTrunk = function(oldPlate, newPlate)
    exports.ox_inventory:UpdateVehicle(oldPlate, newPlate)
end

return utils
