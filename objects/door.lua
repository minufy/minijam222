Door = {}
Door.__index = Door

Image.new("door")

function Door.new(data)
    local self = setmetatable({}, Door)
    self.x = data.x
    self.y = data.y
    self.w = Image.door:getWidth()
    self.h = Image.door:getHeight()

    self.id = data.values.id
    Game:register_connection(self)
    return self
end

function Door:draw()
    love.graphics.draw(Image.door, self.x, self.y)
end

function Door:activate()
	self.remove = true
	for _ = 1, 4 do
        Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-20, 20), math.random(-20, 20), math.random(8, 10)))
    end
end

return Door
