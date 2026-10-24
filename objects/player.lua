Player = {}
Player.__index = Player

require("objects.player.movement")(Player)
require("objects.player.draw")(Player)
require("objects.player.collision")(Player)

function Player.new(data)
    local self = setmetatable({}, Player)
    self.x = data.x-data.originX
    self.y = data.y-data.originY
    self.w = Image.player_idle1:getWidth()
    self.h = Image.player_idle1:getHeight()

    self:init_collision()
    self:init_draw()
    self:init_movement()

    self:update_cam()
    self:init_cam()
    Game.player = self
    return self
end

function Player:init_cam()
    Camera:offset(Res.w/2, Res.h/2)
    Camera:set(self.cam_x, self.cam_y)
    Camera:snap_back()
end

function Player:start_checkpoint(checkpoint)
	self.x = checkpoint.x
	self.y = checkpoint.y+TILE_SIZE-self.h
    self:update_cam()
    self:init_cam()
end

function Player:update_cam()
    self.cam_x = math.clamp(self.x+self.w/2, Res.w/2, Game:tile_width()-Res.w/2)
    self.cam_y = math.clamp(self.y+self.h/2, Res.h/2, Game:tile_height()-Res.h/2)
end

function Player:update(dt)
    self:update_cam()
    self:update_collision(dt)
    self:update_draw(dt)
    self:update_movement(dt)

    -- set camera after collision
    Camera:set(self.cam_x, self.cam_y)
end

function Player:draw()
    self:draw_draw()
end

return Player
