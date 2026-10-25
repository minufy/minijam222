Key = {}
Key.__index = Key

Image.new("key")

local light_radius = 30

function Key.new(data)
    local self = setmetatable({}, Key)
    self.x = data.x
    self.y = data.y
    self.w = Image.key:getWidth()
    self.h = Image.key:getHeight()

    self.id = data.values.id

    self.cam_x = self.x-light_radius
    self.cam_y = self.y-light_radius
    self.cam_w = self.w+light_radius*2
    self.cam_h = self.h+light_radius*2
    return self
end

function Key:draw()
    love.graphics.setColor(1, 1, 1, LIGHT_ALPHA)
    love.graphics.setBlendMode("add")
    love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius*0.6)
    love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius)
    Color.reset()
    love.graphics.setBlendMode("alpha")

    love.graphics.draw(Image.key, self.x, self.y)
end

function Key:die()
    Audio.play("key", RandomPitch())
	self.remove = true
end

return Key
