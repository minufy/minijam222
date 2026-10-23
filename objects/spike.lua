Spike = {}
Spike.__index = Spike

Image.new("spike")

function Spike.new(data)
    local self = setmetatable({}, Spike)
    self.draw_x = data.x
    self.draw_y = data.y
    self.r = data.rotation
    self.sin = math.sin(self.r)
    self.cos = math.cos(self.r)
    self.x = data.x
    self.y = data.y
    if self.sin == 1 or self.cos == -1 then
        self.x = self.x-TILE_SIZE
    end
    if self.sin == -1 or self.cos == -1 then
        self.y = self.y-TILE_SIZE
    end
    self.w = TILE_SIZE
    self.h = TILE_SIZE
    return self
end

function Spike:draw()
    love.graphics.draw(Image.spike, self.draw_x, self.draw_y, self.r)
end

return Spike
