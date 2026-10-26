local draw_order = {
    "tiles_back",
    "decal",
    "particle",
    "spark_paritcle",
    "player",
    "soul",
    "checkpoint",
    "key",
    "door",
    "tiles",
    "text",
    "spike",
    "moving_spike",
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
                    if object.cam_x then x = object.cam_x end
                    if object.cam_y then y = object.cam_y end
                    if object.cam_w then w = object.cam_w end
                    if object.cam_h then h = object.cam_h end
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
