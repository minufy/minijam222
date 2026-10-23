local bounce_damp = 0.15
local light_radius = 40

Animation.new("player_idle", 1, 2, 50)
Animation.new("player_walk", 1, 4, 7)
Animation.new("player_jump", 1, 1, 0)

return function (Player)
    function Player:init_draw()
        self.flip = 1
        self.anim_state = "idle"
    end

    function Player:update_draw(dt)
        Animation.update("player_"..self.anim_state, dt)

        local flip = 0
        if Input.right.down then
            flip = flip+1
        end
        if Input.left.down then
            flip = flip-1
        end
        if flip ~= 0 then
            self.flip = flip
        end

        self.draw_bounce = self.draw_bounce-self.draw_bounce*bounce_damp*dt
    end

    function Player:draw_draw()
        love.graphics.setColor(1, 1, 1, 0.03)
        love.graphics.setBlendMode("add")
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius*0.6)
        love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, light_radius)
        love.graphics.setBlendMode("alpha")
        Color.reset()

        local sx = (1-self.draw_bounce)
        local sy = (1+self.draw_bounce)
        local ox = self.w*(1-self.flip*sx)/2
        local oy = -self.draw_bounce*self.h
        love.graphics.draw(Animation.get_frame("player_"..self.anim_state), self.x+ox, self.y+oy, 0, self.flip*sx, sy)
    end
end
