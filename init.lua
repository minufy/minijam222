return function ()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    Font = love.graphics.newFont("assets/fonts/Galmuri9.ttf", 10)

    Input.refresh = Input.new({"f5"})
    Input.fullscreen = Input.new({"f11"})

    Input.right = Input.new({"right", "d"})
    Input.left = Input.new({"left", "a"})
    Input.up = Input.new({"up", "w"})
    Input.down = Input.new({"down", "s"})
    Input.jump = Input.new({"space", "up", "w"})

    Audio.new("jump")

    Color.bg = rgb(5, 1, 59)

    Camera.x_damp = 0.1
    Camera.y_damp = 0.05
    Camera.shake_damp = 0.2

    FILTERS = {
        spike = {"spike"},
        soul = {"soul"},
        checkpoint = {"checkpoint"},
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
