ESX = exports["es_extended"]:getSharedObject()
-- ​🇳​​🇴​​🇹​​🇮​​🇫​​🇮​​🇨​​🇦​​🇹​​🇮​​🇴​​🇳​ ​🇨​​🇭​​🇪​​🇨​​🇰​ ​🇦​​🇳​​🇩​ ​🇫​​🇺​​🇳​​🇨​​🇹​​🇮​​🇴​​🇳​
function notify(message, notifytype)
    if(Config.useCustomNotify) then
        TriggerEvent(Config.NotifySystem.notifyTrigger, Config.NotifySystem.notifyTitle, message, Config.NotifySystem.notifyTime, notifytype)
    else
        TriggerEvent('esx:showNotification', message, notifytype, time)
    end
end

-- ​🇳​​🇺​​🇮​ ​🇫​​🇺​​🇳​​🇨​​🇹​​🇮​​🇴​​🇳s​ ​🇹​​🇴​ ​🇪​​🇳​​🇦​​🇧​​🇱​​🇪​ / ​🇩​​🇮​​🇸​​🇦​​🇧​​🇱​​🇪​ ​🇹​​🇭​​🇮​​🇳​​🇬​​🇸​
function setDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        dStats = bool,
    })
end

RegisterNUICallback('exit', function(data, cb)
    setDisplay(false)
end)

-- ​🇲​​🇦​​🇷​​🇰​​🇪​​🇷​ ​🇭​​🇦​​🇳​​🇩​​🇱​​🇪​​🇷​
-- ​🇨​​🇮​​🇹​​🇮​​🇿​​🇪​​🇳​ ​🇹​​🇭​​🇷​​🇪​​🇦​​🇩​ ​🇨​​🇦​​🇺​​🇸​​🇪​ ​🇧​​🇷​​🇺​​🇭​ ​🇼​​🇭​​🇾​ ​🇳​​🇴​​🇹​ ​🇸​​🇹​​🇴​​🇵​ ​🇱​​🇦​​🇬​ :)
function startScanning()
    local playerped = PlayerPedId()
    while true do
        for i,v in ipairs(Config.washingLocation) do
            local playerdistance = #(GetEntityCoords(playerped) - v.location)
            if(playerdistance < 100) then
                local x, y, z = table.unpack(v.location)
                DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.25, Config.washingMarkerColors.r, Config.washingMarkerColors.g, Config.washingMarkerColors.b, Config.washingMarkerColors.a, false, false, 2, false, nil, nil, false)
                if(playerdistance < 1.5) then
                    ESX.ShowHelpNotification(Config.Messages['showPopUp'])
                    if(IsControlJustPressed(0, 51)) then
                        setDisplay(true)
                    end
                end
            end
        end
        Citizen.Wait(5)
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    startScanning()
end)
