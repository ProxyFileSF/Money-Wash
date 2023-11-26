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
            ['title'] = "**".."Washing".."**",
            ['description'] = message,
            ['footer'] = {
                ['text'] = "by ProxyScripts",
                ['icon_url'] = "https://media.discordapp.net/attachments/1024402243493048365/1177968141964431481/static-removebg-preview.png?ex=65746f52&is=6561fa52&hm=386b4c7ed911356e59cbca7fd4aa08ebe3492ccd2a8490c1e2d7e8773a6b8da3&=&format=webp",
            },
            ['timestamp'] = os.date("%Y-%m-%d %H:%M:%S")
        }
    }
    PerformHttpRequest(Config.WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = title, embeds = embed}), {['Content-Type'] = 'application/json'})
end

RegisterNetEvent('ps_money_wash:transferCash')
AddEventHandler('ps_money_wash:transferCash', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer.getAccount(Config.washType).money >= amount) then

    else
        if(Config.Webhook) then
            notifyWebhook('​🇲​​🇴​​🇳​​🇪​​🇾​ ​🇼​​🇦​​🇸​​🇭​ | ​🇧​​🇾​ ​🇵​​🇷​​🇴​​🇽​​🇾​​🇸​​🇨​​🇷​​🇮​​🇵​​🇹​​🇸​', 'Tried to wash '.. amount..'$\n \n ```'.. GetPlayerIdentifiers(src) ..'```')
            print(os.time().date)
        end
        notify(Config.Messages['nothingtoWash'], 'error', src)
    end
end)