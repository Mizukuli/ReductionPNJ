local config = {
    vehicule = true, 
    vehiculeDensite = 0.3,
    pnj = true,
    pnjDensite = 0.2,
    vehiclepark = false,
    vehicleparkDensite = 0.5,
    areaCleared = {
        {coords = vector3(1620.0, 1115.0, 80.0), radius = 200.0},
        {coords = vector3(-2480.0, -210.0, 20.0), radius = 200.0}
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 

        if not config.vehicule then
            SetVehicleDensityMultiplierThisFrame(0.0) 
        else
            SetVehicleDensityMultiplierThisFrame(config.vehiculeDensite)
        end

        if not config.pnj then
            SetPedDensityMultiplierThisFrame(0.0) 
        else
            SetPedDensityMultiplierThisFrame(config.pnjDensite)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local PlayerCoords = GetEntityCoords(PlayerPedId())

        if config.vehiclepark then
            for i = 1, #config.areaCleared, 1 do
                if #(PlayerCoords - config.areaCleared[i].coords) < 50 then
                    ClearAreaOfVehicles(config.areaCleared[i].coords, config.areaCleared[i].radius, false, false, false, false, false)
                end
            end
        end

        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        RemoveVehiclesFromGeneratorsInArea(PlayerCoords - 250.0, PlayerCoords + 250.0)
        Citizen.Wait(3000)
    end
end)
