local height = minetest.settings:get('redef_grass_box_height') or '2'
local target = -0.5 + (tonumber(height) * 0.0625)

local function register_grass_nodes(grass_nodes)
    for _,grass in pairs(grass_nodes) do
        local current_box = minetest.registered_nodes[grass].selection_box.fixed
        if (current_box[5] > target) then
            minetest.override_item(grass, {
                selection_box = {
                    type = 'fixed',
                    fixed = {
                        current_box[1],
                        current_box[2],
                        current_box[3],
                        current_box[4],
                        target,
                        current_box[6]
                    }
                }
            })
        end
    end
end

register_grass_nodes({
    'default:junglegrass',
    'default:dry_grass_1',
    'default:dry_grass_2',
    'default:dry_grass_3',
    'default:dry_grass_4',
    'default:dry_grass_5',
    'default:grass_1',
    'default:grass_2',
    'default:grass_3',
    'default:grass_4',
    'default:grass_5',
})

if minetest.get_modpath("everness") then
    register_grass_nodes({
        'everness:dry_grass_1',
        'everness:dry_grass_2',
        'everness:dry_grass_3',
        'everness:dry_grass_4',
        'everness:coral_grass_1',
        'everness:coral_grass_2',
        'everness:coral_grass_3',
        'everness:coral_grass_4',
        'everness:coral_grass_5',
    })
end
