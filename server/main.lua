-- ─── Identifier helper ─────────────────────────────────────────────────────

local function getIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
        or GetPlayerIdentifier(source, 0)
end

-- ─── Check whether this player has already watched ─────────────────────────

RegisterNetEvent('hkn_welcome:server:checkWatched', function()
    local src        = source
    local identifier = getIdentifier(src)

    if not identifier or identifier == '' then
        print(('[HKN Welcome] Could not resolve identifier for player %s'):format(src))
        return
    end

    MySQL.query(
        'SELECT identifier FROM hkn_welcome WHERE identifier = ? LIMIT 1',
        { identifier },
        function(result)
            if result and #result > 0 then
                TriggerClientEvent('hkn_welcome:client:alreadyWatched', src)
            else
                TriggerClientEvent('hkn_welcome:client:startIntro', src)
            end
        end
    )
end)

-- ─── Mark player as having watched ────────────────────────────────────────

RegisterNetEvent('hkn_welcome:server:markWatched', function()
    local src        = source
    local identifier = getIdentifier(src)

    if not identifier or identifier == '' then
        print(('[HKN Welcome] Could not resolve identifier for player %s — intro not saved.'):format(src))
        return
    end

    MySQL.insert(
        'INSERT IGNORE INTO hkn_welcome (identifier) VALUES (?)',
        { identifier }
    )
end)