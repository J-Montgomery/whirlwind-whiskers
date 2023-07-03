
import "utility/TextLayout"
import "utility/TokenBucket"
import "Menu"

local counterUpdateLock = TokenBucket(1)
local counter = 0

class('CounterScreen').extends(Menu)

function CounterScreen:UpdateScreen()
    if(counterUpdateLock:run() == true) then
        local UIString = string.format("Seconds Elapsed: %d", counter)
        gfx.clear(gfx.kColorWhite)
        gfx.drawText(UIString, TextCol1, TextRow1)
        counter += 1
    end

    return true
end
