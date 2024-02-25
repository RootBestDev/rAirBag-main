--[[
----
----Created Date: 22:54 Thursday February 25th 2024
----Author: RootBestDev
----Made with Love ❤
----
----File: [cl_airbag]
----
----Copyright (c) 2024 RootBestDevWork, All Rights Reserved.
----This file is part of RootBestDevWork project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local damageLevel = 960.0
local secondsToExpire = 50
local modelName = `prop_car_airbag`

TriggerEvent('chat:addSuggestion', '/airbag', 'Activate l\'airbags')

local vehicleAirbags = {}
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped and GetVehicleEngineHealth(vehicle) <= damageLevel and vehicleAirbags[vehicle] == nil then
            local class = GetVehicleClass(vehicle)
            if class ~= 8 and class ~= 16 and class ~= 15 and class ~= 13 then
                createAirbags(vehicle, true)
            end
        end
        Wait(1000)
    end
end)

RegisterCommand('airbag', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
        if vehicle ~= 0 then createAirbags(vehicle, true) end
    end
end)

function createAirbags(vehicle, temp)
    vehicleAirbags[vehicle] = vehicle
    local driverSeat = GetEntityBoneIndexByName(vehicle, "seat_dside_f")
    local passengerSeat = GetEntityBoneIndexByName(vehicle, "seat_pside_f")
    loadModel(modelName)
    local coords = GetEntityCoords(ped)
    local airbag1 = CreateObject(modelName, coords.x, coords.y, coords.z, true, true, true)
    local airbag2 = CreateObject(modelName, coords.x, coords.y, coords.z, true, true, true)
    while not DoesEntityExist(airbag1) or not DoesEntityExist(airbag2) do Wait(0) end
    SetModelAsNoLongerNeeded(modelName)
    AttachEntityToEntity(airbag1, vehicle, driverSeat, 0.0, 0.30, 0.40, 90.0, 0.0, 0.0, true, true, false, false, 2, true)
    AttachEntityToEntity(airbag2, vehicle, passengerSeat, 0.0, 0.50, 0.40, 90.0, 0.0, 0.0, true, true, false, false, 2, true)
    if temp then
        local deleted = false
        
        Citizen.SetTimeout(secondsToExpire * 1000, function()
            if not deleted then
                NetworkRequestControlOfEntity(airbag1)
                NetworkRequestControlOfEntity(airbag2)
                if DoesEntityExist(airbag1) then DeleteEntity(airbag1) end
                if DoesEntityExist(airbag2) then DeleteEntity(airbag2) end
                deleted = true
            end
        end)
        Citizen.CreateThread(function()
            while not deleted do
                if not DoesEntityExist(vehicle) then
                    NetworkRequestControlOfEntity(airbag1)
                    NetworkRequestControlOfEntity(airbag2)
                    if DoesEntityExist(airbag1) then DeleteEntity(airbag1) end
                    if DoesEntityExist(airbag2) then DeleteEntity(airbag2) end
                    deleted = true
                end
                Wait(1000)
            end
        end)
    end      
end

function loadModel(modelName)
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Wait(0)
    end
end