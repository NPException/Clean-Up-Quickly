-- ---------------------
-- Image handler
-- ---------------------

-- shorten love function and error handling
local loadImage = function(imagePath)
  local status, msg = pcall(love.graphics.newImage, imagePath)
  if (status) then
    return msg
  else
    print("No image present at path '"..imagePath.."'. Using default image.")
    return love.graphics.newImage("assets/default.png")
  end
end

-- define image table
local images = {
  -- backgrounds
  background = "assets/background_tmp.png",
  --background_menu = "assets/menu/background_menu.png",
  
  -- props
  tree = "assets/tree_tmp.png",
  
  -- player
  player = "assets/player_tmp.png",
}

function images.__index(table, key)
  local path = images[key]
  if (not path) then
    error("Tried to access undeclared image: '"..key.."'")
  end
  print("Loading image: '"..key.."', path: '"..path.."'")
  local image = loadImage(path)
  rawset(table, key, image)
  return image
end

-- return
return setmetatable({}, images)
