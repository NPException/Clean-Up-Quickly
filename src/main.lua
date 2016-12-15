-- global variables
require("lib.stringfunctions")
require("loop")

Object = require("lib.classic") -- https://github.com/rxi/classic/

local controls = {
        left = {'key:left',  'axis:leftx-',  'button:dpleft'},
       right = {'key:right', 'axis:leftx+',  'button:dpright'},
          up = {'key:up',    'axis:lefty-',  'button:dpup'},
        down = {'key:down',  'axis:lefty+',  'button:dpdown'},
        
   flingLeft = {'sc:a',      'axis:rightx-', 'button:x'},
  flingRight = {'sc:d',      'axis:rightx+', 'button:b'},
     flingUp = {'sc:w',      'axis:righty-', 'button:y'},
   flingDown = {'sc:s',      'axis:righty+', 'button:a'},
   
      action = {'key:space', 'button:rightshoulder'}
}


GLOBALS = {
  debug = false,
  images = require("lib.images"),
  input = require("lib.baton").new(controls, love.joystick.getJoysticks()[1])
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
      rawset(table, key, StateClass)
      return StateClass
    end
  })
  globals.state = globals.states.SplashScreen()
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
end



-- UPDATE --
function love.update(dt)
  require("lib.lovebird").update()
  
  globals.time = globals.time + dt
  
  globals.input:update()
  
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
