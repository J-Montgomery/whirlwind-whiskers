import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local physicsTimer = nil
local physicsFrameTime = 33
ShapeRectangle, ShapeCircle = 1, 2
local imageRectangle
local imageCircle

ActivePhysicsEntities = {}

-- position, velocity, and acceleration are all 2d vectors {x, y}

local function clamp(val, lower, upper)
    return math.max(lower, math.min(upper, val))
end

class('PhysicsObject').extends()
function PhysicsObject:init(sprite, mass, position, velocity, acceleration)
    PhysicsObject.super.init(self)

    self.width = 5
    self.height = 5

    self.mass = mass
    self.position = position
    self.velocity = velocity
    self.acceleration = acceleration
    self.isStatic = false
    self.sprite = sprite

    -- if shape == ShapeRectangle then
    --     self.sprite = playdate.graphics.sprite.new(imageRectangle)
    --     --self:setImage(imageRectangle)
    -- elseif shape == ShapeCircle then
    --     self.sprite = playdate.graphics.sprite.new(imageCircle)
    --     --self:setImage(imageCircle)
    -- end

    local msgs = string.format("sprites [%s] [%s]", tostring(imageRectangle), tostring(self.sprite))
    print(msgs)

    --self.sprite.moveTo(self.sprite, self.position[1], self.position[2])
    self.sprite.add(self.sprite)
end

function PhysicsObject.getLeft()
    return self.position[1]
end

function PhysicsObject:getTop()
    return self.position[2]
end

function PhysicsObject:getRight()
    return self.position[1] + self.width
end

function PhysicsObject:getBottom()
    return self.position[2] + self.height
end

function PhysicsObject:teleport(newPosition)
    self.position = newPosition
end

function PhysicsObject:updatePhysics()
    self.position[1] = self.position[1] + (self.velocity[1] * physicsFrameTime)
    self.position[2] = self.position[2] + (self.velocity[2] * physicsFrameTime)

    self.velocity[1] = self.velocity[1] + (self.acceleration[1])
    self.velocity[2] = self.velocity[2] + (self.acceleration[2])

    -- This calculates the collision in screen space.
    -- Longer term, screen space and physics space will not necessarily be
    -- the same thing. Good enough as an MVP for now.
    -- todo: fix
    self.position[1] = clamp(self.position[1], 0, playdate.display.getWidth() - self.width - 1)
    self.position[2] = clamp(self.position[2], 0, playdate.display.getHeight() - self.height - 1)
end

function PhysicsObject:getPosition()
    return self.position
end

function PhysicsObject:teleport(newPosition)

    self.position = newPosition
end

function PhysicsObject:render(newPosition)
    self.sprite:moveTo(self.position[1], self.position[2])
    self.sprite.update()
end

class('StaticPhysicsObject').extends(PhysicsObject)

function StaticPhysicsObject:init(mass, position)
    StaticPhysicsObject.super.init(self, mass, position, 0, 0)
    self.isStatic = true
end

function StaticPhysicsObject:updatePhysics()
    -- Static objects don't move
    return
end

function PhysicsUpdate()
    for idx, physicsObject in pairs(ActivePhysicsEntities) do
        physicsObject:updatePhysics()
    end
end

function StartPhysicsLoop()
    imageRectangle = gfx.image.new("images/rectangle")

    imageCircle = gfx.image.new("images/circle")

    physicsTimer = playdate.timer.new(physicsFrameTime, PhysicsUpdate)
    physicsTimer.repeats = true
end

function PhysicsAddObject(physicsObject)
    table.insert(ActivePhysicsEntities, physicsObject)
end

function PhysicsRemoveObject(index)
    table.remove(ActivePhysicsEntities, index)
end
