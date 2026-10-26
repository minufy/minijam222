Ending = {}
Ending.__index = Ending

local light_radius = 30

Image.new("ending")

function Ending.new(data)
    local self = setmetatable({}, Ending)
    self.x = data.x
    self.y = data.y
    self.w = Image.ending:getWidth()
    self.h = Image.ending:getHeight()

    self.cam_x = self.x-light_radius
    self.cam_y = self.y-light_radius
    self.cam_w = self.w+light_radius*2
    self.cam_h = self.h+light_radius*2
    return self
end

function Ending:draw()
    love.graphics.setColor(1, 1, 1, LIGHT_ALPHA)
    love.graphics.setBlendMode("add")
    love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius*0.6)
    love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius)
    love.graphics.setBlendMode("alpha")
    Color.reset()
    love.graphics.draw(Image.ending, self.x, self.y)
end

return Ending
