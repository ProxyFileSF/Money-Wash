ESX = exports["es_extended"]:getSharedObject()
-- ​🇳​​🇴​​🇹​​🇮​​🇫​​🇮​​🇨​​🇦​​🇹​​🇮​​🇴​​🇳​ ​🇨​​🇭​​🇪​​🇨​​🇰​ ​🇦​​🇳​​🇩​ ​🇫​​🇺​​🇳​​🇨​​🇹​​🇮​​🇴​​🇳​
function notify(message, notifytype, src)
    if(Config.useCustomNotify) then
        TriggerEvent(Config.NotifySystem.notifyTrigger, src, Config.NotifySystem.notifyTitle, message, Config.NotifySystem.notifyTime, notifytype)
    else
        TriggerEvent('esx:showNotification', src, message, notifytype, time)
    end
end

function notifyWebhook(title, message)
    local embed = {
        {
            ['color'] = 16744192,
            ['title'] = "**"..title.."**",
            ['description'] = message,
        }
        PerformHttpRequest(Config.WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = title, embeds = embed}), {['Content-Type'] = 'application/json'})
    }
end

RegisterNetEvent('ps_money_wash:transferCash')
AddEventHandler('ps_money_wash:transferCash', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer.getAccount(Config.washType) >= amount) then

    else
        if(Config.Webhook) then
            notifyWebhook('Money Wash', 'Tried to wash without money')
        end
        notify(Config.Messages['nothingtoWash'], 'error', src)
    end
end)