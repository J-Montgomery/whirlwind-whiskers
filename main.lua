import "CoreLibs/sprites"
import "CoreLibs/graphics"

import "sources/CounterScreen"
import "sources/PlayScreen"
import "sources/PauseScreen"
import "sources/GameOverScreen"
import "sources/GenericErrorScreen"
import "sources/HeatherGame"

playdate.graphics.drawText("Hello, World!", 95, 100)

local gamestate = {
    lastTime = playdate.getTime()
}

gfx = playdate.graphics
spritelib = gfx.sprite
screenWidth = playdate.display.getWidth()
screenHeight = playdate.display.getHeight()

local gameState = {}
local kGameInitialState, kGamePlayingState, kGamePauseState, kGameOverState, kHeatherState, kErrorState = 1, 2, 3, 4, 5, 6
local currentGameState = kHeatherState

local screens = {CounterScreen(), PlayScreen(), PauseScreen(), GameOverScreen(), HeatherGameScreen(), GenericErrorScreen()}

local inputHandlers = {
    AButtonDown = function() CurrentMenu():ButtonHandler_A(false, false) end,
    AButtonHeld = function() CurrentMenu():ButtonHandler_A(false,  true) end,
    AButtonUp   = function() CurrentMenu():ButtonHandler_A(true,  false) end,

    BButtonDown = function() CurrentMenu():ButtonHandler_B(false, false) end,
    BButtonHeld = function() CurrentMenu():ButtonHandler_B(false,  true) end,
    BButtonUp   = function() CurrentMenu():ButtonHandler_B(true,  false) end,

    downButtonDown = function() CurrentMenu():ButtonHandler_DPad(DPadDown, false) end,
    downButtonUp   = function() CurrentMenu():ButtonHandler_DPad(DPadDown,  true) end,

    leftButtonDown = function() CurrentMenu():ButtonHandler_DPad(DPadLeft, false) end,
    leftButtonUp   = function() CurrentMenu():ButtonHandler_DPad(DPadLeft,  true) end,

    rightButtonDown = function() CurrentMenu():ButtonHandler_DPad(DPadRight, false) end,
    rightButtonUp   = function() CurrentMenu():ButtonHandler_DPad(DPadRight,  true) end,

    upButtonDown = function() CurrentMenu():ButtonHandler_DPad(DPadUp, false) end,
    upButtonUp   = function() CurrentMenu():ButtonHandler_DPad(DPadUp,  true) end,

    cranked = function(change, acc) CurrentMenu():CrankHandler(change, acc) end,
}

local function toGameMode(mode)
    if mode >= kGameInitialState and mode <= kErrorState then
        -- Notify the active menu that it's being paused
        CurrentMenu():UpdateState(false)
        currentGameState = mode

        -- Notify the new menu that it's active
        CurrentMenu():UpdateState(true)
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

function CurrentMenu()
    return screens[currentGameState]
end

function ToErrorMode(reason)
    -- set the error reason preemptively so that when we switch,
    -- the error message is displayed immediately
    screens[kErrorState]:SetErrorReason(reason)
    toGameMode(kErrorState)
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

    if currentGameState >= kGameInitialState and currentGameState <= kErrorState then
        CurrentMenu():UpdateState(true)
        CurrentMenu():UpdateScreen(true)
    else
        ToErrorMode("Unknown game state")
    end

    coroutine.yield()
end

initialize()
