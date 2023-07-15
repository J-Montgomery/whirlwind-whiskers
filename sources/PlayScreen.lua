
import "utility/TextLayout"
import "utility/Physics"
import "Menu"

class('PlayScreen').extends(Menu)

local switchingToActive = true
function Menu:UpdateState(isActive)
    if (isActive == true and switchingToActive == true) then
        switchingToActive = false

        local imageCircle = gfx.image.new("images/circle")
        -- spawn a bunch of objects
        for i = 1, 5 do
            local spriteCircle = gfx.sprite.new(imageCircle)
            local obj = PhysicsObject(spriteCircle, 1, {40 * i, 5}, {0, .1}, {0, .1})
            PhysicsAddObject(obj)
        end

        local spriteCircle2 = gfx.sprite.new(imageCircle)
        local obj2 = PhysicsObject(spriteCircle2, 1, {100, 100}, {.5, -0.3}, {0, .1})
        PhysicsAddObject(obj2)
    elseif isActive == false then
        for idx, physicsObject in pairs(ActivePhysicsEntities) do
            PhysicsRemoveObject(idx)
            switchingToActive = true
        end
    end

    return true
end

function PlayScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)

    for idx, physicsObject in pairs(ActivePhysicsEntities) do
        physicsObject:render()
        gfx.sprite.update()
    end

    return true
end
