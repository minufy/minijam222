return function ()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    Font = love.graphics.newFont("assets/fonts/Galmuri7.ttf", 8)

    Input.refresh = Input.new({"f5"})
    Input.fullscreen = Input.new({"f11"})

    Input.right = Input.new({"right", "d"})
    Input.left = Input.new({"left", "a"})
    Input.up = Input.new({"up", "w"})
    Input.down = Input.new({"down", "s"})
    Input.jump = Input.new({"space", "up", "w"})

    Audio.new("fade", 0.2)
    Audio.new("die", 0.2)
    Audio.new("jump", 0.3)
    Audio.new("land", 0.1)
    Audio.new("walk", 0.1)
    Audio.new("key", 0.3)
    Audio.new("checkpoint", 0.6)
    Audio.new("soul", 0.3)
    Audio.new("soul_end", 0.2)
    Audio.new("soul_reactive", 0.05)
    Audio.new("ending", 0.2)
    Audio.new("music", 0.2, {type = "stream", channel = "music", loop = true})

    Camera.x_damp = 0.1
    Camera.y_damp = 0.05
    Camera.shake_damp = 0.25

    COLORS = {

    }

    LIGHT_ALPHA = 0.02
    FILTERS = {
        spike = {"spike"},
        moving_spike = {"moving_spike"},
        soul = {"soul"},
        checkpoint = {"checkpoint"},
        key = {"key"},
        solid = {"door"},
        ending = {"ending"},
    }

    TILE_SIZE = 16
    TILE_NAMES = {
        "tile",
        "tile_back",
    }

    DECAL_NAMES = {
        "grass",
        "grass2",
        "grass3",
        "flower",
        "flower2",
        "mushroom",
        "mushroom2",
    }
end
