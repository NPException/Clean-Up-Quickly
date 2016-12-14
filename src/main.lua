-- global variables
require("lib.stringfunctions")
require("loop")

Object = require("lib.classic") -- https://github.com/rxi/classic/

GLOBALS = {
  debug = false,
  images = require("lib.images")
}
local globals = GLOBALS


-- main variables
local  fps, mspf
local lg


-- LOAD --
function love.load(arg)
  globals.debug = false
  globals.config = require("conf")
  globals.time = 0
  
  lg = love.graphics
    
  lg.setDefaultFilter("linear","nearest")
  
  -- load initial game state here
  globals.states = setmetatable({}, {
    __index = function(table, key)
      print("Loading state: "..key)
      local StateClass = require("states."..key);
      local state = StateClass()
      rawset(table, key, state)
      return state
    end
  })
  globals.state = globals.states.SplashScreen
end


-- KEYPRESSED --
function love.keypressed( key, scancode, isrepeat )
  if (key == "pause") then
    globals.debug = not globals.debug
  elseif (key == "escape") then
    love.event.quit()
  elseif (key == "return") then
--    if (love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")) then
--      love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
--    end
  end
  
  -- do game keypressed actions here
  globals.state:keypressed( key, scancode, isrepeat )
end


-- MOUSE PRESSED --
function love.mousepressed( x, y, button )
  globals.state:mousepressed( x, y, button )
end

-- MOUSE RELEASED --
function love.mousereleased( x, y, button )
  globals.state:mousereleased( x, y, button )
end

-- MOUSE MOVED --
function love.mousemoved( x, y, dx, dy )
  globals.state:mousemoved( x, y, dx, dy )
end


-- UPDATE --
function love.update(dt)
  require("lib.lovebird").update()
  
  globals.time = globals.time + dt
  
  -- do game state update here
  globals.state:update( dt )
  
  if (globals.debug) then
    fps = love.timer.getFPS()
    mspf = math.floor(100000/fps)/100
  end
end



-- DRAW --
function love.draw()
  -- do game state draw here
  globals.state:draw()
  
  if (globals.debug) then
    lg.setColor(0,0,0,128)
    lg.rectangle("fill",0,0,100,40)
    lg.setColor(255,255,255)
    lg.print("FPS:  "..fps, 5,5)
    lg.print("ms/F: "..mspf, 5,20)
  end
end

function love.resize(w,h)
  -- if necessary, do resize actions here
end
