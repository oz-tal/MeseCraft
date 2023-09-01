--
-- Globals
--

worldgate = {
  modpath = minetest.get_modpath("worldgate"),
  gates = {},
  hash_index = {},
  forceload_index = {},
}

--
-- Modules
--

local function load(file)
  dofile(worldgate.modpath .. "/src/" .. file .. ".lua")
end

load("nodes")
load("functions")
load("gates")
load("mapgen")
load("logging")
load("settings_overrides")
load("link")