Soul = {}
Soul.__index = Soul

Image.new("soul")

function Soul.new(data)
    local self = setmetatable({}, Soul)
    self.x = data.x
    self.y = data.y
    self.w = Image.soul:getWidth()
    self.h = Image.soul:getHeight()
    self.particle_timer = Timer.new(4)
    self.deactive_timer = 0
    self.active = true
    return self
end

function Soul:update(dt)
    if self.deactive_timer > 0 then
        self.deactive_timer = self.deactive_timer-dt
        self.active = false
    else
        if self.particle_timer:run(dt) then
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-10, 10), math.random(-10, 10), math.random(2, 4)))
        end
        self.active = true
    end
end

local light_radius = 20
function Soul:draw()
    if self.active then
        love.graphics.setColor(1, 1, 1, 0.03)
        love.graphics.setBlendMode("add")
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius*0.6)
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius)
        love.graphics.setBlendMode("alpha")
        Color.reset()
        love.graphics.draw(Image.soul, self.x, self.y+SinEffect()*2)
    else
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.draw(Image.soul, self.x, self.y)
        Color.reset()
    end
end

local deactive_time = 100
function Soul:activate()
	self.deactive_timer = deactive_time
end

return Soul
