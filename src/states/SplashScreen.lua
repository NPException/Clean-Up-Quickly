local SplashScreen = require("states.GameState"):extend()

function SplashScreen:new()
  self.splash = require("lib.o-ten-one")({background={0, 0, 0}})
  self.splash.onDone = function()
    require("states.Fader").fadeTo( GLOBALS.states.Ingame, 0, 0.3 )
  end
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
