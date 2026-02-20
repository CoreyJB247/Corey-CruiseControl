local cruiseEnabled = false

if Config.Speed  == "km" then
    speed = 3.6
else
    speed = 2.237
end

if Config.Command then
    RegisterNetEvent('pnt_cruiseControl:cruiserCar')
    AddEventHandler('pnt_cruiseControl:cruiserCar', function(cruiserSpeed, cruiserNotification)
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In

        Wait(250)

        if not inVehicle then
            return lib.notify({
                title = 'Corey Vehicle Actions',
                description = Strings["not_in_vehicle"],
                type = 'error'
            })
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return lib.notify({
                title = 'Corey Vehicle Actions',
                description = Strings["not_driver_seat"],
                type = 'error'
            })
        end

        SetEntityMaxSpeed(vehicle, cruiserSpeed)
        cruiseEnabled = true
        lib.notify({
            title = 'Corey Vehicle Actions',
            description = string.format(Strings["cruiser_set_at"], cruiserNotification, Config.Speed),
            type = 'success'
        })
    end)

    RegisterCommand(Config.OffCruiseCommand, function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset

        Wait(250)

        if not inVehicle then
            return lib.notify({
                title = 'Corey Vehicle Actions',
                description = Strings["not_in_vehicle"],
                type = 'error'
            })
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return lib.notify({
                title = 'Corey Vehicle Actions',
                description = Strings["not_driver_seat"],
                type = 'error'
            })
        end
        
        SetEntityMaxSpeed(vehicle, maxSpeed)
        cruiseEnabled = false
        lib.notify({
            title = 'Corey Vehicle Actions',
            description = Strings["no_cruiser"],
            type = 'inform'
        })
    end)
end


if Config.KeyMap then

    RegisterCommand("+activatecruiser", function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset
        local cruiserSpeed = GetEntitySpeed(vehicle) -- Get the current speed

        Wait(250)

        if not inVehicle then
            return
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return
        end

        if not cruiseEnabled then
            SetEntityMaxSpeed(vehicle, cruiserSpeed)
            cruiserNotification = math.floor(cruiserSpeed * speed + 0.5)
            cruiseEnabled = true
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = string.format(Strings["cruiser_set_at"], cruiserNotification, Config.Speed),
                type = 'success'
            })
        else
            SetEntityMaxSpeed(vehicle, maxSpeed)
            cruiseEnabled = false
            lib.notify({
                title = 'Corey Vehicle Actions',
                description = Strings["no_cruiser"],
                type = 'inform'
            })
        end
    end)

    RegisterKeyMapping('+activatecruiser', 'Activate cruiser', 'keyboard', Config.KeyBind)

end