import "Menu"

class('PauseScreen').extends(Menu)

function PauseScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Paused", 95, 100)

    return true
end
