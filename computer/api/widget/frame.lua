local Label = require "api/widget/label"
local Button = require "api/widget/button"
local pretty = require "cc.pretty"
Object = {update=true,type = "label"}

setmetatable(Object, Window)

local function copy(target,source)
    for x,c in pairs(source) do
        if(type(c) == "table") then
            target[x] = {}
            copy(target[x],c)
        else
            target[x] = c
        end
    end
end

--Object.Object = {}
function Object:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    o.data = {}
    copy(o.data, {pos = {1,1},size = {1,1},bg = colors.black})
    return o
end
function Object:setPos(pos)
    self.data.pos = pos
    --print(self.text)
    self.update = true
end
function Object:setSize(pos)
    self.data.size = pos
    --print(self.text)
    self.update = true
end
function Object:setBackgroundColor(color)
    self.data.bg = color
    --print(self.text)
    self.update = true
    --self:draw(self.data,self.data)
end
function Object:draw(data,old,cx,cy)
    term.setCursorPos(1,10)
    pretty.pretty_print(old)
    if old then
        --erasal
        term.setCursorPos(old.pos[1]+cx,old.pos[2]+cy)
        for i = 1,old.size[2] do
            term.setCursorPos(old.pos[1]+cx,old.pos[2]+i-1+cy)
            term.write(string.rep(" ",old.size[1]))
        end
    end
    term.setBackgroundColor(data.bg)
    for i = 1,data.size[2] do
        term.setCursorPos(data.pos[1]+cx,data.pos[2]+i-1+cy)
        term.write(string.rep(" ",data.size[1]))
    end
end

function Object:createLabel(text,pos)
    NewLabel = Label:new()
    NewLabel:setText(text or "")
    NewLabel:setPos(pos or {1,1})
    if not self.Object then self.Object = {} end
    self.Object[#self.Object+1]=NewLabel
    return NewLabel
end
function Object:createButton(text,pos)
    NewButton = Button:new()
    NewButton:setText(text or " ")
    NewButton:setPos(pos or {1,1})
    if not self.Object then self.Object = {} end
    self.Object[#self.Object+1]=NewButton
    return NewButton
end
function Object:createFrame(text,pos)
    NewFrame = Object:new()
    if not self.Object then self.Object = {} end
    self.Object[#self.Object+1]=NewFrame
    return NewFrame
end



function Object:updateFrame(cx,cy)
    
    if self.update then 
        self:draw(self.data,self.data,cx,cy) 
        self.update=false 
        for i,v in pairs(self.Object) do v.update = true end
    end

    cx = cx+self.data.pos[1]-1
    cy = cy+self.data.pos[2]-1
    if not self.Object then self.Object = {} end
    for i,v in pairs(self.Object) do
        --print(v.text)
        if not self.Old then self.Old = {} end
        if(v.update) then
            v.update = false--update
            term.setBackgroundColor(self.data.bg)
            v:draw(v.data,self.Old[i],cx,cy)
            if not self.Old[i] then self.Old[i] = {} end
            copy(self.Old[i],v.data)
        end
        if v.updateFrame then v:updateFrame(cx,cy) end
        if v.event then v.tick() end
    end
end

function Object:eventHandler(event,cx,cy)
    cx = (cx or 0) + self.data.pos[1] - 1
    cy = (cy or 0) + self.data.pos[2] - 1
    for i,v in pairs(self.Object) do
        if v.tick then
            v:tick(event,cx,cy)
        end
        if v.eventHandler then v:eventHandler(event,cx,cy) end
    end
end

return Object