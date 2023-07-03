import "utility/TextLayout"
import "Menu"

class('GameOverScreen').extends(Menu)

function GameOverScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Game Over", TextCol1, TextRow1)

    return true
end
