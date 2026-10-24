local dists = {
    spike = TILE_SIZE*0.5,
    soul = TILE_SIZE*0.8,
}

return function (Player)
    function Player:init_collision()

    end

    function Player:update_collision(dt)
        Game:dist(self, FILTERS.spike, self.col_spike, dists.spike)
        Game:dist(self, FILTERS.soul, self.col_soul, dists.soul)
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

    function Player:die()
        for _ = 1, 4 do
            Game:add(Particle.new(self.x+self.w/2, self.y+self.h/2, math.random(-10, 10), math.random(-10, 10), math.random(8, 14)))
        end
        self.remove = true
        Camera:shake(3)
        -- Audio.play("die")
    end
end
