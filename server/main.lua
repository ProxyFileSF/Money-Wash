ESX = exports["es_extended"]:getSharedObject()
-- ​🇳​​🇴​​🇹​​🇮​​🇫​​🇮​​🇨​​🇦​​🇹​​🇮​​🇴​​🇳​ ​🇨​​🇭​​🇪​​🇨​​🇰​ ​🇦​​🇳​​🇩​ ​🇫​​🇺​​🇳​​🇨​​🇹​​🇮​​🇴​​🇳​
function notify(message, notifytype, src)
    if(Config.useCustomNotify) then
        TriggerClientEvent(Config.NotifySystem.notifyTrigger, src, Config.NotifySystem.notifyTitle, message, Config.NotifySystem.notifyTime, notifytype)
    else
        TriggerClientEvent('esx:showNotification', src, message, notifytype, time)
    end
end

-- ​🇳​​🇪​​🇻​​🇪​​🇷​ ​🇷​​🇪​​🇦​​🇱​​🇱​​🇾​ ​🇺​​🇸​​🇪​​🇩​ ​🇼​​🇪​​🇧​​🇭​​🇴​​🇴​​🇰​​🇸​, ​🇧​​🇺​​🇹​ ​🇮​​🇹​ ​🇼​​🇴​​🇷​​🇰​​🇸​
function notifyWebhook(title, message)
    local embed = {
        {
            ['color'] = 16744192,
            ['title'] = "**".."Washing Attempt | Failed".."**",
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

-- ​🇻​​🇪​​🇷​​🇾​ ​🇻​​🇪​​🇷​​🇾​ ​🇻​​🇪​​🇷​​🇾​​🇾​​🇾​​🇾​​🇾​​🇾​​🇾​​🇾​ ​🇱​​🇴​​🇳​​🇬​
function getIdentifiers(src)
    local steamid = ""
    local license = ""
    local xbl = ""
    local ip = ""
    local discord = ""
    local liveid = ""

    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
          xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
          ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
          liveid = v
        end
    end
    
    return ""..steamid.."\n"..license.."\n"..xbl.."\n"..ip.."\n"..discord.."\n"..liveid
end

-- ​🇦​​🇫​​🇹​​🇪​​🇷​ ​🇹​​🇭​​🇪​ ​🇺​​🇸​​🇪​​🇷​ ​🇭​​🇦​​🇸​ ​🇸​​🇪​​🇳​​🇩​ ​🇹​​🇭​​🇪​ ​🇹​​🇷​​🇦​​🇳​​🇸​​🇫​​🇪​​🇷​​🇨​​🇦​​🇸​​🇭​ ​🇹​​🇷​​🇮​​🇬​​🇬​​🇪​​🇷​
RegisterNetEvent('ps_money_wash:transferCash')
AddEventHandler('ps_money_wash:transferCash', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local finishAmount = amount - (amount * (Config.vatWash/100))

    if(xPlayer.getAccount(Config.washType).money >= amount) then
        xPlayer.removeAccountMoney(Config.washType, amount)
        xPlayer.addAccountMoney('money', finishAmount)
        print(finishAmount)
        Citizen.CreateThread(function()
            FreezeEntityPosition(GetPlayerPed(src), true)
            Citizen.Wait(Config.washTime)
            FreezeEntityPosition(GetPlayerPed(src), false)
        end)
        TriggerClientEvent('ps_money_wash:recievedEmote', src, finishAmount)
    else
        notify(Config.Messages['nothingtoWash'], 'error', src)
        if(Config.Webhook) then
            notifyWebhook('​🇲​​🇴​​🇳​​🇪​​🇾​ ​🇼​​🇦​​🇸​​🇭​ | ​🇧​​🇾​ ​🇵​​🇷​​🇴​​🇽​​🇾​​🇸​​🇨​​🇷​​🇮​​🇵​​🇹​​🇸​', 'Someone tried washing ```'.. amount..'$``` with insufficient funds!'..'\n ```'.. getIdentifiers(src) ..'```')
        end
    end
end)