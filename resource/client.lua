lib.locale()
---@type clientUtils
local utils = lib.load('modules.utils.client')

local useFakeplate = function(_, item)
    local pedCoords = GetEntityCoords(cache.ped)

    local vehicle = lib.getClosestVehicle(pedCoords, 3.0, false)
    if not vehicle then return end

    local boneCoords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'platelight'))
    if #(boneCoords - pedCoords) > 1.0 then
        utils.notify(locale('notify.too_far_plate'), 'error')
        return
    end

    if utils.progressBar(locale('progress.applying_plate'), 5000, { move = true }, { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 6 }) then
        local success = lib.callback.await('mt_fakeplates:server:applyVehiclePlate', false, GetVehicleNumberPlateText(vehicle), item)
        if success then
            SetVehicleNumberPlateText(vehicle, item.metadata.plate)
            utils.giveKeys(vehicle, item.metadata.plate)
        end
    end
end
exports('useFakeplate', useFakeplate)

local removeFakeplate = function(_, item)
    local pedCoords = GetEntityCoords(cache.ped)

    local vehicle = lib.getClosestVehicle(pedCoords, 3.0, false)
    if not vehicle then return end

    local boneCoords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'platelight'))
    if #(boneCoords - pedCoords) > 1.0 then
        utils.notify(locale('notify.too_far_plate'), 'error')
        return
    end

    if utils.progressBar(locale('progress.removing_plate'), 5000, { move = true }, { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 6 }) then
        local success = lib.callback.await('mt_fakeplates:server:removeVehiclePlate', false, GetVehicleNumberPlateText(vehicle), item)
        if success then
            SetVehicleNumberPlateText(vehicle, '')
        end
    end
end
exports('removeFakeplate', removeFakeplate)
