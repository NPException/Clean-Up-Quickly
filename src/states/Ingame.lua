local IngameState = require("states.GameState"):extend()

local globals = GLOBALS

function IngameState:new()
end



function IngameState:update(dt)

end



local lg = love.graphics
function IngameState:draw()
  lg.setColor(255,255,255)
  lg.draw(globals.images.background, 0, 0)
  lg.draw(globals.images.tree)
end



function IngameState:keypressed()

end

return IngameState
