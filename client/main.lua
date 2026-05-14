local currentIndex   = 1
local totalLocations = #Config.Locations
local activeCam      = nil
local camToken       = 0
local isIntroActive  = false
local locale         = Config.Locales[Config.Locale] or Config.Locales['en']

local CAM_FOV           = 60.0
local FADE_BETWEEN_MS   = 300
local FADE_BETWEEN_WAIT = FADE_BETWEEN_MS + 50

-- ─── Camera helpers ────────────────────────────────────────────────────────

local function createCamAt(camData)
    return CreateCamWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        camData.coords.x, camData.coords.y, camData.coords.z,
        camData.pitch, 0.0, camData.heading,
        CAM_FOV, false, 0
    )
end

local function destroyActiveCam(stopRender)
    if activeCam and DoesCamExist(activeCam) then
        DestroyCam(activeCam, false)
        activeCam = nil
    end
    if stopRender then
        RenderScriptCams(false, false, 0, true, true)
    end
end

-- Walks through every camera in a location.
-- Exits cleanly if camToken changes (a new location was triggered mid-animation).
local function playCamerasForLocation(location, token)
    local cameras = location.cameras
    if not cameras or #cameras == 0 then return end

    destroyActiveCam(false)

    local firstCam = createCamAt(cameras[1])
    SetCamActive(firstCam, true)
    RenderScriptCams(true, false, 0, true, true)
    activeCam = firstCam

    if #cameras <= 1 then return end

    local durationMs  = (location.duration or 5) * 1000
    local timePerStep = math.floor(durationMs / (#cameras - 1))
    local smooth      = location.smoothTransition

    CreateThread(function()
        local prevCam = firstCam

        -- FIX: For non-smooth locations, showLocation() calls DoScreenFadeIn()
        -- synchronously just before this thread starts executing. Without this
        -- wait, the first inner DoScreenFadeOut fires on the very next frame and
        -- immediately fights the outer FadeIn — keeping the screen black through
        -- the entire first within-location camera transition. Waiting here lets
        -- the outer fade-in fully complete before any inner fades begin.
        if not smooth then
            Wait(FADE_BETWEEN_MS + 100)
        end

        for i = 2, #cameras do
            if camToken ~= token then return end

            local nextCam = createCamAt(cameras[i])

            if smooth then
                SetCamActiveWithInterp(nextCam, prevCam, timePerStep, 1, 1)
                Wait(timePerStep)
            else
                DoScreenFadeOut(FADE_BETWEEN_MS)
                Wait(FADE_BETWEEN_WAIT)

                if camToken ~= token then
                    DestroyCam(nextCam, false)
                    return
                end

                SetCamActive(nextCam, true)
                activeCam = nextCam
                DoScreenFadeIn(FADE_BETWEEN_MS)
                Wait(FADE_BETWEEN_MS)
            end

            if camToken ~= token then
                DestroyCam(nextCam, false)
                return
            end

            if DoesCamExist(prevCam) then
                DestroyCam(prevCam, false)
            end

            prevCam   = nextCam
            activeCam = nextCam
        end
    end)
end

-- ─── NUI messaging ─────────────────────────────────────────────────────────

local function sendLocationNUI(index)
    local loc = Config.Locations[index]
    if not loc then return end

    SendNUIMessage({
        action      = "show",
        title       = loc.title,
        description = loc.description,
        current     = index,
        total       = totalLocations,
        isFirst     = (index == 1),
        isLast      = (index == totalLocations),
        duration    = loc.duration
    })
end

-- ─── Location navigation ───────────────────────────────────────────────────

-- Must be called from within a Citizen thread (uses Wait for fade).
local function showLocation(index)
    if not isIntroActive then return end

    local loc = Config.Locations[index]
    if not loc then return end

    currentIndex = index

    DoScreenFadeOut(FADE_BETWEEN_MS)
    Wait(FADE_BETWEEN_WAIT)

    camToken = camToken + 1
    local myToken = camToken

    playCamerasForLocation(loc, myToken)
    sendLocationNUI(index)

    DoScreenFadeIn(FADE_BETWEEN_MS)
end

local function finishIntro()
    if not isIntroActive then return end
    isIntroActive = false

    -- Invalidate all running camera threads
    camToken = camToken + 1

    SendNUIMessage({ action = "hide" })
    SetNuiFocus(false, false)

    DoScreenFadeOut(500)
    Wait(550)

    destroyActiveCam(true)
    Wait(50)

    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true, false)

    DoScreenFadeIn(800)

    TriggerServerEvent('hkn_welcome:server:markWatched')
end

-- ─── NUI callbacks ─────────────────────────────────────────────────────────

RegisterNUICallback('next', function(data, cb)
    cb({})
    if not isIntroActive then return end
    if currentIndex < totalLocations then
        CreateThread(function()
            showLocation(currentIndex + 1)
        end)
    end
end)

RegisterNUICallback('back', function(data, cb)
    cb({})
    if not isIntroActive then return end
    if currentIndex > 1 then
        CreateThread(function()
            showLocation(currentIndex - 1)
        end)
    end
end)

RegisterNUICallback('skip', function(data, cb)
    cb({})
    CreateThread(function()
        finishIntro()
    end)
end)

-- ─── Network events ────────────────────────────────────────────────────────

RegisterNetEvent('hkn_welcome:client:startIntro', function()
    isIntroActive = true
    currentIndex  = 1

    -- Fade out before hiding ped so the player doesn't see a flash
    DoScreenFadeOut(400)
    Wait(450)

    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, false, false)

    SendNUIMessage({
        action     = "setTheme",
        themeColor = Config.ThemeColor
    })

    SendNUIMessage({
        action  = "setupLocales",
        locales = locale
    })

    SetNuiFocus(true, true)

    -- Start first location directly (bypasses showLocation's between-scene fade
    -- since startIntro already handled the initial fade above)
    camToken = camToken + 1
    local myToken = camToken

    playCamerasForLocation(Config.Locations[1], myToken)
    sendLocationNUI(1)

    DoScreenFadeIn(600)
end)

RegisterNetEvent('hkn_welcome:client:alreadyWatched', function()
    -- Player already watched; nothing to show
end)

-- ─── Initial handshake ─────────────────────────────────────────────────────

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(500)
    end
    Wait(1000)
    TriggerServerEvent('hkn_welcome:server:checkWatched')
end)