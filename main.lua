import "sources/TokenBucket"

playdate.graphics.drawText("Hello, World!", 95, 100)

local memory = {
    lastTime = playdate.getTime()
}

local UIUpdateSignal = TokenBucket(1)
local counter = 0

function playdate.gameWillTerminate()
    playdate.datastore.write(save, "memory")
end

function playdate.deviceWillSleep()
    playdate.datastore.write(save, "memory")
end

function playdate.update()
    memory.lastTime = playdate.getTime()

    if(UIUpdateSignal:run() == true) then
        local UIString = string.format("Seconds Elapsed: %d", counter)
        playdate.graphics.clear(playdate.graphics.kColorWhite)
        playdate.graphics.drawText(UIString, 95, 100)
        counter += 1
    end

    coroutine.yield()
end
