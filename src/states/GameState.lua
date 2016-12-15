local GameState = Object:extend()

--[[
  This function is called when the game state is discarded
  and can be cleaned up.
  A game state should clean up globaly allocated resources,
  like images and sounds, that are only used by that gamestate
  here. (also clearing all instance fields isn't a bad thing)
]]
function GameState:destroy()
end


-- UPDATE --
function GameState:update(dt)
end


-- DRAW --
function GameState:draw()
end

return GameState
