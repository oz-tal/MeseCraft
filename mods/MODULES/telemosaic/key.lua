
minetest.register_tool("telemosaic:key", {
	description = "Telemosaic Key",
	inventory_image = "telemosaic_key.png",
	stack_max = 1,
	groups = {not_in_creative_inventory = 1},
	on_use = function(itemstack, player, pointed_thing)
		if pointed_thing.type == "node" then
			-- Use key to toggle telemosaic on/off
			local name = player:get_player_name()
			local pos = pointed_thing.under
			local state = telemosaic.get_state(pos)
			if state == "active" and not minetest.is_protected(pos, name) then
				telemosaic.set_state(pos, "disabled")
			elseif state == "disabled" and not minetest.is_protected(pos, name) then
				telemosaic.set_state(pos, "active")
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	type = "shapeless",
	recipe = {"telemosaic:key"},
	output = "default:mese_crystal_fragment"
})
