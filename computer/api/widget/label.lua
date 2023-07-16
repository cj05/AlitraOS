Object = {update=true,data = {pos = {1,1},text = "",bg = colors.black,fg = colors.white},type = "label"}

function Object:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end
function Object:setText(text)
    self.data.text = text
    --print(self.text)
    self.update = true
end
function Object:setPos(pos)
    self.data.pos = pos
    --print(self.text)
    self.update = true
end
function Object:setBackgroundColor(color)
    self.data.bg = color
    --print(self.text)
    self.update = true
end
function Object:setTextColor(color)
    self.data.fg = color
    --print(self.text)
    self.update = true
end
function Object:draw(data,old,cx,cy)
    if old then
        --erasal
        term.setCursorPos(old.pos[1]+cx,old.pos[2]+cy)
        term.write(string.rep(" ",#old.text))
    end
    term.setTextColor(data.fg)
    term.setBackgroundColor(data.bg)
    term.setCursorPos(data.pos[1]+cx,data.pos[2]+cy)
    term.write(data.text)
end

return Object