local Entity = Object:extend()

--[[
  This function is called when the entity is discarded
  and can be cleaned up.
  The same rules apply like in "GameState.lua"
]]
function Entity:destroy()
end


-- UPDATE --
function Entity:update(dt)
end


-- DRAW --
function Entity:draw()
end

return Entity
