-- Add mesecraft_toolranks supports
if minetest.get_modpath("mesecraft_toolranks") then
  if minetest.get_modpath("everness") then
    mesecraft_toolranks.register_tool("everness:pick_illuminating")
  end

  if minetest.get_modpath("nether") then
    mesecraft_toolranks.register_tool("nether:pick_nether")
    mesecraft_toolranks.register_tool("nether:shovel_nether")
    mesecraft_toolranks.register_tool("nether:axe_nether")
    mesecraft_toolranks.register_tool("nether:sword_nether")
  end
end

-- Glass group fixes for pyrite glass crafting recipe
if minetest.get_modpath("everness") then
  if  minetest.get_modpath("default") then
    minetest.registered_nodes["default:glass"].groups.glass = 1
    minetest.registered_nodes["default:obsidian_glass"].groups.glass = 1
  end

  if minetest.get_modpath("moreblocks") then
    minetest.registered_nodes["moreblocks:clean_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:coal_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:glow_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:iron_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_glow_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_glow_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:super_glow_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_obsidian_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_super_glow_glass"].groups.glass = 1
    minetest.registered_nodes["moreblocks:trap_super_glow_glass"].groups.glass = 1
  end
end

-- Smoke support
if minetest.get_modpath("smoke") then
  if minetest.get_modpath("everness") then
    smoke.add_source("everness:forsaken_fire", 2)
  end
end


-- QUICKFIX TO CONVERT STEEL BUCKET TO MESECRAFT BUCKET BACK AND FORTH
if minetest.get_modpath("mesecraft_bucket") and  minetest.get_modpath("bucket") then
  minetest.register_craft({
    type = "shapeless",
    output = "mesecraft_bucket:bucket_empty 1",
    recipe = {"bucket:bucket_empty_steel"}
  })
  minetest.register_craft({
    type = "shapeless",
    output = "bucket:bucket_empty_steel 1",
    recipe = {"mesecraft_bucket:bucket_empty"}
  })

  minetest.register_craft({
    type = "shapeless",
    output = "mesecraft_bucket:bucket_lava 1",
    recipe = {"bucket:bucket_lava_uni_steel"}
  })
  minetest.register_craft({
    type = "shapeless",
    output = "bucket:bucket_lava_uni_steel 1",
    recipe = {"mesecraft_bucket:bucket_lava"}
  })
end


-- Stackable ingots
if minetest.get_modpath("ingots") then
  if minetest.get_modpath("everness") then
      ingots.register_ingots("everness:pyrite_ingot", "ingot_pyrite.png")
  end

  if minetest.get_modpath("pigiron") then
      ingots.register_ingots("pigiron:iron_ingot", "ingot_pig_iron.png")
  end

  if minetest.get_modpath("nether") then
      ingots.register_ingots("nether:nether_ingot", "ingot_nether.png")
  end
end

if minetest.get_modpath("technic") then
  -- Allloy
  local alloy_recipes = {
    {"default:silver_sand 8", "technic:wrought_iron_dust", "default:sand 8"}, -- silver sand enrichment
  }
  for _, data in pairs(alloy_recipes) do 
    technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
  end

  -- Centrifuge
  local centrifuge_recipes = {
    {"default:sand 8", "technic:wrought_iron_dust", "default:silver_sand 8"}, -- sand purrifying
  }
  for _, data in pairs(centrifuge_recipes) do
    technic.register_separating_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })
  end
end
