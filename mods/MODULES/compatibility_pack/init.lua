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

  if minetest.get_modpath("technic") then
    smoke.add_source("technic:lv_generator_active", 1)
    smoke.add_source("technic:mv_generator_active", 1)
    smoke.add_source("technic:hv_generator_active", 1)
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

-- QUICKFIX TO CONVERT EVERNESS CHEST TO DEFAULT CHEST BACK AND FORTH
if minetest.get_modpath("default") and  minetest.get_modpath("everness") then
  minetest.register_craft({
    type = "shapeless",
    output = "everness:chest 1",
    recipe = {"default:chest"}
  })
  minetest.register_craft({
    type = "shapeless",
    output = "default:chest 1",
    recipe = {"everness:chest"}
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


-- Hopper containers
if minetest.get_modpath("hopper") then
  if minetest.get_modpath("technic") then
    hopper:add_container({
      -- Machines

      {"top", "technic:mv_grinder", "dst"},
      {"bottom", "technic:mv_grinder", "src"},
      {"side", "technic:mv_grinder", "src"},

      {"top", "technic:mv_electric_furnace", "dst"},
      {"bottom", "technic:mv_electric_furnace", "src"},
      {"side", "technic:mv_electric_furnace", "src"},

      {"top", "technic:mv_electric_furnace_active", "dst"},
      {"bottom", "technic:mv_electric_furnace_active", "src"},
      {"side", "technic:mv_electric_furnace_active", "src"},

      {"top", "technic:mv_alloy_furnace", "dst"},
      {"bottom", "technic:mv_alloy_furnace", "src"},
      {"side", "technic:mv_alloy_furnace", "src"},

      {"top", "technic:mv_alloy_furnace_active", "dst"},
      {"bottom", "technic:mv_alloy_furnace_active", "src"},
      {"side", "technic:mv_alloy_furnace_active", "src"},

      {"top", "technic:mv_centrifuge", "dst"},
      {"bottom", "technic:mv_centrifuge", "src"},
      {"side", "technic:mv_centrifuge", "src"},

      {"top", "technic:mv_centrifuge_active", "dst"},
      {"bottom", "technic:mv_centrifuge_active", "src"},
      {"side", "technic:mv_centrifuge_active", "src"},

      {"top", "technic:mv_compressor", "dst"},
      {"bottom", "technic:mv_compressor", "src"},
      {"side", "technic:mv_compressor", "src"},

      {"top", "technic:mv_compressor_active", "dst"},
      {"bottom", "technic:mv_compressor_active", "src"},
      {"side", "technic:mv_compressor_active", "src"},

      {"top", "technic:mv_extractor", "dst"},
      {"bottom", "technic:mv_extractor", "src"},
      {"side", "technic:mv_extractor", "src"},

      {"top", "technic:mv_extractor_active", "dst"},
      {"bottom", "technic:mv_extractor_active", "src"},
      {"side", "technic:mv_extractor_active", "src"},

      {"top", "technic:mv_grinder", "dst"},
      {"bottom", "technic:mv_grinder", "src"},
      {"side", "technic:mv_grinder", "src"},

      {"top", "technic:mv_grinder_active", "dst"},
      {"bottom", "technic:mv_grinder_active", "src"},
      {"side", "technic:mv_grinder_active", "src"},

      {"top", "technic:mv_freezer", "dst"},
      {"bottom", "technic:mv_freezer", "src"},
      {"side", "technic:mv_freezer", "src"},

      {"top", "technic:mv_freezer_active", "dst"},
      {"bottom", "technic:mv_freezer_active", "src"},
      {"side", "technic:mv_freezer_active", "src"},

      {"top", "technic:hv_electric_furnace", "dst"},
      {"bottom", "technic:hv_electric_furnace", "src"},
      {"side", "technic:hv_electric_furnace", "src"},

      {"top", "technic:hv_electric_furnace_active", "dst"},
      {"bottom", "technic:hv_electric_furnace_active", "src"},
      {"side", "technic:hv_electric_furnace_active", "src"},

      {"top", "technic:hv_compressor", "dst"},
      {"bottom", "technic:hv_compressor", "src"},
      {"side", "technic:hv_compressor", "src"},

      {"top", "technic:hv_compressor_active", "dst"},
      {"bottom", "technic:hv_compressor_active", "src"},
      {"side", "technic:hv_compressor_active", "src"},

      {"top", "technic:hv_grinder", "dst"},
      {"bottom", "technic:hv_grinder", "src"},
      {"side", "technic:hv_grinder", "src"},

      {"top", "technic:hv_grinder_active", "dst"},
      {"bottom", "technic:hv_grinder_active", "src"},
      {"side", "technic:hv_grinder_active", "src"},

      -- Chests

      {"top", "technic:iron_chest", "main"},
      {"bottom", "technic:iron_chest", "main"},
      {"side", "technic:iron_chest", "main"},

      {"top", "technic:copper_chest", "main"},
      {"bottom", "technic:copper_chest", "main"},
      {"side", "technic:copper_chest", "main"},

      {"top", "technic:silver_chest", "main"},
      {"bottom", "technic:silver_chest", "main"},
      {"side", "technic:silver_chest", "main"},

      {"top", "technic:gold_chest", "main"},
      {"bottom", "technic:gold_chest", "main"},
      {"side", "technic:gold_chest", "main"},

      {"top", "technic:mithril_chest", "main"},
      {"bottom", "technic:mithril_chest", "main"},
      {"side", "technic:mithril_chest", "main"},
    })
  end

  if minetest.get_modpath("pipeworks") then
    hopper:add_container({
      {"top", "pipeworks:autocrafter", "dst"},
      {"bottom", "pipeworks:autocrafter", "src"},
      {"side", "pipeworks:autocrafter", "src"},
    })
  end

  if minetest.get_modpath("digilines") then
    hopper:add_container({
      {"top", "digilines:chest", "main"},
      {"bottom", "digilines:chest", "main"},
      {"side", "digilines:chest", "main"},
    })
  end

  if minetest.get_modpath("everness") then
    hopper:add_container({
      {"top", "everness:chest", "main"},
      {"bottom", "everness:chest", "main"},
      {"side", "everness:chest", "main"},
    })
  end
end
