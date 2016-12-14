local Fader = {}
Fader.__index = function (table, key)
  local faderValue = Fader[key]
  -- if there is a value explicitly declared in Fader we return it, otherwise we just hand out the wrapped state's value
  return faderValue and faderValue or table.state[key]
end

local setColor = love.graphics.setColor
local fill = love.graphics.rectangle
local floor = math.floor

--[[
  Creates a new fader state, that will fade from/to the given colors with in the given amount of time.
  After the fade is complete, it will execute the doneCallback function.
]]--
function Fader.create( state, fadeIn, duration, target, colors )
  local self = setmetatable({}, Fader)
  self._isFader = true
  self.state = state
  self.fadeIn = fadeIn
  self.colors = colors or {0,0,0}
  self.alpha = fadeIn and 255 or 0
  self.duration = duration
  self.target = target
  return self
end

function Fader.fadeTo( target, fadeOutTime, fadeInTime, colors )
  local fadeIn = function()
    local targetState = type(target) == "function" and target() or target
    if GLOBALS.state then
      GLOBALS.state:destroy()
    end
    GLOBALS.state = Fader.create( targetState, true, fadeInTime, targetState, colors )
  end
  if (fadeOutTime == 0) then
    fadeIn()
  else
    GLOBALS.state = Fader.create( GLOBALS.state, false, fadeOutTime, fadeIn, colors )
  end
end

function Fader:update( dt, isWrapped )
  -- update the wrapped state if it has an update method
  if self.state.update then
    self.state:update(dt, self.state._isFader)
  end
  
  -- don't update if the duration was set to 0
  if (self.duration == 0) then
    return
  end
  
  -- calculate new alpha value based on dt
  local factor = self.fadeIn and -1 or 1
  local diff = (255.0/self.duration) * factor * dt
  local alpha = self.alpha + diff
  
  -- if the alpha reached a limit
  if (alpha < 0 or alpha > 255) then
    -- clamp it to the range 0-255
    alpha = alpha < 0 and 0 or alpha > 255 and 255 or alpha
    -- execute the doneCallback if present and if we are not wrapped in another fader
    if (self.target and not isWrapped) then
      if (type(self.target) == "function") then
        self.target()
      else
        GLOBALS.state = self.target
      end
    end
    -- deactivate the fader
    self.duration = 0
  end
  -- set actuall alpha value, and the value used in draw()
  self.alpha = alpha
  self.colors[4] = floor(alpha +0.5)
end

function Fader:draw()
  -- draw the state first
  self.state:draw()
  
  -- cover it with our fader color
  setColor(self.colors)
  fill("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

return Fader
