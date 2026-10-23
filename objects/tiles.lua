local auto_tile_order = {
    "x",
    "dx",
    "adx",
    "ax",
    "qwadx",
    "adxc",
    "adzx",
    "weadx",
    "dxc",
    "wadzxc",
    "adzxc",
    "azx",
    "wx",
    "wdx",
    "wadx",
    "wax",
    "wdxc",
    "weadzxc",
    "qwadzxc",
    "wazx",
    "wedxc",
    "weadzx",
    "-",
    "qwadzx",
    "w",
    "wd",
    "wad",
    "wa",
    "wedx",
    "qweadxc",
    "qweadzx",
    "qwax",
    "weadxc",
    "qweadzxc",
    "qwadxc",
    "qwazx",
    "",
    "d",
    "ad",
    "a",
    "wadzx",
    "wead",
    "qwad",
    "wadxc",
    "wed",
    "qwead",
    "qweadx",
    "qwa",
}
local auto_tile_checks = {}
for i=1, 48 do
    auto_tile_checks[auto_tile_order[i]] = i
end

local move_x = {-1, 0, 1, -1, 1, -1, 0, 1}
local move_y = {-1, -1, -1, 0, 0, 1, 1, 1}
local move_name = {"q", "w", "e", "a", "d", "z", "x", "c"}

local col_tiles = {
    "tile"
}

Tiles = {}
Tiles.__index = Tiles
SetType(Tiles, "tiles")

local around_offsets
GROUND_LEVEL = 0

function Tiles.new(data)
    local self = setmetatable({}, Tiles)
    self.tiles = data.data
    self.tiles_i = {}
    self.cells_x = data.gridCellsX
    self.cells_y = data.gridCellsY
    around_offsets = {
        0,
        -1,
        1,
        -self.cells_x,
        self.cells_x,
        -self.cells_x+1,
        self.cells_x-1,
        -self.cells_x-1,
        self.cells_x+1,
    }
    self.col_tiles = ToDict(col_tiles)
    self:init_tiles()
    return self
end

function Tiles:init_tiles()
    for i, tile in ipairs(self.tiles) do
        if tile ~= -1 then
            local x = (i-1)%self.cells_x
            local y = math.floor((i-1)/self.cells_x)
            self.tiles_i[i] = self:auto_tile(tile, x, y)
            GROUND_LEVEL = math.max(GROUND_LEVEL, y*TILE_SIZE)
        end
    end
end

function Tiles:around(x, y)
    local i = x+y*self.cells_x+1
    local found = {}
    for _, o in ipairs(around_offsets) do
        local j = i+o
        if 1 <= j and j <= #self.tiles then
            if self.col_tiles[TILE_NAMES[self.tiles[j]+1]] then
                if self.tiles[j] ~= -1 then
                    local ax = (j-1)%self.cells_x
                    local ay = math.floor((j-1)/self.cells_x)
                    table.insert(found, {x = ax*TILE_SIZE, y = ay*TILE_SIZE, w = TILE_SIZE, h = TILE_SIZE})
                end
            end
        end
    end
    return found
end

function Tiles:draw()
    for i, tile in ipairs(self.tiles) do
        if tile ~= -1 then
            local x = (i-1)%self.cells_x
            local y = math.floor((i-1)/self.cells_x)
            local tx = x*TILE_SIZE
            local ty = y*TILE_SIZE
            local type = TILE_NAMES[tile+1]
            love.graphics.draw(Image[type], TILE_QUADS[type][auto_tile_checks[self.tiles_i[i]]], tx, ty)
        end
    end
end

function Tiles:auto_tile(t, x, y)
    local moves = {}
    for i = 1, 8 do
        local mx, my = x+move_x[i], y+move_y[i]
        local j = mx+my*self.cells_x+1
        local mt = self.tiles[j]
        if mx <= 0 or mx >= self.cells_x or my <= 0 or my >= #self.tiles/self.cells_x then
            moves[move_name[i]] = true
        else
            if self.col_tiles[TILE_NAMES[t+1]] then
                moves[move_name[i]] = mt == t
            else
                moves[move_name[i]] = mt ~= -1
            end
        end
    end
    if not (moves["w"] and moves["a"]) then moves["q"] = false end
    if not (moves["w"] and moves["d"]) then moves["e"] = false end
    if not (moves["x"] and moves["a"]) then moves["z"] = false end
    if not (moves["x"] and moves["d"]) then moves["c"] = false end
    local pattern = ""
    for i = 1, 8 do
        local name = move_name[i]
        if moves[name] then
            pattern = pattern..name
        end
    end
    return pattern
end


return Tiles
