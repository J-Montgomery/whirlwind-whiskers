
import "utility/TextLayout"
import "utility/TokenBucket"
import "Menu"

local HighlightTimer = TokenBucket(2)
local highlighted = 0

class('PlayScreen').extends(Menu)

function Menu:UpdateState(isActive)
    if(isActive == false) then
        -- Reset our Image drawing mode so that we don't mess up other menus
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    end

    return true
end

function PlayScreen:UpdateScreen()
    if(HighlightTimer:run() == true) then
        if(highlighted == false) then
            highlighted = true
            gfx.clear(gfx.kColorBlack)
            gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
            gfx.drawText("Highlighted", TextCol1, TextRow1)
        else
            highlighted = false
            gfx.clear(gfx.kColorWhite)
            gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
            gfx.drawText("Normal", TextCol1, TextRow1)
        end
    end

    return true
end
