function string:startsWith( piece )
  return (piece == "") or (self:sub(1,piece:len()) == piece)
end
 
function string:endsWith( piece )
  return (piece == "") or (self:sub(-piece:len()) == piece)
end

--[[
  This hash function is taken from this page: http://www.wowwiki.com/USERAPI_StringHash
  All credit goes to Mikk -> http://www.wowwiki.com/User:Mikk
]]--
function string:hash()
  local counter = 1
  local len = self:len()
  local fmod = math.fmod
  for i = 1, len, 3 do 
    counter = fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
  	  (self:byte(i)*16776193) +
  	  ((self:byte(i+1) or (len-i+256))*8372226) +
  	  ((self:byte(i+2) or (len-i+256))*3932164)
  end
  return fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end
