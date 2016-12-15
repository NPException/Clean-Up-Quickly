-----------------------
-- Sound handler
-----------------------


-- define sounds table
local sounds = {
  --[[
  button_mouseover = {path="assets/sounds/button_mouseover.wav", soundtype="static", volume=0.1, looping=false},
  button_pressed = {path="assets/sounds/button_pressed.wav", soundtype="static", volume=0.1, looping=false},
  ]]
  music1 = {path="assets/music/bit_shift.mp3", soundtype="stream", volume=0.1, looping=true},
  music2 = {path="assets/music/pixelland.mp3", soundtype="stream", volume=0.1, looping=true},
  music3 = {path="assets/music/salty_ditty.mp3", soundtype="stream", volume=0.1, looping=true},
  music4 = {path="assets/music/the_show_must_be_go.mp3", soundtype="stream", volume=0.1, looping=true},
}


-- shorten love function and error handling
local loadSound = function(soundPath, soundType)
  local status, msg = pcall(love.audio.newSource, soundPath, soundType)
  if (status) then
    return msg
  else
    print("No sound present at path '"..soundPath.."'. Returning nil.")
    return nil
  end
end


local source_play = function(self) self.source:play() end
local source_stop = function(self) self.source:stop() end
local source_pause = function(self) self.source:pause() end
local source_resume = function(self) self.source:resume() end
local source_rewind = function(self) self.source:rewind() end
local source_setPitch = function(self, pitch) self.source:setPitch(pitch) end
local source_setVolume = function(self, vol) self.source:setVolume(self.maxVolume * (vol < 0 and 0 or vol > 1 and 1 or vol)) end


function sounds.__index(table, key)
  local info = sounds[key]
  if (not info) then
    error("Tried to access undeclared sound: '"..key.."'")
  end
  print("Loading Sound: '"..key.."', path: '"..info.path.."'")
  
  local sound = {
    source = loadSound(info.path, info.soundtype),
    maxVolume = info.volume,
    play = source_play,
    stop = source_stop,
    pause = source_pause,
    resume = source_resume,
    rewind = source_rewind,
    setPitch = source_setPitch,
    setVolume = source_setVolume
  }
  sound:setVolume(1)
  sound.source:setLooping(info.looping or false)
  
  rawset(table, key, sound)
  return sound
end

-- return
return setmetatable({}, sounds)
