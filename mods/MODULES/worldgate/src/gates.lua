--
-- Native worldgate generation
--

-- Generate gates if the mod is configured to do so
if minetest.settings:get_bool("worldgate.native",true) then
  -- Define rng based on the world seed
  local pcgr = PcgRandom(minetest.get_mapgen_setting("seed"))

  -- Get distance between gates (spread)
  local spread = minetest.settings:get("worldgate.native.spread",1000) or 1000

  -- Do not generate gates beyond totalmax to prevent any wierdness with world
  -- boundaries
  local totalmax = 29900

  -- Get minimum and maximum y values
  local ymin = math.max(-totalmax,minetest.settings:get("worldgate.ymin",-totalmax) or -totalmax)
  local ymax = math.min(totalmax,minetest.settings:get("worldgate.ymax",totalmax) or totalmax)

  -- Cache frequently used global functions for better performance
  local add_gate = worldgate.add_gate_unsafe -- native gates are made with respect to checks
  local get_random_base = worldgate.get_random_base
  local get_random_decor = worldgate.get_random_decor
  local get_random_quality = worldgate.get_random_quality
  local vn = vector.new

  -- Align coordinate values with 0 for more centered/grounded generation
  local alignment_offset = totalmax - spread * math.floor(totalmax / spread)
  local ymin_offset = -ymin - spread * math.floor(-ymin / spread)
  local ymax_offset = ymax - spread * math.floor(ymax / spread)
  local min = -totalmax + alignment_offset
  local max = totalmax - alignment_offset
  ymin = ymin + ymin_offset
  ymax = ymax - ymax_offset

  -- Generate x/z values with jitter so that worldgate locations are less
  -- predictable
  local xzjitterp = math.floor(spread * (minetest.settings:get("worldgate.native.xzjitter",12.5) or 12.5) / 100)
  local xzjittern = -xzjitterp

  -- Function to get a gate based on an x/y/z coordinate
  local function generate_gate(x,y,z)
    return {
      position = vn(x + pcgr:next(xzjittern,xzjitterp),y + pcgr:next(0,24),z + pcgr:next(xzjittern,xzjitterp)),
      base = get_random_base(pcgr),
      decor = get_random_decor(pcgr),
      quality = get_random_quality(pcgr),
      exact = false,
    }
  end

  -- Link gates if configured, else generate gates with no destinations
  if minetest.settings:get_bool("worldgate.link",true) then
    -- Generate x/z gate definitions for y = 0 since these are the destination
    -- gates of all native gates
    local surface_gates = {}
    for x = min, max, spread do
      for z = min, max, spread do
        local pos = vn(x,0,z)
        local hpos = minetest.hash_node_position(pos)
        surface_gates[hpos] = {
          position = vn(x + pcgr:next(xzjittern,xzjitterp),pcgr:next(0,24),z + pcgr:next(xzjittern,xzjitterp)),
          base = get_random_base(pcgr),
          decor = get_random_decor(pcgr),
          quality = get_random_quality(pcgr),
          exact = false,
          destination = (function() -- placeholder to be converted to an actual gate
            local nhashes = {
              minetest.hash_node_position(vn(x == min and x + spread or x - spread,0,z == min and z + spread or z - spread)),
              minetest.hash_node_position(vn(x == min and x + spread or x - spread,0,z == max and z - spread or z + spread)),
              minetest.hash_node_position(vn(x == max and x - spread or x + spread,0,z == min and z + spread or z - spread)),
              minetest.hash_node_position(vn(x == max and x - spread or x + spread,0,z == max and z - spread or z + spread)),
            }
            local neighbors = {}
            for n = 1, 4 do
              n = nhashes[n]
              local g = surface_gates[n]
              if not g or g.destination ~= hpos then
                neighbors[#neighbors + 1] = n
              end
            end
            return neighbors[1] and neighbors[pcgr:next(1,#neighbors)] or nhashes[pcgr:next(1,4)]
          end)(),
        }
      end

      -- Override gate generation function to generate destinations
      generate_gate = function(x,y,z)
        local pos = vn(x,y,z)
        local gate
        if y == 0 then
          gate = surface_gates[minetest.hash_node_position(pos)]
          gate.destination = surface_gates[gate.destination].position
        else
          gate = {
            position = vn(x + pcgr:next(xzjittern,xzjitterp),y + pcgr:next(0,24),z + pcgr:next(xzjittern,xzjitterp)),
            base = get_random_base(pcgr),
            decor = get_random_decor(pcgr),
            quality = get_random_quality(pcgr),
            exact = false,
          }
          pos.y = 0
          gate.destination = surface_gates[minetest.hash_node_position(pos)].position
        end
        return gate
      end
    end
  end

  -- Generate gates
  for x = min, max, spread do
    for y = ymin, ymax, spread do
      for z = min, max, spread do
        add_gate(generate_gate(x,y,z))
      end
    end
  end
end