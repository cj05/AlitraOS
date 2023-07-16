Object = {update=true,data = {pos = {1,1},text = "",bg = colors.lightGray,bg2 = colors.gray,fg = colors.white},type = "Button",toggle = false,pressed = false,button = 1}

function Object:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end
function Object:setText(text)
    self.data.text = text
    self.update = true
end
function Object:setPos(pos)
    self.data.pos = pos
    self.update = true
end
function Object:setButtonColor(color)
    self.data.bg = color
    self.update = true
end
function Object:setPressedColor(color)
    self.data.bg2 = color
    self.update = true
end
function Object:setTextColor(color)
    self.data.fg = color
    self.update = true
end
function Object:bind(func)
    self.data.bind = func
end
function Object:tick(event,cx,cy)
    local x = self.data.pos[1] + cx
    local y = self.data.pos[2] + cy
    --print(x,y)
    local size = #(self.data.text or "")
    local bind = self.data.bind
    if(event[1] == "mouse_click" and event[2] == self.button and event[3] >= x and event[3] < x+size and event[4] == y)then
        if bind then bind(self,event) end
        self.pressed = true
        self.update = true
    end
    if(event[1] == "mouse_up" or (event[1] == "mouse_drag" and event[2]~=self.button))then
        if bind then bind(self,event) end
        self.pressed = false
        self.update = true
    end
end
function Object:draw(data,old,cx,cy)
    if old then
        --erasal
        term.setCursorPos(old.pos[1]+cx,old.pos[2]+cy)
        term.write(string.rep(" ",#old.text))
    end
    term.setTextColor(data.fg)
    if self.pressed then
        term.setBackgroundColor(data.bg2)
    else
        term.setBackgroundColor(data.bg)
    end
    term.setCursorPos(data.pos[1]+cx,data.pos[2]+cy)
    term.write(data.text)
end

return Object