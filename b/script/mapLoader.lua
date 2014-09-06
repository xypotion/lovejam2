require "script/mapTileDataRaw"

-- where map data is loaded at runtime and then fetched

function loadWorld()
	world = {}
	numberOfMaps = 3
	
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
	-- m = {}
	-- -- m.events = emptyMapGrid()
	-- -- m.eventShortcuts = {}
	-- m.localActorPointers = {}
	--
	-- if wid == 1 then
	-- 	m.tiles = mapTileDataRaw[1]
	-- 	-- m.mapType = "start"
	-- 	m.localActorPointers = {
	-- 		{x=8,y=5,id=1},
	-- 		{x=13,y=2,id=2}
	-- 	}
	-- 	m.fastTravelTargetPos = {x=8,y=12}
	-- 	-- m.seen = true
	-- elseif wid == 2 then
	-- 	m.tiles = makeTileGrid(mapTileDataRaw[2])
	-- 	-- m.mapType = "start"
	-- 	m.localActorPointers = {
	-- 		-- {x=8,y=5,id=1},
	-- 		-- {x=13,y=2,id=2}
	-- 	}
	-- end
	
	m = mapDataRaw[wid]
	m.tiles = makeTileGrid(m)--.tileData)

	-- little catch-all for now. derp TODO will have no place in final game
	if not m.tiles then
		m.tiles = makeTileGrid(mapDataRaw[2])
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
		t = raw.tileData
	else
		for y=1,yLen do
			t[y] = {}
			for x=1,xLen do
				if y < raw.startAt.y or --above top tile
					x < raw.startAt.x or --to the left of leftmost tile
					y >= #(raw.tileData) + raw.startAt.y or 	--below bottom tile
					raw[y-raw.startAt.y+1] and x >= #(raw.tileData[y-raw.startAt.y+1]) + raw.startAt.x or --to the right of rightmost tile
					not raw.tileData[y-raw.startAt.y+1][x-raw.startAt.x+1] --within bounds but nothing there (e.g. when map's not rectangular)
				then
					t[y][x] = raw.startAt.default
				else
					t[y][x] = raw.tileData[y-raw.startAt.y+1][x-raw.startAt.x+1]
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

function loadBlocks()
	blocks = {}
	local i = 1
	
	if currentMap.blocks and currentMap.blocksAt then
		for y = 1, #(currentMap.blocks) do
			for x = 1, #(currentMap.blocks[y]) do
				if currentMap.blocks[y][x] then
					print(currentMap.blocks[y][x], y+currentMap.blocksAt.y, x+currentMap.blocksAt.x)
					blocks[i] = Block(currentMap.blocks[y][x],{y=y+currentMap.blocksAt.y, x=x+currentMap.blocksAt.x})
					i = i + 1
				end
			end
		end
	end
end

-- rawTileArray = {}