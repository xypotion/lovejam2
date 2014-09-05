require "script/mapTileDataRaw"

-- where map data is loaded at runtime and then fetched

function loadWorld()
	world = {}
	numberOfMaps = 2
	
	-- TODO use actual dimensions of world map. worldSize or whatever
	-- TODO you keep thinking about Z positions for non-overworld maps, too. just implement it already!	--
	-- for wy = 1,10 do
	-- 	world[wy] = {}
	--
	-- 	for wx = 1,10 do
	-- 		world[wy][wx] = {}
	-- 		insertMap(wx,wy)
	-- 	end
	-- end
	for wid = 1, numberOfMaps do
		world[wid] = makeMap(wid)
	end
end

--the big one. nothing else for it, really.
-- TODO i mean is there any reason not to keep all this data in an external array and just call it from here? seems cleaner...
function makeMap(wid)--wx,wy)
	m = {}
	-- m.events = emptyMapGrid()
	-- m.eventShortcuts = {}
	m.localActorPointers = {}
	
	if wid == 1 then
		m.tiles = mapTileDataRaw[1]
		-- m.mapType = "start"
		m.localActorPointers = {
			{x=8,y=5,id=1},
			{x=13,y=2,id=2}
		}
		m.fastTravelTargetPos = {x=8,y=12} 
		-- m.seen = true
	elseif wid == 2 then
		m.tiles = makeTileGrid(mapTileDataRaw[1])
		-- m.mapType = "start"
		m.localActorPointers = {
			-- {x=8,y=5,id=1},
			-- {x=13,y=2,id=2}
		}
		-- m.fastTravelTargetPos = {x=8,y=12}
		-- m.seen = true
	end

	-- little catch-all for now. derp TODO will have no place in final game
	if not m.tiles then
		m.tiles = makeTileGrid(mapTileDataRaw[2])
		m.mapType = "random"
		m.localActorPointers = {
			{x=8,y=5,id=6}
		}
	end

	--TODO do without mixing chipset into .tiles in raw map data; it IS ok to have a default chipset, note
	if m.tiles.chipset and m.tiles.chipset == 2 then
		m.chipset = 2 --TODO think of something better to call this
	else
		m.chipset = 1
	end

	--...and put it in the world!
	return m--wy][wx] = m
end

function makeTileGrid(raw)
	t = {}
	if not raw.startAt then
		t = raw
	else
		for y=1,yLen do
			t[y] = {}
			for x=1,xLen do
				ping("checking")
				if y<raw.startAt.y or x<raw.startAt.x then
					t[y][x] = 1 --black, empty tile
				elseif y > #(raw) + raw.startAt.y or x > #(raw[y-raw.startAt.y]) + raw.startAt.x then
					t[y][x] = 1 --black, empty tile
				else
					t[y][x] = raw[y-raw.startAt.y][x-raw.startAt.x]
				end
			end
		end
	end
	
	return t
end

-- map.tiles is an array of arrays; this just makes a blank one the same size as that (for something like .events)
function emptyMapGrid()
	t = {}
	for y = 1,(yLen) do
		t[y] = {}
	end

	return t
end

rawTileArray = {}