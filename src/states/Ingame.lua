local IngameState = require("states.GameState"):extend()

local sounds = require("lib.sounds")
local globals = GLOBALS

local musicNum = 1

function IngameState:new()
  self.music = sounds["music"..tostring(musicNum)]
  self.music:play()
end



function IngameState:update(dt)
  if globals.input:pressed("action") then
    require("states.Fader").fadeTo( globals.states.SplashScreen(), 0.3, 0.3 )
    
  elseif globals.input:pressed("switchMusic") then
    self.music:stop()
    sounds["music"..tostring(musicNum)] = nil
    -- ternary: (musicNum < 4) ? (musicNum + 1) : 1
    musicNum = (musicNum < 4) and (musicNum + 1) or 1
    self.music = sounds["music"..tostring(musicNum)]
    self.music:play()
  end
end



local lg = love.graphics
function IngameState:draw()
  lg.setColor(255,255,255)
  lg.draw(globals.images.background, 0, 0)
  lg.draw(globals.images.tree)
end



function IngameState:destroy()
  -- let the GC deallocate images that we don't need anymore
  globals.images.background = nil
  globals.images.tree = nil
  
  self.music:stop()
  self.music = nil
  sounds["music"..tostring(musicNum)] = nil
end

return IngameState
