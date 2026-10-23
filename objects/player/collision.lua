local dists = {
    spike = TILE_SIZE*0.5,
}

return function (Player)
    function Player:init_collision()

    end

    function Player:update_collision(dt)
        Game:dist(self, FILTERS.spike, self.col_spike, dists.spike)
    end

    function Player:col_spike(other)
        self:die()
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
