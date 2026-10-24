Game = {}

require("scenes.base.draw")(Game)
require("scenes.base.physics")(Game)
require("scenes.base.update")(Game)

function Game:init(level)
    self.current_level = level or 1
    self.last_checkpoint = nil
    Level:init()
    self:reset()
end

function Game:update(dt)
    if CONSOLE and Input.refresh.pressed then
        Level:refresh()
        self:reset()
    end

    Camera:update(dt)
    self:update_objects(dt)
end

function Game:draw()
    self:draw_bg()

    Shaders.shadow:start()
    Camera:start()

    self:draw_objects()

    Camera:stop()
    Shaders.shadow:stop()
end

---@generic T
---@param o T
---@return T
function Game:add(o)
    local group_name = tostring(o)
    if self.objects[group_name] == nil then
        self.objects[group_name] = {}
    end
    table.insert(self.objects[group_name], o)
    return o
end

function Game:reset()
    self.objects = {}
    Level:load_level(tostring(self.current_level), self)
    if self.last_checkpoint then
        self.player:start_checkpoint(self.last_checkpoint)
    end
end

function Game:tile_width()
    local tiles = self.objects.tiles[1]
    return tiles.cells_x*TILE_SIZE
end

function Game:tile_height()
    local tiles = self.objects.tiles[1]
    return tiles.cells_y*TILE_SIZE
end

function Game:set_checkpoint(checkpoint)
	self.last_checkpoint = {x = checkpoint.x, y = checkpoint.y}
end

return Game
