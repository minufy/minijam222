local dists = {
    spike = TILE_SIZE*0.5,
    item = TILE_SIZE*0.9,
}

return function (Player)
    function Player:init_collision()
        Game:dist(self, FILTERS.checkpoint, self.col_init_checkpoint, dists.item)
    end

    function Player:update_collision(dt)
        Game:dist(self, FILTERS.spike, self.col_spike, dists.spike)
        Game:dist(self, FILTERS.soul, self.col_soul, dists.item)
        Game:dist(self, FILTERS.checkpoint, self.col_checkpoint, dists.item)
        Game:dist(self, FILTERS.key, self.col_key, dists.item)

        if self.y > Game:tile_height() then
            self:die()
        end
    end

    function Player:col_spike(other)
        self:die()
    end

    function Player:col_key(other)
        self:get_key(other)
        other:die()
    end

    function Player:col_soul(other)
        if other.active then
            self:soul_activate()
            other:activate()
        end
    end

    function Player:col_checkpoint(other)
        if other.active then
            self:checkpoint(other)
            other:activate()
        end
    end

    function Player:col_init_checkpoint(other)
        other.active = false
    end

    function Player:get_key(key)
        Game:get_key(key)
        for _ = 1, 4 do
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-20, 20), math.random(-20, 20), math.random(8, 10)))
        end
        Camera:shake(3)
    end

    function Player:checkpoint(checkpoint)
        Game:set_checkpoint(checkpoint)
        for _ = 1, 4 do
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-20, 20), math.random(-20, 20), math.random(8, 10)))
        end
        Camera:shake(3)
    end

    function Player:die()
        for _ = 1, 4 do
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-20, 20), math.random(-20, 20), math.random(8, 20)))
        end
        self.remove = true
        Camera:shake(4)
        SM:set_fade(function ()
            Game:reset()
        end)
        Audio.play("die", RandomPitch())
    end
end
