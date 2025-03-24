
function ToggleSound(State)
    if State then
        StartAudioScene("MP_LEADERBOARD_SCENE")
    else
        StopAudioScene("MP_LEADERBOARD_SCENE")
    end
end

function InitialSetup()
    SetManualShutdownLoadingScreenNui(true)

    ToggleSound(true)

    if not IsPlayerSwitchInProgress() then
        SwitchToMultiFirstpart(PlayerPedId(), 0, 1)
    end
end

function ClearScreen()
    SetCloudHatOpacity(0.01)

    HideHudAndRadarThisFrame()

    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

InitialSetup()

Citizen.CreateThread(function()
    InitialSetup()

    FreezeEntityPosition(PlayerPedId(), true)

    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end

    BeginTextCommandBusyspinnerOn("MP_SPINLOADING")
    EndTextCommandBusyspinnerOn(4)

    ShutdownLoadingScreen()

    BeginTextCommandBusyspinnerOn("MP_SPINLOADING")
    EndTextCommandBusyspinnerOn(4)

    ClearScreen()
    Citizen.Wait(0)
    DoScreenFadeOut(0)
    
    ShutdownLoadingScreenNui()

    ClearScreen()
    Citizen.Wait(0)
    ClearScreen()
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
        ClearScreen()
    end

    BeginTextCommandBusyspinnerOn("MP_SPINLOADING")
    EndTextCommandBusyspinnerOn(4)

    local Timer = GetGameTimer()

    ToggleSound(false)

    while true do
        ClearScreen()
        Citizen.Wait(0)

        if GetGameTimer() - Timer > 5000 then
            
            SwitchToMultiSecondpart(PlayerPedId())

            ClearScreen()

            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end

            BusyspinnerOff()
            FreezeEntityPosition(PlayerPedId(), false)
            break
        end
    end

    ClearDrawOrigin()
end)
