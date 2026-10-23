local draw_order = {
    "tiles_back",
    "decal",
    "particle",
    "player",
    "spark_paritcle",
    "tiles",
    "spike",
}
local tiles_back_alpha = 0.4

Image.new("bg")

return function (Scene)
    function Scene:draw_bg()
        love.graphics.draw(Image.bg)
    end

    function Scene:draw_objects()
        local tiles = self.objects["tiles"][1]
        for _, group_name in ipairs(draw_order) do
            local objects = self.objects[group_name]
            if group_name == "tiles" then
                tiles:draw(true)
            elseif group_name == "tiles_back" then
                love.graphics.setColor(1, 1, 1, tiles_back_alpha)
                tiles:draw(false)
                Color.reset()
            elseif objects ~= nil then
                for _, object in ipairs(objects) do
                    local x, y, w, h = object.x, object.y, object.w, object.h
                    if object.draw then
                        if Camera:check_vis(x, y, w, h) then
	                        object:draw()
                        end
                    end
                end
            end
        end
    end
end
