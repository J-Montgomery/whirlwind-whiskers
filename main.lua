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

local gameState = {}
local kGameInitialState, kGamePlayingState, kGamePauseState, kGameOverState = 1, 2, 3, 4
local currentGameState = kGameInitialState


local screens = {CounterScreen(), PlayScreen(), PauseScreen(), GameOverScreen()}

local inputHandlers = {
    AButtonDown = function() screens[currentGameState]:ButtonHandler_A(false, false) end,
    AButtonHeld = function() screens[currentGameState]:ButtonHandler_A(false, true) end,
    AButtonUp = function() screens[currentGameState]:ButtonHandler_A(true, false) end,

    BButtonDown = function() screens[currentGameState]:ButtonHandler_B(false, false) end,
    BButtonHeld = function() screens[currentGameState]:ButtonHandler_B(false, true) end,
    BButtonUp = function() screens[currentGameState]:ButtonHandler_B(true, false) end,

    downButtonDown = function() screens[currentGameState]:ButtonHandler_DPad(DPadDown, false) end,
    downButtonUp = function() screens[currentGameState]:ButtonHandler_DPad(DPadDown, true) end,

    leftButtonDown = function() screens[currentGameState]:ButtonHandler_DPad(DPadLeft, false) end,
    leftButtonUp = function() screens[currentGameState]:ButtonHandler_DPad(DPadLeft, true) end,

    rightButtonDown = function() screens[currentGameState]:ButtonHandler_DPad(DPadRight, false) end,
    rightButtonUp = function() screens[currentGameState]:ButtonHandler_DPad(DPadRight, true) end,

    upButtonDown = function() screens[currentGameState]:ButtonHandler_DPad(DPadUp, false) end,
    upButtonUp = function() screens[currentGameState]:ButtonHandler_DPad(DPadUp, true) end,

    cranked = function(change, acc) screens[currentGameState]:CrankHandler(change, acc) end,

}

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

    playdate.inputHandlers.push(inputHandlers)
end

function playdate.gameWillTerminate()
    playdate.inputHandlers.pop()
    playdate.datastore.write(save, "gamestate")
end

function playdate.deviceWillSleep()
    playdate.inputHandlers.pop()
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
