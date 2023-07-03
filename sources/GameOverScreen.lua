import "Menu"

class('GameOverScreen').extends(Menu)

function GameOverScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Game Over", 95, 100)

    return true
end
