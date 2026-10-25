return function (Scene)
    function Scene:update_objects(dt)
        for group_name, _ in pairs(self.objects) do
            local i = #self.objects[group_name]
            while i > 0 do
                local object = self.objects[group_name][i]
                if object.update then
                    object:update(dt)
                end
                if object.remove then
                    self.objects[group_name][i] = self.objects[group_name][#self.objects[group_name]]
                    self.objects[group_name][#self.objects[group_name]] = nil
                end
                i = i-1
            end
        end
    end

    function Scene:set_checkpoint(checkpoint)
    	self.last_checkpoint = {x = checkpoint.x, y = checkpoint.y}
    end

    function Scene:get_key(key)
        local connected = self.connected[key.id]
        if connected then
            connected:activate()
            self.connected[key.id] = nil
        end
    end

    function Scene:register_connection(object)
        self.connected[object.id] = object
    end
end
