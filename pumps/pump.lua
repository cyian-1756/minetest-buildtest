minetest.register_node("buildtest:pump", {
	--tiles = {"buildtest_pump_mesecon.png"},
	description = "Buildtest Liquids Pump",
	groups = {choppy=1,oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	buildtest = {
		pipe_groups = {
			type = "liquid",
		},
		power = {
		},
	},
	on_construct = function(pos)
	end,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-0.5,-0.5,-0.5,0.5,0.5,0.5}}
	},
	selection_box = {{
		0.5,0.5,0.5,-0.5,-0.5,-0.5,
	}},
	on_place = function(itemstack, placer, pointed_thing)
		local itemstk=minetest.item_place(itemstack, placer, pointed_thing)
		for i=1,6 do
			buildtest.pipes.processNode(vector.add(pointed_thing.above,buildtest.toXY(i)))
		end
		return itemstk
	end
})

buildtest.pumps.pumpible["buildtest:pump"] = {
	power = function(pos, speed)
		local topos = buildtest.pumps.findpipe(pos)
		local pumppipepos = {x=pos.x, y=pos.y-1, z=pos.z}
        -- Gets the name of what is under the pump
		local pipename = minetest.get_node(pumppipepos).name
        -- If the pump is over pump pipe looks 1 block lower
		while pipename=="buildtest:pump_pipe" do
			pumppipepos.y = pumppipepos.y - 1
			pipename = minetest.get_node(pumppipepos).name
		end

		local pipedef = minetest.registered_nodes[pipename]
		if pipedef==nil then return end
        -- If the block under the pump is air or liquid replaces it with pump pipe
		if pipename=="air" or pipedef.liquidtype == "source" or pipedef.liquidtype == "flowing" then
			minetest.set_node(pumppipepos, {name="buildtest:pump_pipe"})
			if pipedef.liquidtype == "source" then
                -- Sends liquid block thru pipe
				buildtest.makeEnt(topos, {name=pipename}, speed, pos)
			end
		end
	end,
}

minetest.register_node("buildtest:pump_pipe", {
	groups = {oddly_breakable_by_hand=3},
    node_box = {
		type = "fixed",
		fixed = {-0.5,-0.25,-0.25, -0.25,0.25,0.25},
	},
    tiles = {
		"buildtest_pump_pipe.png",
	},
})

-- minetest.register_abm({
--	nodenames = {"default:lava_source"},
--	neighbors = {"buildtest:pump_pipe_act"},
--	interval = 10,
--	chance = 1,
--	action = function(pos, node)
--		minetest.set_node(pos, {name="buildtest:pump_pipe_act"})
--	end,
-- })
