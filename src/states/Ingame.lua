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
  require("states.Fader").fadeTo( globals.states.SplashScreen(), 0.3, 0.3 )
end


function IngameState:destroy()
  -- let the GC deallocate images that we don't need anymore
  globals.images.background = nil
  globals.images.tree = nil
end

return IngameState
