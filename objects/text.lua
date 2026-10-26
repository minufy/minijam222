Text = {}
Text.__index = Text

function Text.new(data)
    local self = setmetatable({}, Text)
    self.text = data.values.text
    self.x = data.x
    self.y = data.y
    self.w = Font:getWidth(self.text)
    self.h = Font:getHeight()
    return self
end

function Text:draw()
    love.graphics.setFont(Font)
    love.graphics.print(self.text, self.x, self.y)
end

return Text
