Sep = {}
Sep.__index = Sep

function Sep.new(data)
    local self = setmetatable({}, Sep)
    self.x = data.x
    self.y = data.y
    self.w = data.width or TILE_SIZE
    self.h = data.height or TILE_SIZE
    return self
end

return Sep
