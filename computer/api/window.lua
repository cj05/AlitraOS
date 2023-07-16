
Frame = require "api/widget/frame"
--position is 1d table with index 1 and 2 as x and y
function Frame:Update()
    term.setBackgroundColor(self.data.bg)
    Frame:updateFrame(0,0)
end

windows = Frame:new()
windows:setSize({term.getSize()})
windows:setBackgroundColor(colors.black)
return windows:createFrame()