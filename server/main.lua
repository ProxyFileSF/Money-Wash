ESX = exports["es_extended"]:getSharedObject()
-- ​🇳​​🇴​​🇹​​🇮​​🇫​​🇮​​🇨​​🇦​​🇹​​🇮​​🇴​​🇳​ ​🇨​​🇭​​🇪​​🇨​​🇰​ ​🇦​​🇳​​🇩​ ​🇫​​🇺​​🇳​​🇨​​🇹​​🇮​​🇴​​🇳​
function notify(message, notifytype, src)
    if(Config.useCustomNotify) then
        TriggerEvent(Config.NotifySystem.notifyTrigger, src, Config.NotifySystem.notifyTitle, message, Config.NotifySystem.notifyTime, notifytype)
    else
        TriggerEvent('esx:showNotification', src, message, notifytype, time)
    end
end