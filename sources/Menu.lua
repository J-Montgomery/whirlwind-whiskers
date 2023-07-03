import "CoreLibs/object"

class('Menu').extends()

DPadUp, DPadDown, DPadLeft, DPadRight = 1, 2, 3, 4

function Menu:Initialize()
    return true
end

function Menu:UpdateState(isActive)
    return true
end

function Menu:UpdateScreen()

    return true
end


function Menu:ButtonHandler_A(isPressed, held)
    output = string.format("A Pressed: %s, Held: %s", tostring(isPressed), tostring(held))
    print(output)
end

function Menu:ButtonHandler_B(isPressed, held)
    output = string.format("B Pressed: %s, Held: %s", tostring(isPressed), tostring(held))
    print(output)
end

function Menu:ButtonHandler_DPad(button, isPressed)
    output = string.format("DPad Button %s Pressed: %s", tostring(button), tostring(isPressed))
    print(output)
end

function Menu:CrankHandler(change, acceleration)
    output = string.format("Crank change: %s, acc: %s", tostring(change), tostring(acceleration))
    print(output)
end
