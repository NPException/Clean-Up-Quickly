local IngameState = require("states.GameState"):extend()

local images = require("lib.images")

function IngameState:new()
end



function IngameState:update(dt)

end



local lg = love.graphics
function IngameState:draw()
  lg.setColor(255,255,255)
  lg.draw(images.background, 0, 0)
  lg.draw(images.tree)
end



function IngameState:keypressed()

end

return IngameState
