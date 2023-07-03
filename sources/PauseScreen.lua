import "utility/TextLayout"
import "Menu"

class('PauseScreen').extends(Menu)

function PauseScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Paused", TextCol1, TextRow1)

    return true
end
