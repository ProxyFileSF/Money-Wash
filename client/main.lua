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

RegisterNUICallback('submit', function(data, cb)
    if not (tonumber(data.amount) == nil or tonumber(data.amount) <= tonumber(0)) then
        TriggerServerEvent('ps_money_wash:transferCash', tonumber(data.amount))
    else
        notify(Config.Messages['ifisNull'], 'error')
    end
end)

RegisterNetEvent('ps_money_wash:recievedEmote')
AddEventHandler('ps_money_wash:recievedEmote', function()
    
end)

-- ​🇲​​🇦​​🇷​​🇰​​🇪​​🇷​ ​🇭​​🇦​​🇳​​🇩​​🇱​​🇪​​🇷​
-- ​🇨​​🇮​​🇹​​🇮​​🇿​​🇪​​🇳​ ​🇹​​🇭​​🇷​​🇪​​🇦​​🇩​ ​🇨​​🇦​​🇺​​🇸​​🇪​ ​🇧​​🇷​​🇺​​🇭​ ​🇼​​🇭​​🇾​ ​🇳​​🇴​​🇹​ ​🇸​​🇹​​🇴​​🇵​ ​🇱​​🇦​​🇬​ :)
Citizen.CreateThread(function()
    while true do
        for i,v in ipairs(Config.washingLocation) do
            local playerdistance = #(GetEntityCoords(PlayerPedId()) - v.location)
            if(playerdistance < 100) then
                local x, y, z = table.unpack(v.location)
                DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.25, Config.washingMarkerColors.r, Config.washingMarkerColors.g, Config.washingMarkerColors.b, Config.washingMarkerColors.a, false, false, 2, false, nil, nil, false)
                if(playerdistance < 1.5) then
                    ESX.ShowHelpNotification(Config.Messages['showPopUp'])
                    if(IsControlJustPressed(0, 51)) then
                        SendNUIMessage({type = "location", location = v.name,})
                        setDisplay(true)
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)