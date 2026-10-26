Ending = {}

local ending_time = 2*60
function Ending:init()
    Audio.stop("music")
    Audio.play("ending")
    self.ending_timer = 0
end

function Ending:update(dt)
    self.ending_timer = self.ending_timer+dt
end

function Ending:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, Res.w, Res.h)
    Color.reset()
    if self.ending_timer >= ending_time then
        local s = "thank you for playing!"
        love.graphics.setFont(Font)
        love.graphics.print(s, Res.w/2-Font:getWidth(s)/2, Res.h/2-Font:getHeight()/2)
        s = "made by minufy"
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.print(s, Res.w/2-Font:getWidth(s)/2, Res.h-Font:getHeight()*2)
        Color.reset()
    end
end

return Ending
