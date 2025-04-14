lib.locale()
---@type serverUtils
local utils = lib.load('modules.utils.server')
---@type serverConfig
local config = lib.load('config.server')

lib.callback.register('mt_fakeplates:server:removeVehiclePlate', function(source, plate, item)
    local src = source

    if not (utils.getItemCount(src, config.items.screwdriver) > 0) then return false end

    if utils.isOwnedVehicle(plate) then
        utils.notify(src, locale('notify.vehicle_owned'), 'error')
        return false
    end

    if not utils.canCarryItem(src, config.items.fakeplate, 1) then
        utils.notify(src, locale('notify.cant_carry'), 'error')
        return false
    end

    utils.setItemMetadata(src, item.slot, {
        durability = ((item.metadata.durability or 100) - config.items.screwdriverDurabilityRemove)
    })
    utils.addItem(src, config.items.fakeplate, 1, {
        label = locale('inventory.plate', plate),
        plate = plate
    })

    return true
end)

lib.callback.register('mt_fakeplates:server:applyVehiclePlate', function(source, plate, item)
    local src = source

    if not plate then return false end
    if not item.metadata.plate then return false end

    if not (utils.getItemCount(src, config.items.fakeplate) > 0) then return false end

    if not utils.isOwnedVehicle(plate) then
        utils.notify(src, locale('notify.vehicle_owned'), 'error')
        return false
    end

    if not utils.canCarryItem(src, config.items.fakeplate, 1) then
        utils.notify(src, locale('notify.cant_carry'), 'error')
        return false
    end

    if not utils.updateVehicleFakeplateDatabase(src, plate, item.metadata.plate) then return false end

    utils.removeItem(src, config.items.fakeplate, 1, item.slot, item.metadata)
    utils.addItem(src, config.items.fakeplate, 1, {
        label = locale('inventory.plate', plate),
        plate = plate
    })

    return true
end)
