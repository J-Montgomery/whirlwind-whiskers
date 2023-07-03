import "CoreLibs/sprites"
import "CoreLibs/graphics"

import "sources/CounterScreen"
import "sources/PlayScreen"
import "sources/PauseScreen"
import "sources/GameOverScreen"

playdate.graphics.drawText("Hello, World!", 95, 100)

local gamestate = {
    lastTime = playdate.getTime()
}

gfx = playdate.graphics
spritelib = gfx.sprite
screenWidth = playdate.display.getWidth()
screenHeight = playdate.display.getHeight()

local gameState = {initial, playing, paused, over}
local kGameInitialState, kGamePlayingState, kGamePauseState, kGameOverState = 1, 2, 3, 4
local currentGameState = kGameInitialState


local screens = {CounterScreen(), PlayScreen(), PauseScreen(), GameOverScreen()}

local function toGameMode(mode)
    if mode >= kGameInitialState and mode <= kGameOverState then
        -- Notify the active menu that it's being paused
        screens[currentGameState]:UpdateState(false)
        currentGameState = mode
    end
end

local function OptionsMenuChangeMode()
    if currentGameState == kGameInitialState then
        toGameMode(kGamePlayingState)
    else
        toGameMode(kGameInitialState)
    end
end

local function initialize()
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, screenWidth, screenHeight)

    local menu = playdate.getSystemMenu()
    local menuItem, error = menu:addMenuItem("Mode", OptionsMenuChangeMode)

    for i, screen in ipairs(screens) do
        screen:Initialize()
    end
end

function playdate.gameWillTerminate()
    playdate.datastore.write(save, "gamestate")
end

function playdate.deviceWillSleep()
    playdate.datastore.write(save, "gamestate")
end

function playdate.update()
    gamestate.lastTime = playdate.getTime()

    if currentGameState >= kGameInitialState and currentGameState <= kGameOverState then
        screens[currentGameState]:UpdateState(true)
        screens[currentGameState]:UpdateScreen(true)
    else
        gfx.clear(gfx.kColorWhite)
        gfx.drawText("Unknown Mode", 95, 100)
    end

    coroutine.yield()
end

initialize()
