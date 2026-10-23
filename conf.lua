WINDOW_W = 280
WINDOW_H = 240
CONSOLE = os.getenv("CONSOLE") == "true"

function love.conf(t)
    t.window.resizable = true
    t.console = CONSOLE
    t.window.width = WINDOW_W*3
    t.window.height = WINDOW_H*3
end
