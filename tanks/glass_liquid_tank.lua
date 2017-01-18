-- This is the empty glass tank
minetest.register_node("buildtest:glass_liquid_tank_0", {
    tiles = {
        "buildtest_glass_liquid_tank_side_0.png"
    },
    drawtype = "nodebox",
    paramtype = "light",
    groups = {cracky = 3, oddly_breakable_by_hand=3},
    description = "Glass liquid tank",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        }
    },
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        if itemstack:get_name() == "bucket:bucket_water" then
            minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_water_1"})
            itemstack:replace("bucket:bucket_empty")
        end
    end
    })

function add_liquid(pos)
    -- This for loop runs 10 nodes up from the pointed node
    for var = 1,10 do
        -- get the tank name
        top_tank_name = minetest.get_node({x = pos.x, y = pos.y + var, z = pos.z}).name
        -- get the amount of liquid in the tank
        top_tank_liquid_level = string.sub(top_tank_name, -1)
        -- get the tank pos
        top_tank_pos = {x = pos.x, y = pos.y + var, z = pos.z}
            if top_tank_liquid_level ~= "5" then
                -- If we find a tank that isn't full break
                break
            end
        end
    -- The name of the tank being pointed at
    tank_name = minetest.get_node({x = pos.x, y = pos.y, z = pos.z}).name
    -- TODO replace this check with one that checks for all liquids not just water
    if string.sub(tank_name, -7, -3) == "water" then
        -- Get the amount of liquid in the tank and convert it to a number
        tank_liquid_level = tonumber(string.sub(tank_name, -1))
        if tank_liquid_level ~= 5 then
            minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name="buildtest:glass_liquid_tank_water_" .. tank_liquid_level + 1})
            return true
        elseif string.sub(top_tank_name, -7, -3) == "water" then
            minetest.set_node(top_tank_pos, {name="buildtest:glass_liquid_tank_water_" .. tonumber(string.sub(top_tank_name, -1)) + 1})
            return true
        end
    end
    return false
end



-- A for loop that registers all our water tank nodes
for liquid_level=1,5 do
    -- The number at the end is how much liquid is in it
    -- 1 notch is 1 source block and 5 is full
    minetest.register_node("buildtest:glass_liquid_tank_water_" .. liquid_level, {
        tiles = {
            "buildtest_glass_liquid_tank_water_side_" .. liquid_level .. ".png"
        },
        drawtype = "nodebox",
        paramtype = "light",
        groups = {cracky = 3, oddly_breakable_by_hand=3},
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            }
        },
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            if itemstack:get_name() == "bucket:bucket_water" then
                local remove_bucket = add_liquid(pos, liquid)
                if remove_bucket == true then
                    itemstack:replace("bucket:bucket_empty")
                end
            elseif itemstack:get_name() == "bucket:bucket_empty" and liquid_level == 1 then
                minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_" .. liquid_level - 1})
                itemstack:replace("bucket:bucket_water")
            elseif itemstack:get_name() == "bucket:bucket_empty" and liquid_level >= 1 then
                minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_water_" .. liquid_level - 1})
                itemstack:replace("bucket:bucket_water")
            end
        end
    })
end





-- A for loop that registers all our water tank nodes
for liquid_level=1,5 do
    -- The number at the end is how much liquid is in it
    -- 1 notch is 1 source block and 5 is full
    minetest.register_node("buildtest:glass_liquid_tank_lava_" .. liquid_level, {
        tiles = {
            "buildtest_glass_liquid_tank_lava_side_" .. liquid_level .. ".png"
        },
        drawtype = "nodebox",
        paramtype = "light",
        groups = {cracky = 3, oddly_breakable_by_hand=3},
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            }
        },
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            if itemstack:get_name() == "bucket:bucket_lava" and liquid_level < 5 then
                minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_lava_" .. liquid_level + 1})
                itemstack:replace("bucket:bucket_empty")
            elseif itemstack:get_name() == "bucket:bucket_empty" and liquid_level == 1 then
                minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_" .. liquid_level - 1})
                itemstack:replace("bucket:bucket_lava")
            elseif itemstack:get_name() == "bucket:bucket_empty" and liquid_level >= 1 then
                minetest.set_node({x = pos.x, y = pos.y , z = pos.z}, {name="buildtest:glass_liquid_tank_lava_" .. liquid_level - 1})
                itemstack:replace("bucket:bucket_lava")
            end
        end
    })
end
