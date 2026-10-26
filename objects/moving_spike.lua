MovingSpike = {}
MovingSpike.__index = MovingSpike

Image.new("moving_spike")

function MovingSpike.new(data)
    local self = setmetatable({}, MovingSpike)
    self.rw = data.width/2
    self.rh = data.height/2
    self.ox = data.x+self.rw
    self.oy = data.y+self.rh
    self.w = Image.moving_spike:getWidth()
    self.h = Image.moving_spike:getHeight()
    self.x = self.ox-self.w/2
    self.y = self.oy-self.h/2
    self.axis = data.values.axis
    self.phase = data.values.phase
    self.speed = TILE_SIZE*10/math.max(self.rw, self.rh)
    self.timer = 0
    return self
end

function MovingSpike:update(dt)
    self.timer = self.timer+dt/60
    local timer = self.timer*self.speed+self.phase
    if self.axis == "x" then
        self.x = self.ox+math.cos(timer)*self.rw-self.w/2
    end
    if self.axis == "y" then
        self.y = self.oy+math.sin(timer)*self.rh-self.h/2
    end
end

function MovingSpike:draw()
    love.graphics.draw(Image.moving_spike, self.x, self.y)
end

return MovingSpike
