
import "TokenBucket"
import "Menu"

local counterUpdateLock = TokenBucket(1)
local counter = 0

class('CounterScreen').extends(Menu)

function CounterScreen:UpdateScreen()
    if(counterUpdateLock:run() == true) then
        local UIString = string.format("Seconds Elapsed: %d", counter)
        gfx.clear(gfx.kColorWhite)
        gfx.drawText(UIString, 95, 100)
        counter += 1
    end

    return true
end
