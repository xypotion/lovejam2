--[[
- initializers for background tiles & tile system
- basic generation, nested-table-based storage, scrolling, and animation for certain tiles
- uses SpriteBatch to improve performance
]] 

function initMapSystem()
	screenShifting = false
	
	mapDrawOffsets = {}
	mapDrawOffsets.current = {x=0,y=0}
	mapDrawOffsets.next = {x=0,y=0}
	mapDrawOffsets.countdown = 0
	
	scrollSpeed = 500 * zoom
	
	loadWorld()
		
	currentMap = world[worldPos]--.y][worldPos.x]
	
	updateMapSpriteBatchFramesCurrent()
	
	loadLocalActors()
end

------------------------------------------------------------------------------------------------------

--moved from main, feel free to move again if necessary
function arrivalInteraction() --"arrived at tile; is something supposed to happen?"	
	-- check for actor interaction. GLOBAL ACTORS NEVER COLLIDE OR INTERACT
	local event = getLocalActorByPos(globalActors.hero.currentPos)
	if event then
		ping ("found an event")
		interactWith(event)
	end
end

function tileType(tile)	
	_type = "clear"
	-- if tile.x == xLen + 1 then
	-- 	--somewhat redundant as these values are translated immediately in heroGo() to the more useful worldDest. fine for now, though (TODO?)
	-- 	_type = "east edge"
	-- elseif tile.y == yLen + 1 then
	-- 	_type = "south edge"
	-- else
	-- 	if not currentMap.tiles[tile.y] then
	-- 		_type = "north edge"
	-- 	elseif not currentMap.tiles[tile.y][tile.x] then
	-- 		_type = "west edge"
	-- 	else
			
			-- it's not beyond map edges; so check collision map for chipset
			if not collisionMatrix[currentMap.tiles[tile.y][tile.x]] then
				_type = "collide"
			else
				
				--theoretically clear on the tile level, now a check actor collision. GLOBAL ACTORS NEVER COLLIDE OR INTERACT
				localActor = getLocalActorByPos(tile)
				if localActor and localActor.collide then
					_type = "collide"
				end
 			-- end
		-- end
	end
	
	return _type
end

-- function triggerScreenShiftTo(tmi) --"target map index"
-- 	worldDest = tmi
--
-- 	nextMap = getMap(worldDest)
--
-- 	--shifting horizontally or vertically?
-- 	if worldDest.x == worldPos.x then
-- 		mapDrawOffsets.next.y = (worldDest.y - worldPos.y) * yLen * tileSize
-- 	elseif worldDest.y == worldPos.y then
-- 		mapDrawOffsets.next.x = (worldDest.x - worldPos.x) * xLen * tileSize
-- 	else
-- 		print("something has gone very wrong in triggerScreenShiftTo()")
-- 	end
--
-- 	mapDrawOffsets.countdown = math.abs(mapDrawOffsets.next.x + mapDrawOffsets.next.y)
--
-- 	updateMapSpriteBatchFramesNext()
--
-- 	screenShifting = true
-- end

-- function shiftTiles(dt)
-- 	local xDelta = (worldPos.x - worldDest.x) * scrollSpeed * dt
-- 	local yDelta = (worldPos.y - worldDest.y) * scrollSpeed * dt
--
-- 	mapDrawOffsets.current.x = mapDrawOffsets.current.x + xDelta
-- 	mapDrawOffsets.current.y = mapDrawOffsets.current.y + yDelta
-- 	mapDrawOffsets.next.x = mapDrawOffsets.next.x + xDelta
-- 	mapDrawOffsets.next.y = mapDrawOffsets.next.y + yDelta
--
-- 	mapDrawOffsets.countdown = mapDrawOffsets.countdown - math.abs(xDelta + yDelta)
--
-- 	if mapDrawOffsets.countdown <= 0 then
-- 		mapArrive()
-- 		updateMapSpriteBatchFramesCurrent()
-- 	end
-- end

function mapArrive()
	-- ping(currentMap)
	currentMap = nextMap
	-- ping(currentMap)
	worldPos = worldDest
	nextMap = nil
	screenShifting = nil

	mapDrawOffsets.next.x = 0
	mapDrawOffsets.current.x = 0
	mapDrawOffsets.next.y = 0
	mapDrawOffsets.current.y = 0
	mapDrawOffsets.countdown = 0
	
	updateMapSpriteBatchFramesCurrent()
	
	loadLocalActors()
	
	currentMap.seen = true
end

function updateMapSpriteBatchFramesCurrent()
	 mapSpriteBatchFramesCurrent = updateMapSpriteBatchFrames(currentMap.chipset, currentMap.tiles)
end

function updateMapSpriteBatchFramesNext()
	mapSpriteBatchFramesNext = updateMapSpriteBatchFrames(nextMap.chipset, nextMap.tiles)
end

function updateMapSpriteBatchFrames(chipset, _tiles)
	t = {}

	for frame = 1, anikeys.map.count do 
		-- i used to only call newSpriteBatch at init, but it turns out it's not that slow!
		t[frame] = love.graphics.newSpriteBatch(images.chipsets[chipset], xLen * yLen) 
		
	  t[frame]:bind()
	  t[frame]:clear()
	  for y=1, yLen do
	    for x=1, xLen do
				if type(mapTileQuads[_tiles[y][x]]) == "table" then --TODO this is a little inelegant. could maybe use modulus?
		      t[frame]:add(mapTileQuads[_tiles[y][x]][frame], (x-1)*tileSize, (y-1)*tileSize)
				else
		      t[frame]:add(mapTileQuads[_tiles[y][x]], (x-1)*tileSize, (y-1)*tileSize)
				end
	    end
	  end
	  t[frame]:unbind()
	end
	
	return t
end

function drawMap()
	love.graphics.draw(mapSpriteBatchFramesCurrent[anikeys.map.frame], mapDrawOffsets.current.x, mapDrawOffsets.current.y)
	
	if screenShifting then
		love.graphics.draw(mapSpriteBatchFramesNext[anikeys.map.frame], mapDrawOffsets.next.x, mapDrawOffsets.next.y)
	end
	-- love.graphics.draw(mapSpriteBatchFramesCurrent[anikeys.map.frame], mapDrawOffsets.current.x + xMargin, mapDrawOffsets.current.y + yMargin)
	--
	-- if screenShifting then
	-- 	love.graphics.draw(mapSpriteBatchFramesNext[anikeys.map.frame], mapDrawOffsets.next.x + xMargin, mapDrawOffsets.next.y + yMargin)
	-- end
end

function getGridPosInFrontOfActor(a) --TODO move to actorManager?
	local pos = {}
	
	if a.facing == "s" then
		pos = {x = a.currentPos.x, y = a.currentPos.y + 1}
	elseif a.facing == "n" then
		pos = {x = a.currentPos.x, y = a.currentPos.y - 1}
	elseif a.facing == "e" then
		pos = {x = a.currentPos.x + 1, y = a.currentPos.y}
	elseif a.facing == "w" then
		pos = {x = a.currentPos.x - 1, y = a.currentPos.y}
	else
		print "ERROR: actor's facing not n/e/w/s. what's the bizness?"
	end
	
	return pos
end

function getMap(tmi) --"target map index"
	return world[tmi]--(tmi.y - 1) % 10 + 1][(tmi.x - 1) % 10 + 1] --TODO 10 -> worldSize or whatever
	
	--if you want to make the world not loop anymore...
	-- return world[tmi.y][tmi.x]
end