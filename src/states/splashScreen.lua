local SplashScreen = createNoopIndex({})

function SplashScreen.new()
  local self = setmetatable({}, SplashScreen)
  self.splash = require("lib.o-ten-one")({background={0, 0, 0}})
  self.splash.onDone = function()
    require("states.fader").fadeTo( GLOBALS.states.ingame, 0, 0.3 )
  end
  return self
end

function SplashScreen:update(dt)
  self.splash:update(dt)
end

function SplashScreen:draw()
  self.splash:draw()
end

function SplashScreen:keypressed()
  self.splash:skip()
end

return SplashScreen