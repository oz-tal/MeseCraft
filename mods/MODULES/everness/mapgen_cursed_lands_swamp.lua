--[[
    Everness. Never ending discovery in Everness mapgen.
    Copyright (C) 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

--
-- Register biomes
--

local y_max = Everness.settings.biomes.everness_cursed_lands_swamp.y_max
local y_min = Everness.settings.biomes.everness_cursed_lands_swamp.y_min

-- Cursed Lands Swamp

minetest.register_biome({
    name = 'everness_cursed_lands_swamp',
    node_top = 'everness:cursed_stone',
    depth_top = 1,
    node_filler = 'everness:cursed_stone',
    depth_filler = 3,
    node_riverbed = 'everness:cursed_stone',
    depth_riverbed = 2,
    node_stone = 'everness:cursed_stone_carved',
    node_dungeon = 'everness:cursed_sandstone_brick',
    node_dungeon_alt = 'everness:cursed_sandstone_block',
    node_dungeon_stair = 'stairs:stair_cursed_sandstone_brick',
    y_max = y_max,
    y_min = y_min,
    heat_point = 45,
    humidity_point = 85,
})

--
-- Register ores
--

-- Blob ore.
-- These before scatter ores to avoid other ores in blobs.

-- Sand

minetest.register_ore({
    ore_type = 'blob',
    ore = 'everness:cursed_sand',
    wherein = { 'everness:cursed_stone_carved' },
    clust_scarcity = 16 * 16 * 16,
    clust_size = 5,
    y_max = y_max,
    y_min = y_min,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.2,
        spread = { x = 5, y = 5, z = 5 },
        seed = 2316,
        octaves = 1,
        persist = 0.0
    },
    biomes = { 'everness_cursed_lands_swamp' }
})

-- Dirt

minetest.register_ore({
    ore_type = 'blob',
    ore = 'everness:cursed_dirt',
    wherein = { 'everness:cursed_stone_carved' },
    clust_scarcity = 16 * 16 * 16,
    clust_size = 5,
    y_max = y_max,
    y_min = y_min,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.2,
        spread = { x = 5, y = 5, z = 5 },
        seed = 766,
        octaves = 1,
        persist = 0.0
    },
    biomes = { 'everness_cursed_lands_swamp' }
})

-- Mud

minetest.register_ore({
    ore_type = 'blob',
    ore = 'everness:cursed_mud',
    wherein = { 'everness:cursed_stone_carved' },
    clust_scarcity = 16 * 16 * 16,
    clust_size = 5,
    y_max = y_max,
    y_min = y_min,
    noise_threshold = 0.0,
    noise_params = {
        offset = 0.5,
        scale = 0.2,
        spread = { x = 5, y = 5, z = 5 },
        seed = 17676,
        octaves = 1,
        persist = 0.0
    },
    biomes = { 'everness_cursed_lands_swamp' }
})

-- Scatter ores

-- Coal

minetest.register_ore({
    ore_type = 'scatter',
    ore = 'everness:cursed_stone_carved_with_coal',
    wherein = 'everness:cursed_stone_carved',
    clust_scarcity = 8 * 8 * 8,
    clust_num_ores = 9,
    clust_size = 3,
    y_max = y_max,
    y_min = y_min,
    biomes = { 'everness_cursed_lands_swamp' }
})

--
-- Register decorations
--

minetest.register_decoration({
    name = 'everness:cursed_lands_swamp_dry_tree',
    deco_type = 'schematic',
    place_on = { 'everness:cursed_stone' },
    place_offset_y = 0,
    sidelen = 16,
    -- Noise tuned to place swamp trees where papyrus is absent
    noise_params = {
        offset = 0.0,
        scale = -0.1,
        spread = { x = 200, y = 200, z = 200 },
        seed = 354,
        octaves = 1,
        persist = 0.5
    },
    biomes = { 'everness_cursed_lands_swamp' },
    y_max = y_min,
    y_min = y_min,
    schematic = minetest.get_modpath('everness') .. '/schematics/everness_dry_tree.mts',
    flags = 'place_center_x, place_center_z',
    rotation = 'random',
})

minetest.register_decoration({
    name = 'everness:cursed_lands_swamp_marsh_grass',
    deco_type = 'schematic',
    place_on = { 'everness:cursed_stone' },
    place_offset_y = 1,
    sidelen = 16,
    -- Noise tuned to place where papyrus is absent
    noise_params = {
        offset = 0.0,
        scale = -0.1,
        spread = { x = 200, y = 200, z = 200 },
        seed = 354,
        octaves = 1,
        persist = 0.5
    },
    biomes = { 'everness_cursed_lands_swamp' },
    y_max = y_max,
    y_min = y_max,
    schematic = minetest.get_modpath('everness') .. '/schematics/everness_marsh_grass.mts',
})
