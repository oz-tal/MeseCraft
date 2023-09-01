
local S = minetest.get_translator("portal_rail")

local function portal_on_step(cart, dtime)
	local jump = minetest.settings:get("portal_rail_jump_distance") or 500
	local jmp_pos = table.copy(cart.old_pos)
	local move_diagonally = minetest.settings:get_bool("portal_rail_diagonal_teleport") or false

	if cart.old_dir.y == -1  then
		jmp_pos.y = jmp_pos.y - jump
	elseif cart.old_dir.y == 1 then
		jmp_pos.y = jmp_pos.y + jump
	end

	if cart.old_dir.y == 0 or move_diagonally then
		if cart.old_dir.x == -1  then
			jmp_pos.x = jmp_pos.x - jump
		elseif cart.old_dir.x == 1 then
			jmp_pos.x = jmp_pos.x + jump
		elseif cart.old_dir.z == -1  then
			jmp_pos.z = jmp_pos.z - jump
		elseif cart.old_dir.z == 1 then
			jmp_pos.z = jmp_pos.z + jump
		end
	end

	minetest.load_area(jmp_pos)

	local node = minetest.get_node(jmp_pos)

	if not node then return end

	-- if no 'landing' rail don't jump
	if minetest.get_item_group(node.name, "rail") == 0 then return end

	minetest.sound_play("portal_rail_pop", old_pos, true)
	minetest.log("action","Cart used rail to teleport from (".. 
		cart.old_pos.x..", "..cart.old_pos.y..", "..cart.old_pos.z..") to ("..
		jmp_pos.x..", "..jmp_pos.y..", "..jmp_pos.z..")")
	cart.old_pos = jmp_pos
	minetest.sound_play("portal_rail_pop", jmp_pos, true)
end

carts:register_rail("portal_rail:rail", {
	description = S("Portal Rail"),
	tiles = {
		"portal_rail_straight.png", "portal_rail_curved.png",
		"portal_rail_t_junction.png", "portal_rail_crossing.png"
	},
	groups = carts:get_rail_groups(),
}, { on_step = portal_on_step })

-- recipe for zero modpack
if (minetest.get_modpath("mese") ~= nil and minetest.get_modpath("iron") ~= nil ) then
	minetest.register_craft({
 	output = "portal_rail:rail 1",
 	recipe = {
 		{"iron:ingot", "mese:crystal", "iron:ingot"},
 		{"iron:ingot", "mese:crystal_fragment", "iron:ingot"},
 		{"iron:ingot", "mese:crystal", "iron:ingot"},
 	}
 })
-- recipe for minetest game
elseif (minetest.get_modpath("default") ~= nil) then
	minetest.register_craft({
 	output = "portal_rail:rail 1",
 	recipe = {
 		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
 		{"default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot"},
 		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
 	}
 })
end
