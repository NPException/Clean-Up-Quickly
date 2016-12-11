
local function noop()
end

--[[
  adds an __index function to the given table that will assign an empty function
  to the indexed key in the metatable, if it is not yet present on the metaTable
]]
function createNoopIndex( metatable )
  metatable.__index = function(table, key)
    local value = metatable[key]
    if not value then
      value = noop
      rawset(metatable, key, value)
    end
    return value
  end
  return metatable
end
