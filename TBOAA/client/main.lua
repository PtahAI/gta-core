
local FirstSpawn = false

local OscarBlip = nil

function OnFirstSpawn()
    Citizen.Wait(22000)

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("What's up! I've got a job for you, Come to my house.")
    ThefeedNextPostBackgroundColor(140)
    EndTextCommandThefeedPostMessagetext("CHAR_OSCAR", "CHAR_OSCAR", false, 2, "Oscar", "INFO")
    EndTextCommandThefeedPostTicker(true, true)

    Citizen.Wait(3000)

    SpawnBlip()
end

AddEventHandler("playerSpawned", function ()
    if not FirstSpawn then
        FirstSpawn = true

        OnFirstSpawn()
    else

        if DoesBlipExist(OscarBlip) then
            RemoveBlip(OscarBlip)
            OscarBlip = nil
        end
    end
end)

AddEventHandler("onClientResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if NetworkIsPlayerActive(PlayerId()) then
            OnFirstSpawn()
        end
    end
end)

function SpawnBlip()
    if OscarBlip then
        RemoveBlip(OscarBlip)
    end

    OscarBlip = AddBlipForCoord(Config.OscarCoords.x, Config.OscarCoords.y, Config.OscarCoords.z)

    SetBlipSprite(OscarBlip, 387)
    SetBlipDisplay(OscarBlip, 2)
    SetBlipScale(OscarBlip, 1.1)
    SetBlipColour(OscarBlip, 5)
    SetBlipAsShortRange(OscarBlip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Oscar")
    EndTextCommandSetBlipName(OscarBlip)
end

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

    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end

    ShutdownLoadingScreen()

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

            break
        end
    end

    ClearDrawOrigin()
end)
