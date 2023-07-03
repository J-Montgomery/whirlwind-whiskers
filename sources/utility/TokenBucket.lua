
import "CoreLibs/object"

class('TokenBucket', {rate = 0, timestamp = 0, tokens = 0}).extends()

function TokenBucket:init(tokenRate)
    self.rate = tokenRate
    self.timestamp = playdate.getCurrentTimeMilliseconds()
    self.tokens = 0
end

function TokenBucket:run()
    local currentTime = playdate.getCurrentTimeMilliseconds()
    local duration = (currentTime - self.timestamp)/1000

    if(duration >= (1/self.rate)) then
        self.tokens += math.floor(duration * self.rate)
        self.timestamp = currentTime
    else
        return false
    end

    if self.tokens > self.rate then
        self.tokens = self.rate
    end
    if self.tokens >= 1 then
        self.tokens -= 1
        return true
    else
        self.tokens = 0
        return false
    end
end
