import "Menu"

class('HeatherGameScreen').extends(Menu)

local catName = nil

function HeatherGameScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.drawText("Kittens Rule", 0, 0)
    gfx.drawText("What's your name?", 0, 20)
    gfx.drawText("(A) Heather", 0, 40)
    gfx.drawText("(B) Coco", 0, 60)

    if (catName ~= nil) then
        if(catName == "Heather") then
            local UIString = string.format("Hello there, %s!", catName)
            gfx.drawText(UIString, 0, 100)
        else
            local UIString = string.format("%s go away!", catName)
            gfx.drawText(UIString, 0, 100)
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
