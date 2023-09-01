local mod_name = "holosurveilance"

minetest.register_entity(mod_name..":holoblock", {
	initial_properties = {
		physical = true,
		visual = "cube",
		visual_size = {x = 0.0625, y = 0.0625, z = 0.0625},
		collisionbox = {0, 0, 0, 0, 0, 0},
		textures = {"holo.png", "holo.png", "holo.png", "holo.png", "holo.png", "holo.png"}
	},
	on_step = function(self, dtime)
		if self.lifetime and self.lifetime <= 0 then
			self.object:remove()
		else
			self.lifetime = (self.lifetime or 5) - dtime
		end
	end
})

minetest.register_entity(mod_name..":holoplayer", {
	initial_properties = {
		physical = true,
		visual = "cube",
		visual_size = {x = 0.0625, y = 0.0625, z = 0.0625},
		collisionbox = {0, 0, 0, 0, 0, 0},
		textures = {"holoplayer.png", "holoplayer.png", "holoplayer.png", "holoplayer.png", "holoplayer.png", "holoplayer.png"}
	},
	on_step = function(self, dtime)
		if self.lifetime and self.lifetime <= 0 then
			self.object:remove()
		else
			self.lifetime = (self.lifetime or 2) - dtime
		end
	end
})

minetest.register_entity(mod_name..":holoregion", {
	initial_properties = {
		physical = true,
		visual = "cube",
		visual_size = {x = 16, y = 16, z = 16},
		collisionbox = {0, 0, 0, 0, 0, 0},
		textures = {"regionmarker.png", "regionmarker.png", "regionmarker.png", "regionmarker.png", "regionmarker.png", "regionmarker.png"}
	},
	on_step = function(self, dtime)
		if self.lifetime and self.lifetime <= 0 then
			self.object:remove()
		else
			self.lifetime = (self.lifetime or 2) - dtime
		end
	end
})

minetest.register_node(mod_name..":holo", {
	description = "Stone",
	-- Textures of node; +Y, -Y, +X, -X, +Z, -Z
	tiles = {"top.png", "sides.png"},
	groups = {oddly_breakable_by_hand = 2},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		meta:set_int("X", 0)
		meta:set_int("Y", 0)
		meta:set_int("Z", 0)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local formspec = "size[5,5]" ..
			"label[0.5,0.5;Scan Pos:]" ..
			"field[1,2;1,1;x;X:;".. meta:get_int("X") .."]" ..
			"field[2,2;1,1;y;Y:;".. meta:get_int("Y")  .."]" ..
			"field[3,2;1,1;z;Z:;".. meta:get_int("Z")  .."]" ..
			"button[1,3;3,1;show;Toggle Highlight]"..
			"button_exit[1,4.5;3,1;submit;Submit]"
		clicker:get_meta():set_string("holonode", minetest.serialize(pos))
		minetest.show_formspec(clicker:get_player_name(), "surveilance_area", formspec)
	end,
})

minetest.register_abm({
	label = "Holo Update",
	nodenames = {mod_name..":holo"},
	interval = 5,
	chance = 1,
	catch_up = false,
	action = function(pos, node)
		local ominp = {x = pos.x - 0.5 + 0.03125, y = pos.y + 0.5 + 0.03125, z = pos.z - 0.5 + 0.03125}
		local meta = minetest.get_meta(pos)
		local scanpos = {x = pos.x + meta:get_int("X"), y = pos.y + meta:get_int("Y"), z = pos.z + meta:get_int("Z")}
		for ix = 0,15,1 do
			for iz = 0,15,1 do
				for iy = 15,0,-1 do
					if minetest.get_node({x = scanpos.x + ix, y = scanpos.y + iy, z = scanpos.z + iz}).name ~= "air" then
						local spos = {x = ominp.x + ix / 16, y = ominp.y + iy / 16, z= ominp.z + iz / 16}
						minetest.add_entity(spos, mod_name..":holoblock")
						break
					end
				end
			end
		end
	end
})

minetest.register_abm({
	label = "Holo Update Player",
	nodenames = {mod_name..":holo"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos, node)
		local ominp = {x = pos.x - 0.5 + 0.03125, y = pos.y + 0.5 + 0.03125, z = pos.z - 0.5 + 0.03125}
		local meta = minetest.get_meta(pos)
		local scanpos = {x = pos.x + meta:get_int("X"), y = pos.y + meta:get_int("Y"), z = pos.z + meta:get_int("Z")}
		local objs = minetest.get_objects_inside_radius({x = scanpos.x + 7, y = scanpos.y + 7, z = scanpos.z + 7}, 12)
		for _, obj in pairs(objs) do
			if obj:is_player() then
				local p = obj:get_pos()
				local spos = {x = ominp.x + ((p.x - scanpos.x) / 8), y = ominp.y + ((p.y - scanpos.y) / 8), z = ominp.z + ((p.z - scanpos.z) / 8)}
				minetest.add_entity(spos, mod_name..":holoplayer")
			end
		end
		if meta:get_int("show") > 0 then
			minetest.add_entity({x = scanpos.x + 8, y = scanpos.y + 8, z = scanpos.z + 8}, mod_name..":holoregion")
		end
	end
})


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "surveilance_area" then
		if fields["submit"] then
			local pos = minetest.deserialize(player:get_meta():get_string("holonode"))
			local meta = minetest.get_meta(pos)
			meta:set_int("X", tonumber(fields["x"]))
			meta:set_int("Y", tonumber(fields["y"]))
			meta:set_int("Z", tonumber(fields["z"]))
		elseif fields["show"] then
			local pos = minetest.deserialize(player:get_meta():get_string("holonode"))
			local meta = minetest.get_meta(pos)
			meta:set_int("show", (meta:get_int("show") > 0) and 0 or 1)
		end
	end
end)