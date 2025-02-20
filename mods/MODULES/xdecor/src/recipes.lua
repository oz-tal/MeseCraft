minetest.register_craft({
	output = "xdecor:baricade",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"", "default:steel_ingot", ""},
		{"group:stick", "", "group:stick"}
	}
})

minetest.register_craft({
	output = "xdecor:barrel",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:iron_lump", "", "default:iron_lump"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "xdecor:candle",
	recipe = {
		{"default:torch"}
	}
})

minetest.register_craft({
	output = "xdecor:cabinet",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"doors:trapdoor", "", "doors:trapdoor"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "xdecor:cabinet_half 2",
	recipe = {
		{"xdecor:cabinet"}
	}
})

minetest.register_craft({
	output = "xdecor:cactusbrick",
	recipe = {
		{"default:brick", "default:cactus"}
	}
})

minetest.register_craft({
	output = "xdecor:chair",
	recipe = {
		{"group:stick", "", ""},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"}
	}
})

minetest.register_craft({
	output = "xdecor:coalstone_tile 4",
	recipe = {
		{"default:coalblock", "default:stone"},
		{"default:stone", "default:coalblock"}
	}
})

minetest.register_craft({
	output = "xdecor:cobweb",
	recipe = {
		{"farming:string", "", "farming:string"},
		{"", "farming:string", ""},
		{"farming:string", "", "farming:string"}
	}
})

minetest.register_craft({
	output = "xdecor:cushion 3",
	recipe = {
		{"wool:red", "wool:red", "wool:red"}
	}
})

minetest.register_craft({
	output = "xdecor:cushion_block",
	recipe = {
		{"xdecor:cushion"},
		{"xdecor:cushion"}
	}
})

minetest.register_craft({
	output = "xdecor:desertstone_tile",
	recipe = {
		{"default:desert_stone_block"},
	}
})

if not minetest.get_modpath("moreblocks") then
	minetest.register_craft({
		output = "xdecor:empty_shelf",
		recipe = {
			{"group:wood", "group:wood", "group:wood"},
			{"", "", ""},
			{"group:wood", "group:wood", "group:wood"}
		}
	})
end

minetest.register_craft({
	output = "xdecor:enderchest",
	recipe = {
		{"", "default:obsidian", ""},
		{"default:obsidian", "default:chest", "default:obsidian"},
		{"", "default:obsidian", ""}
	}
})

minetest.register_craft({
	output = "xdecor:hard_clay",
	recipe = {
		{"default:clay", "default:clay"},
		{"default:clay", "default:clay"}
	}
})

minetest.register_craft({
	output = "xdecor:iron_lightbox",
	recipe = {
		{"xpanes:bar_flat", "default:torch", "xpanes:bar_flat"},
		{"xpanes:bar_flat", "default:glass", "xpanes:bar_flat"},
		{"xpanes:bar_flat", "default:torch", "xpanes:bar_flat"}
	}
})

minetest.register_craft({
	output = "xdecor:ivy 4",
	recipe = {
		{"group:leaves"},
		{"group:leaves"}
	}
})

minetest.register_craft({
	output = "xdecor:lantern",
	recipe = {
		{"default:iron_lump"},
		{"default:torch"},
		{"default:iron_lump"}
	}
})

minetest.register_craft({
	output = "xdecor:moonbrick",
	recipe = {
		{"default:brick", "default:stone"}
	}
})

minetest.register_craft({
	output = "xdecor:multishelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:vessel", "group:book", "group:vessel"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "xdecor:packed_ice",
	recipe = {
		{"", "default:ice", ""},
		{"default:ice", "", "default:ice"},
		{"", "default:ice", ""},
	}
})

minetest.register_craft({
	output = "xdecor:painting_1",
	recipe = {
		{"default:sign_wall_wood", "group:dye"}
	}
})

minetest.register_craft({
	output = "xdecor:radio",
	type = "shapeless",
	recipe = {"xdecor:speaker", "xdecor:speaker"}
})

minetest.register_craft({
	output = "xdecor:rooster",
	recipe = {
		{"default:gold_ingot", "", "default:gold_ingot"},
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "", "default:gold_ingot"}
	}
})

minetest.register_craft({
	output = "xdecor:speaker",
	recipe = {
		{"default:gold_ingot", "default:copper_ingot", "default:gold_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:gold_ingot", "default:copper_ingot", "default:gold_ingot"}
	}
})

minetest.register_craft({
	output = "xdecor:stone_tile_x",
	recipe = {
		{"default:stone_block"},
	}
})

minetest.register_craft({
	output = "xdecor:stone_rune 4",
	recipe = {
		{"default:stone_block", "default:stone_block", "default:stone_block"},
		{"default:stone_block", "", "default:stone_block"},
		{"default:stone_block", "default:stone_block", "default:stone_block"}
	}
})

minetest.register_craft({
	output = "xdecor:stonepath 16",
	recipe = {
		{"stairs:slab_cobble", "", "stairs:slab_cobble"},
		{"", "stairs:slab_cobble", ""},
		{"stairs:slab_cobble", "", "stairs:slab_cobble"}
	}
})

minetest.register_craft({
	output = "xdecor:table",
	recipe = {
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output = "xdecor:tatami",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"}
	}
})

minetest.register_craft({
	output = "xdecor:trampoline",
	recipe = {
		{"farming:string", "farming:string", "farming:string"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "xdecor:tv",
	recipe = {
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "xdecor:woodframed_glass",
	recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "default:glass", "group:stick"},
		{"group:stick", "group:stick", "group:stick"}
	}
})

minetest.register_craft({
	output = "xdecor:wood_tile_x 2",
	recipe = {
		{"", "group:wood", ""},
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})

minetest.register_craft({
	output = "xdecor:wooden_lightbox",
	recipe = {
		{"group:stick", "default:torch", "group:stick"},
		{"group:stick", "default:glass", "group:stick"},
		{"group:stick", "default:torch", "group:stick"}
	}
})

minetest.register_craft({
	output = "xdecor:wooden2_lightbox",
	recipe = {
		{"group:stick", "group:stick", "group:stick"},
		{"default:torch", "default:glass", "default:torch"},
		{"group:stick", "group:stick", "group:stick"}
	},
})


minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:empty_shelf",
	burntime = 30,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:multishelf",
	burntime = 30,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:cabinet",
	burntime = 30,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:barrel",
	burntime = 30,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:cabinet_half",
	burntime = 15,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:workbench",
	burntime = 15,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:table",
	burntime = 12,
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:woodglass_door",
	burntime = 13,
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:screen_door",
	burntime = 10,
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:slide_door",
	burntime = 8,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xpanes:wood_frame_flat",
	burntime = 5,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xpanes:bamboo_frame_flat",
	burntime = 3,
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:japanese_door",
	burntime = 8,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:chair",
	burntime = 6,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:baricade",
	burntime = 6,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:wood_tile_x",
	burntime = 10,
})
minetest.register_craft({
	type = "fuel",
	recipe = "realchess:chessboard",
	burntime = 4,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:painting_1",
	burntime = 3,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:tatami",
	burntime = 1,
})
minetest.register_craft({
	type = "fuel",
	recipe = "xdecor:ivy",
	burntime = 1,
})

