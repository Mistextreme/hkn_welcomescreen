if not Config.UpdateCheck then return end

local RESOURCE_NAME    = GetCurrentResourceName()
local CURRENT_VERSION  = GetResourceMetadata(RESOURCE_NAME, 'version', 0) or 'unknown'
local VERSION_ENDPOINT = 'https://raw.githubusercontent.com/hknworks/hkn_welcomescreen/main/version.json'

CreateThread(function()
    Wait(3000)

    PerformHttpRequest(VERSION_ENDPOINT, function(statusCode, responseText, headers)
        if statusCode ~= 200 or not responseText or responseText == '' then
            print(('^3[HKN Welcome] Update check failed (HTTP %s). Skipping.^7'):format(tostring(statusCode)))
            return
        end

        local ok, data = pcall(json.decode, responseText)

        if not ok or not data or not data.version then
            print('^3[HKN Welcome] Update check returned invalid data. Skipping.^7')
            return
        end

        if data.version ~= CURRENT_VERSION then
            print(('^3[HKN Welcome] Update available! Latest: %s | Installed: %s^7'):format(data.version, CURRENT_VERSION))
            print('^3[HKN Welcome] Visit the store or Discord to get the latest version.^7')
        else
            print(('^2[HKN Welcome] Up to date. (%s)^7'):format(CURRENT_VERSION))
        end
    end, 'GET', '', { ['Content-Type'] = 'application/json' })
end)