local draw_order = {
    "decal",
    "particle",
    "player",
    "spark_paritcle",
    "tiles",
    "spike",
}

return function (Scene)
    function Scene:draw_objects()
        for _, group_name in ipairs(draw_order) do
            if self.objects[group_name] ~= nil then
                for _, object in ipairs(self.objects[group_name]) do
                    local visible
                    local x, y, w, h = object.x, object.y, object.w, object.h
                    if group_name == "tiles" then
                        visible = true
                    else
                        visible = Camera:check_vis(x, y, w, h)
                    end
                    if visible then
                        if object.draw then
                            object:draw()
                        end
                    end
                end
            end
        end
    end
end
