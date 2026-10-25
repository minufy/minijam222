Checkpoint = {}
Checkpoint.__index = Checkpoint

Image.new("checkpoint")

local light_radius = 30

function Checkpoint.new(data)
    local self = setmetatable({}, Checkpoint)
    self.x = data.x
    self.y = data.y
    self.w = Image.checkpoint:getWidth()
    self.h = Image.checkpoint:getHeight()
    self.active = true

    self.cam_x = self.x-light_radius
    self.cam_y = self.y-light_radius
    self.cam_w = self.w+light_radius*2
    self.cam_h = self.h+light_radius*2
    return self
end

function Checkpoint:draw()
    if self.active then
        love.graphics.setColor(1, 1, 1, 0.03)
        love.graphics.setBlendMode("add")
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius*0.6)
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius)
        love.graphics.setBlendMode("alpha")
        Color.reset()
        love.graphics.draw(Image.checkpoint, self.x, self.y+SinEffect()*2)
    else
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.draw(Image.checkpoint, self.x, self.y)
        Color.reset()
    end
end

function Checkpoint:activate()
	self.active = false
end

return Checkpoint
