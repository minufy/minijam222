local dists = {
    spike = TILE_SIZE*0.5,
    soul = TILE_SIZE*0.8,
    checkpoint = TILE_SIZE*0.8,
}

return function (Player)
    function Player:init_collision()

    end

    function Player:update_collision(dt)
        Game:dist(self, FILTERS.spike, self.col_spike, dists.spike)
        Game:dist(self, FILTERS.soul, self.col_soul, dists.soul)
        Game:dist(self, FILTERS.checkpoint, self.col_checkpoint, dists.checkpoint)
    end

    function Player:col_spike(other)
        self:die()
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
        -- Audio.play("die")
    end
end
