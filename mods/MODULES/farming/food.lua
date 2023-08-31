
local S = farming.translate
local tmp

-- add group function
local function add_groups(item, groups)

	local def = minetest.registered_items[item]

	if not def then return end

	local grp = def.groups

	for k, v in pairs(groups) do
		grp[k] = v
	end

	minetest.override_item(item, {groups = grp})
end

-- item compatibility list
local a = {
	water_source = "default:water_source",
	river_water_source = "default:river_water_source",
	bucket_empty = "bucket:bucket_empty",
	bucket_water = "bucket:bucket_water",
	bucket_river_water = "bucket:bucket_river_water",
	drinking_glass = "vessels:drinking_glass",
	glass_bottle = "vessels:glass_bottle",
	sugar = "farming:sugar",
	rose = "flowers:rose",
	dye_pink = "dye:pink",
	dye_orange = "dye:orange",
	bowl = "farming:bowl",
	flour = "group:food_flour",
	bread = "farming:bread",
	cactus = "default:cactus",
}

if farming.mcl then
	a.water_source = "mcl_core:water_source"
	a.river_water_source = "mclx_core:river_water_source"
	a.bucket_empty = "mcl_buckets:bucket_empty"
	a.bucket_water = "mcl_buckets:bucket_water"
	a.bucket_river_water = "mcl_buckets:bucket_river_water"
	a.drinking_glass = "mcl_potions:glass_bottle"
	a.glass_bottle = "mcl_potions:glass_bottle"
	a.sugar = "mcl_core:sugar"
	a.rose = "mcl_flowers:rose_bush"
	a.dye_pink = "mcl_dye:pink"
	a.dye_orange = "mcl_dye:orange"
	a.bowl = "mcl_core:bowl"
	a.flour = "mcl_farming:bread"
	a.bread = "mcl_farming:bread"
	a.cactus = "mcl_core:cactus"

	add_groups("mcl_throwing:egg", {food_egg = 1})
	add_groups("mcl_farming:wheat", {food_wheat = 1})
	add_groups("mcl_cocoas:cocoa_beans", {food_cocoa = 1})
	add_groups("mcl_core:apple", {food_apple = 1})
	add_groups("mcl_core:bowl", {food_bowl = 1})
	add_groups("mcl_mobitems:chicken", {food_chicken_raw = 1})
	add_groups("mcl_mobitems:cooked_chicken", {food_chicken = 1})
	add_groups("mcl_mushrooms:mushroom_brown", {food_mushroom = 1})
	add_groups("mcl_farming:carrot_item", {food_carrot = 1})
	add_groups("mcl_mobitems:cooked_beef", {food_meat = 1})
	add_groups("mcl_mobitems:beef", {food_meat_raw = 1})
	add_groups("mcl_farming:potato_item", {food_potato = 1})
end

-- filter sea water into river water

minetest.register_craft({
	output = a.bucket_river_water,
	recipe = {
		{"farming:hemp_fibre"},
		{"farming:hemp_fibre"},
		{a.bucket_water}
	}
})

-- glass of water

minetest.register_craftitem("farming:glass_water", {
	description = S("Glass of Water"),
	inventory_image = "farming_water_glass.png",
	groups = {food_water_glass = 1, flammable = 3, vessel = 1}
})

minetest.register_craft({
	output = "farming:glass_water 4",
	recipe = {
		{a.drinking_glass, a.drinking_glass},
		{a.drinking_glass, a.drinking_glass},
		{a.bucket_river_water, ""}
	},
	replacements = {{a.bucket_river_water, a.bucket_empty}}
})

minetest.register_craft({
	output = "farming:glass_water 4",
	recipe = {
		{a.drinking_glass, a.drinking_glass},
		{a.drinking_glass, a.drinking_glass},
		{a.bucket_water, "farming:hemp_fibre"}
	},
	replacements = {{a.bucket_water, a.bucket_empty}}
})

if minetest.get_modpath("bucket_wooden") then

	minetest.register_craft({
		output = "farming:glass_water 4",
		recipe = {
			{a.drinking_glass, a.drinking_glass},
			{a.drinking_glass, a.drinking_glass},
			{"group:water_bucket_wooden", "farming:hemp_fibre"}
		},
		replacements = {{"group:water_bucket_wooden", "bucket_wooden:bucket_empty"}}
	})
end

-- Sugar

if farming.mtg then

	minetest.register_craftitem("farming:sugar", {
		description = S("Sugar"),
		inventory_image = "farming_sugar.png",
		groups = {food_sugar = 1, flammable = 3}
	})

	minetest.register_craft({
		type = "cooking",
		cooktime = 3,
		output = "farming:sugar 2",
		recipe = "default:papyrus"
	})
end

if farming.mcl then
	add_groups(a.sugar, {food_sugar = 1})
end

minetest.register_node("farming:sugar_cube", {
	description = S("Sugar Cube"),
	tiles = {"farming_sugar_cube.png"},
	groups = {crumbly = 2},
	floodable = true,
	sounds = farming.sounds.node_sound_gravel_defaults()
})

minetest.register_craft({
	output = "farming:sugar_cube",
	recipe = {
		{a.sugar, a.sugar, a.sugar},
		{a.sugar, a.sugar, a.sugar},
		{a.sugar, a.sugar, a.sugar}
	}
})

minetest.register_craft({
	output = a.sugar .. " 9",
	recipe = {{"farming:sugar_cube"}}
})

-- Sugar caramel

minetest.register_craftitem("farming:caramel", {
	description = S("Caramel"),
	inventory_image = "farming_caramel.png"
})

minetest.register_craft({
	type = "cooking",
	cooktime = 6,
	output = "farming:caramel",
	recipe = "group:food_sugar"
})

-- Salt

minetest.register_node("farming:salt", {
	description = S("Salt"),
	inventory_image = "farming_salt.png",
	wield_image = "farming_salt.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_salt.png"},
	groups = {food_salt = 1, vessel = 1, dig_immediate = 3,
			attached_node = 1},
	sounds = farming.sounds.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	-- special function to make salt crystals form inside water
	dropped_step = function(self, pos, dtime)

		self.ctimer = (self.ctimer or 0) + dtime
		if self.ctimer < 15.0 then return end
		self.ctimer = 0

		local needed

		if self.node_inside
		and self.node_inside.name == a.water_source then
			needed = 8

		elseif self.node_inside
		and self.node_inside.name == a.river_water_source then
			needed = 9
		end

		if not needed then return end

		local objs = core.get_objects_inside_radius(pos, 0.5)

		if not objs or #objs ~= 1 then return end

		local salt, ent = nil, nil

		for k, obj in pairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name == "__builtin:item"
			and ent.itemstring == "farming:salt " .. needed then

				obj:remove()

				core.add_item(pos, "farming:salt_crystal")

				return false -- return with no further action
			end
		end
	end
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:salt",
	recipe = a.bucket_water,
	replacements = {{a.bucket_water, a.bucket_empty}}
})

-- Salt Crystal

minetest.register_node("farming:salt_crystal", {
	description = ("Salt crystal"),
	inventory_image = "farming_salt_crystal.png",
	wield_image = "farming_salt_crystal.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	light_source = 1,
	tiles = {"farming_salt_crystal.png"},
	groups = { dig_immediate = 3, attached_node = 1},
	sounds = farming.sounds.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

tmp = farming.use_utensils and "farming:mortar_pestle" or ""

minetest.register_craft({
	output = "farming:salt 9",
	recipe = {
		{"farming:salt_crystal", tmp}
	},
	replacements = {{"farming:mortar_pestle", "farming:mortar_pestle"}}
})

minetest.register_craft({
	output = "farming:salt_crystal",
	recipe = {
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"},
		{"farming:salt", "farming:salt", "farming:salt"}
	}
})

-- Mayonnaise

minetest.register_node("farming:mayonnaise", {
	description = S("Mayonnaise"),
	drawtype = "plantlike",
	tiles = {"farming_mayo.png"},
	inventory_image = "farming_mayo.png",
	wield_image = "farming_mayo.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(3),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.45, 0.25}
	},
	groups = {food_mayonnaise = 1, vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = farming.sounds.node_sound_glass_defaults()
})

minetest.register_craft({
	output = "farming:mayonnaise",
	recipe = {
		{"group:food_olive_oil", "group:food_lemon"},
		{"group:food_egg", "farming:salt"}
	},
	replacements = {{"farming:olive_oil", a.glass_bottle}}
})

-- Rose Water

minetest.register_node("farming:rose_water", {
	description = S("Rose Water"),
	inventory_image = "farming_rose_water.png",
	wield_image = "farming_rose_water.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"farming_rose_water.png"},
	groups = {
		food_rose_water = 1, vessel = 1, dig_immediate = 3, attached_node = 1
	},
	sounds = farming.sounds.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

tmp = farming.use_utensils and "farming:pot" or ""

minetest.register_craft({
	output = "farming:rose_water",
	recipe = {
		{a.rose, a.rose, a.rose},
		{a.rose, a.rose, a.rose},
		{"group:food_water_glass", tmp, a.glass_bottle}
	},
	replacements = {
		{"group:food_water_glass", a.drinking_glass},
		{"group:food_pot", "farming:pot"}
	}
})

-- Turkish Delight

minetest.register_craftitem("farming:turkish_delight", {
	description = S("Turkish Delight"),
	inventory_image = "farming_turkish_delight.png",
	groups = {flammable = 3},
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "farming:turkish_delight 4",
	recipe = {
		{"group:food_gelatin", "group:food_sugar", "group:food_gelatin"},
		{"group:food_sugar", "group:food_rose_water", "group:food_sugar"},
		{"group:food_sugar", a.dye_pink, "group:food_sugar"}
	},
	replacements = {
		{"group:food_cornstarch", a.bowl},
		{"group:food_cornstarch", a.bowl},
		{"group:food_rose_water", a.glass_bottle}
	}
})

-- Garlic Bread

minetest.register_craftitem("farming:garlic_bread", {
	description = S("Garlic Bread"),
	inventory_image = "farming_garlic_bread.png",
	groups = {flammable = 3},
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "farming:garlic_bread",
	recipe = {
		{"group:food_toast", "group:food_garlic_clove", "group:food_garlic_clove"}
	}
})

-- Donuts (thanks to Bockwurst for making the donut images)

minetest.register_craftitem("farming:donut", {
	description = S("Donut"),
	inventory_image = "farming_donut.png",
	on_use = minetest.item_eat(4)
})

minetest.register_craft({
	output = "farming:donut 3",
	recipe = {
		{"", "group:food_wheat", ""},
		{"group:food_wheat", "group:food_sugar", "group:food_wheat"},
		{"", "group:food_wheat", ""}
	}
})

minetest.register_craftitem("farming:donut_chocolate", {
	description = S("Chocolate Donut"),
	inventory_image = "farming_donut_chocolate.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	output = "farming:donut_chocolate",
	recipe = {
		{"group:food_cocoa"},
		{"farming:donut"}
	}
})

minetest.register_craftitem("farming:donut_apple", {
	description = S("Apple Donut"),
	inventory_image = "farming_donut_apple.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	output = "farming:donut_apple",
	recipe = {
		{"group:food_apple"},
		{"farming:donut"}
	}
})

-- Porridge Oats

minetest.register_craftitem("farming:porridge", {
	description = S("Porridge"),
	inventory_image = "farming_porridge.png",
	on_use = minetest.item_eat(6, a.bowl)
})

minetest.register_craft({
	output = "farming:porridge",
	recipe = {
		{"group:food_oats", "group:food_oats", "group:food_oats"},
		{"group:food_oats", "group:food_bowl", "group:food_milk_glass"}
	},
	replacements = {
		{"mobs:glass_milk", a.drinking_glass},
		{"farming:soy_milk", a.drinking_glass}
	}
})

-- Jaffa Cake

minetest.register_craftitem("farming:jaffa_cake", {
	description = S("Jaffa Cake"),
	inventory_image = "farming_jaffa_cake.png",
	on_use = minetest.item_eat(6)
})

tmp = farming.use_utensils and "farming:baking_tray" or ""

minetest.register_craft({
	output = "farming:jaffa_cake 3",
	recipe = {
		{tmp, "group:food_egg", "group:food_sugar"},
		{a.flour, "group:food_cocoa", "group:food_orange"},
		{"group:food_milk", "", ""}
	},
	replacements = {
		{"farming:baking_tray", "farming:baking_tray"},
		{"mobs:bucket_milk", a.bucket_empty},
		{"mobs:wooden_bucket_milk", "wooden_bucket:bucket_wood_empty"},
		{"farming:soy_milk", a.drinking_glass}
	}
})

-- Apple Pie

minetest.register_craftitem("farming:apple_pie", {
	description = S("Apple Pie"),
	inventory_image = "farming_apple_pie.png",
	on_use = minetest.item_eat(6)
})

tmp = farming.use_utensils and "farming:baking_tray" or ""

minetest.register_craft({
	output = "farming:apple_pie",
	recipe = {
		{a.flour, "group:food_sugar", "group:food_apple"},
		{"", tmp, ""}
	},
	replacements = {{"group:food_baking_tray", "farming:baking_tray"}}
})

-- Cactus Juice

minetest.register_craftitem("farming:cactus_juice", {
	description = S("Cactus Juice"),
	inventory_image = "farming_cactus_juice.png",
	groups = {vessel = 1, drink = 1},
	on_use = function(itemstack, user, pointed_thing)

		if user then

			local num = math.random(5) == 1 and -1 or 2

			return minetest.do_item_eat(num, "vessels:drinking_glass",
					itemstack, user, pointed_thing)
		end
	end
})

tmp = farming.use_utensils and "farming:juicer" or ""

minetest.register_craft({
	output = "farming:cactus_juice",
	recipe = {
		{tmp},
		{a.cactus},
		{a.drinking_glass}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})

-- Pasta

minetest.register_craftitem("farming:pasta", {
	description = S("Pasta"),
	inventory_image = "farming_pasta.png",
	groups = {food_pasta = 1}
})

tmp = farming.use_utensils and "farming:mixing_bowl" or ""

minetest.register_craft({
	output = "farming:pasta",
	recipe = {
		{a.flour, "group:food_butter", tmp}
	},
	replacements = {{"group:food_mixing_bowl", "farming:mixing_bowl"}}
})

minetest.register_craft({
	output = "farming:pasta",
	recipe = {
		{a.flour, "group:food_oil", tmp}
	},
	replacements = {
		{"group:food_mixing_bowl", "farming:mixing_bowl"},
		{"group:food_oil", a.glass_bottle}
	}
})

-- Mac & Cheese

minetest.register_craftitem("farming:mac_and_cheese", {
	description = S("Mac & Cheese"),
	inventory_image = "farming_mac_and_cheese.png",
	on_use = minetest.item_eat(6, a.bowl)
})

minetest.register_craft({
	output = "farming:mac_and_cheese",
	recipe = {
		{"group:food_pasta", "group:food_cheese", "group:food_bowl"}
	}
})

-- Spaghetti

minetest.register_craftitem("farming:spaghetti", {
	description = S("Spaghetti"),
	inventory_image = "farming_spaghetti.png",
	on_use = minetest.item_eat(8)
})

tmp = farming.use_utensils and "farming:saucepan" or ""

minetest.register_craft({
	output = "farming:spaghetti",
	recipe = {
		{"group:food_pasta", "group:food_tomato", tmp},
		{"group:food_garlic_clove", "group:food_garlic_clove", ""}
	},
	replacements = {{"group:food_saucepan", "farming:saucepan"}}
})

-- Korean Bibimbap

minetest.register_craftitem("farming:bibimbap", {
	description = S("Bibimbap"),
	inventory_image = "farming_bibimbap.png",
	on_use = minetest.item_eat(8, a.bowl)
})

tmp = farming.use_utensils and "farming:skillet" or ""

minetest.register_craft({
	output = "farming:bibimbap",
	recipe = {
		{tmp, "group:food_bowl", "group:food_egg"},
		{"group:food_rice", "group:food_chicken_raw", "group:food_cabbage"},
		{"group:food_carrot", "group:food_chili_pepper", ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

minetest.register_craft({
	output = "farming:bibimbap",
	type = "shapeless",
	recipe = {
		tmp, "group:food_bowl", "group:food_mushroom",
		"group:food_rice", "group:food_cabbage", "group:food_carrot",
		"group:food_mushroom", "group:food_chili_pepper"
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- Burger

minetest.register_craftitem("farming:burger", {
	description = S("Burger"),
	inventory_image = "farming_burger.png",
	on_use = minetest.item_eat(16),
})

minetest.register_craft({
	output = "farming:burger",
	recipe = {
		{a.bread, "group:food_meat", "group:food_cheese"},
		{"group:food_tomato", "group:food_cucumber", "group:food_onion"},
		{"group:food_lettuce", "", ""}
	}
})

-- Salad

minetest.register_craftitem("farming:salad", {
	description = S("Salad"),
	inventory_image = "farming_salad.png",
	on_use = minetest.item_eat(8, a.bowl)
})

minetest.register_craft({
	output = "farming:salad",
	type = "shapeless",
	recipe = {
		"group:food_bowl", "group:food_tomato", "group:food_cucumber",
		"group:food_lettuce", "group:food_oil"
	}
})

-- Triple Berry Smoothie

minetest.register_craftitem("farming:smoothie_berry", {
	description = S("Triple Berry Smoothie"),
	inventory_image = "farming_berry_smoothie.png",
	on_use = minetest.item_eat(6, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})

minetest.register_craft({
	output = "farming:smoothie_berry",
	type = "shapeless",
	recipe = {
		"group:food_raspberries", "group:food_blackberries",
		"group:food_strawberry", "group:food_banana",
		a.drinking_glass
	}
})

-- Patatas a la importancia

minetest.register_craftitem("farming:spanish_potatoes", {
	description = S("Spanish Potatoes"),
	inventory_image = "farming_spanish_potatoes.png",
	on_use = minetest.item_eat(8, a.bowl),
})

tmp = farming.use_utensils and "farming:skillet" or ""

minetest.register_craft({
	type = "shapeless",
	output = "farming:spanish_potatoes",
	recipe = {
		"group:food_potato", "group:food_parsley", "group:food_potato",
		"group:food_egg", a.flour, "group:food_onion",
		"farming:garlic_clove", "group:food_bowl", tmp
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- Potato omelet

minetest.register_craftitem("farming:potato_omelet", {
	description = S("Potato omelet"),
	inventory_image = "farming_potato_omelet.png",
	on_use = minetest.item_eat(6, a.bowl)
})

tmp = farming.use_utensils and "farming:skillet" or ""

minetest.register_craft({
	output = "farming:potato_omelet",
	recipe = {
		{"group:food_egg", "group:food_potato", "group:food_onion"},
		{tmp, "group:food_bowl", ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- Paella

minetest.register_craftitem("farming:paella", {
	description = S("Paella"),
	inventory_image = "farming_paella.png",
	on_use = minetest.item_eat(8, a.bowl)
})

tmp = farming.use_utensils and "farming:skillet" or ""

minetest.register_craft({
	output = "farming:paella",
	recipe = {
		{"group:food_rice", a.dye_orange, "farming:pepper_red"},
		{"group:food_peas", "group:food_chicken", "group:food_bowl"},
		{"", tmp, ""}
	},
	replacements = {{"group:food_skillet", "farming:skillet"}}
})

-- Flan

minetest.register_craftitem("farming:flan", {
	description = S("Vanilla Flan"),
	inventory_image = "farming_vanilla_flan.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	output = "farming:flan",
	recipe = {
		{"group:food_sugar", "group:food_milk", "farming:caramel"},
		{"group:food_egg", "group:food_egg", "farming:vanilla_extract"}
	},
	replacements = {
		{"cucina_vegana:soy_milk", a.drinking_glass},
		{"mobs:bucket_milk", "bucket:bucket_empty"},
		{"mobs:wooden_bucket_milk", "wooden_bucket:bucket_wood_empty"},
		{"farming:vanilla_extract", a.glass_bottle}
	}
})

-- Vegan Cheese

minetest.register_craftitem("farming:cheese_vegan", {
	description = S("Vegan Cheese"),
	inventory_image = "farming_cheese_vegan.png",
	on_use = minetest.item_eat(2),
	groups = {food_cheese = 1, flammable = 2}
})

tmp = farming.use_utensils and "farming:pot" or ""

minetest.register_craft({
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "farming:bottle_ethanol"},
		{"group:food_gelatin", tmp, ""}
	},
	replacements = {
		{"farming:soy_milk", a.drinking_glass .. " 3"},
		{"farming:pot", "farming:pot"},
		{"farming:bottle_ethanol", a.glass_bottle}
	}
})

minetest.register_craft({
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "group:food_lemon"},
		{"group:food_gelatin", tmp, ""}
	},
	replacements = {
		{"farming:soy_milk", a.drinking_glass .. " 3"},
		{"farming:pot", "farming:pot"}
	}
})

-- Onigiri

minetest.register_craftitem("farming:onigiri", {
	description = S("Onigiri"),
	inventory_image = "farming_onigiri.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 2}
})

minetest.register_craft({
	output = "farming:onigiri",
	recipe = {
		{"group:food_rice", "group:food_salt", "group:food_rice"},
		{"", "group:food_seaweed", ""}
	}
})

-- Gyoza

minetest.register_craftitem("farming:gyoza", {
	description = S("Gyoza"),
	inventory_image = "farming_gyoza.png",
	on_use = minetest.item_eat(4),
	groups = {flammable = 2}
})

tmp = farming.use_utensils and "farming:skillet" or ""

minetest.register_craft({
	output = "farming:gyoza 4",
	recipe = {
		{"group:food_cabbage", "group:food_garlic_clove", "group:food_onion"},
		{"group:food_meat_raw", "group:food_salt", a.flour},
		{"", tmp, ""}

	},
	replacements = {
		{"group:food_skillet", "farming:skillet"}
	}
})

-- Mochi

minetest.register_craftitem("farming:mochi", {
	description = S("Mochi"),
	inventory_image = "farming_mochi.png",
	on_use = minetest.item_eat(3),
	groups = {flammable = 2}
})

tmp = farming.use_utensils and "farming:mortar_pestle" or ""

minetest.register_craft({
	output = "farming:mochi",
	recipe = {
		{"", tmp, ""},
		{"group:food_rice", "group:food_sugar", "group:food_rice"},
		{"", "farming:glass_water", ""}
	},
	replacements = {
		{"group:food_mortar_pestle", "farming:mortar_pestle"},
		{"farming:glass_water", a.drinking_glass}
	}
})

-- Gingerbread Man

minetest.register_craftitem("farming:gingerbread_man", {
	description = S("Gingerbread Man"),
	inventory_image = "farming_gingerbread_man.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "farming:gingerbread_man 3",
	recipe = {
		{"", "group:food_egg", ""},
		{"group:food_wheat", "group:food_ginger", "group:food_wheat"},
		{"group:food_sugar", "", "group:food_sugar"}
	}
})
