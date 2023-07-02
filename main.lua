import "CoreLibs/sprites"
import "CoreLibs/graphics"

import "sources/CounterScreen"

playdate.graphics.drawText("Hello, World!", 95, 100)

local gamestate = {
    lastTime = playdate.getTime()
}

gfx = playdate.graphics
spritelib = gfx.sprite
screenWidth = playdate.display.getWidth()
screenHeight = playdate.display.getHeight()

local gameState = {initial, playing, paused, over}
local kGameInitialState, kGamePlayingState, kGamePausedState, kGameOverState = 0, 1, 2, 3
local currentGameState = kGameInitialState

local function toMode(mode)
    if mode >= kGameInitialState and mode <= kGameOverState then
        currentGameState = mode
    end
end

local function OptionsMenuChangeMode()
    print("Menu item invoked")
    if currentGameState == kGameInitialState then
        toMode(kGamePausedState)
    else
        toMode(kGameInitialState)
    end
end

local function initialize()
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, screenWidth, screenHeight)

    local menu = playdate.getSystemMenu()
    local menuItem, error = menu:addMenuItem("Mode", OptionsMenuChangeMode)
end

function playdate.gameWillTerminate()
    playdate.datastore.write(save, "gamestate")
end

function playdate.deviceWillSleep()
    playdate.datastore.write(save, "gamestate")
end

function playdate.update()
    gamestate.lastTime = playdate.getTime()

    if(currentGameState == kGameInitialState) then
        RenderCounterScreen()
    elseif currentGameState == kGamePausedState then
        gfx.clear(gfx.kColorWhite)
        gfx.drawText("Paused", 95, 100)
    else
        gfx.clear(gfx.kColorWhite)
        gfx.drawText("Unknown Mode", 95, 100)
    end


    coroutine.yield()
end

initialize()
