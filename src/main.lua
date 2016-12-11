-- global variables
require("lib.stringfunctions")
require("loop")

local splash = require("lib.o-ten-one")({background={0, 0, 0}})
splash.onDone = function() splash = nil end

GLOBALS = { debug = false }
local globals = GLOBALS

-- main variables
local  fps, mspf


-- LOAD --
function love.load(arg)
  globals.debug = false
  globals.config = require("conf")
  globals.time = 0
    
  love.graphics.setDefaultFilter("nearest","nearest")
  
  -- load initial game state here
end


-- KEYPRESSED --
function love.keypressed( key, scancode, isrepeat )
  if splash then splash:skip() return end
  
  if (key == "pause") then
    globals.debug = not globals.debug
  elseif (scancode == "`") then
    debug.debug()
  elseif (key == "escape") then
    love.event.quit()
  elseif (key == "return") then
    if (love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")) then
      love.window.setFullscreen(not love.window.getFullscreen(), "desktop")
    end
  end
  
  -- do game keypressed actions here
end



function love.mousepressed( x, y, button )
  -- mouse button actions here
end



function love.wheelmoved( dx, dy )
  -- mouse wheel actions
end


-- UPDATE --
function love.update(dt)
  if splash then splash:update(dt) return end
  
  globals.time = globals.time + dt
  
  -- do game state update here
  
  if (globals.debug) then
    fps = love.timer.getFPS()
    mspf = math.floor(100000/fps)/100
  end
end



-- DRAW --
function love.draw()
  if splash then splash:draw() return end
  
  -- do game state draw here
  
  if (globals.debug) then
    love.graphics.setColor(0,0,0,128)
    love.graphics.rectangle("fill",0,0,100,40)
    love.graphics.setColor(255,255,255)
    love.graphics.print("FPS:  "..fps, 5,5)
    love.graphics.print("ms/F: "..mspf, 5,20)
  end
end

function love.resize(w,h)
  -- if necessary, do resize actions here
end