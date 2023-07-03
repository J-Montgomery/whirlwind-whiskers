import "utility/TextLayout"
import "Menu"

class('HeatherGameScreen').extends(Menu)

local catName = nil

function HeatherGameScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Kittens Rule", TextCol1, TextRow1)
    gfx.drawText("What's your name?", TextCol1, TextRow2)
    gfx.drawText("(A) Heather", TextCol1, TextRow3)
    gfx.drawText("(B) Coco", TextCol1, TextRow4)

    if (catName ~= nil) then
        if(catName == "Heather") then
            local UIString = string.format("Hello there, %s!", catName)
            gfx.drawText(UIString, TextCol1, TextRow6)
        else
            local UIString = string.format("%s go away!", catName)
            gfx.drawText(UIString, TextCol1, TextRow6)
        end
    end

    return true
end

function Menu:ButtonHandler_A(isPressed, held)
    catName = "Heather"
end

function Menu:ButtonHandler_B(isPressed, held)
    catName = "Coco"
end

-- print('kittens rule')
-- io.write("What's your name?")
-- name = io.read()
-- if name == "Heather" then
--     io.write("Hello there, " .. name .. "!")
-- else
--     print("Coco go away!")
-- end
