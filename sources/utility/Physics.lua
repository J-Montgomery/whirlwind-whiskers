import "CoreLibs/timer"
import "CoreLibs/object"

local physicsTimer = nil
local physicsFrameTime = 100
local shapeRectangle, shapeCircle = 1, 2

local activeEntities = {}

-- position, velocity, and acceleration are all 2d vectors {x, y}

class('PhysicsObject').extends()
function PhysicsObject:spawn(shape, mass, position, velocity, acceleration)
    self.width, self.height = 5, 5
    self.shape = shape
    self.mass = mass
    self.position = position
    self.velocity = velocity
    self.acceleration = acceleration
    self.isStatic = false
end

function PhysicsObject:getLeft()
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

function PhysicsObject:update()
    self.position[1] = self.position[1] + (self.velocity[1] * physicsFrameTime)
    self.position[2] = self.position[2] + (self.velocity[2] * physicsFrameTime)

    self.velocity[1] = self.velocity[1] + (self.acceleration[1] * physicsFrameTime)
    self.velocity[2] = self.velocity[2] + (self.acceleration[2] * physicsFrameTime)
end

function PhysicsObject:getPosition()
    return self.position
end

class('StaticPhysicsObject').extends(PhysicsObject)

function StaticPhysicsObject:spawn(mass, position)
    StaticPhysicsObject.super.spawn(mass, position, 0, 0)
    self.isStatic = true
end

function StaticPhysicsObject:update()
    -- Static objects don't move
    return
end

function PhysicsUpdate()
    print("physics callback")
end

function StartPhysicsLoop()
    physicsTimer = playdate.timer.new(physicsFrameTime, PhysicsUpdate)
    physicsTimer.repeats = true
    -- print(string.format("timer %s", tostring(physicsTimer)))
end

function PhysicsAddObject(physicsObject)
    table.insert(activeEntities, physicsObject)
end

function PhysicsRemoveObject(index)
    table.remove(activeEntities, index)
end
