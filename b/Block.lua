Block = class()

function Block:_init(color, pos)
	color = color or self.color
	self.color = color
	
	self.sprite = {
		image = images.blocks[color],
		anikey = anikeys.map,
		quadSet = quadSets.block,
	}

	self.currentPos = self.currentPos or pos or {x=2,y=3}
	self.targetPos = {x=self.currentPos.x,y=self.currentPos.y}
	
	self.screenPos = {}
	self:updateScreenPos()
	
	self.interactionBehavior = behaviorsRaw.blocks[color]
	
	self.speed = 100 * zoom -- TODO
	
	ping(color.." block made")
end

function Block:draw()
	local s = self.sprite
	love.graphics.draw(s.image, s.quadSet[s.anikey.frame], self.screenPos.x --[[+ currentMap.offset.x]], self.screenPos.y --[[+ currentMap.offset.y]])
end

function Block:updateScreenPos()
	self.screenPos.x = (self.currentPos.x - 1) * tileSize
	self.screenPos.y = (self.currentPos.y - 1) * tileSize
end

---------------------------------------------------------------------------------------------------------------------
-- static functions

function drawBlocks()
	for i = 1, #blocks do
		blocks[i]:draw()
	end
end

function getBlock(pos)
	for i = 1, #blocks do
		if blocks[i].currentPos.x == pos.x and blocks[i].currentPos.y == pos.y then
			return blocks[i]
		end
	end
	
	return nil
end

function blocksTakeInput(color)
	local direction = nil
	local going = true
	
	if love.keyboard.isDown('d', "right") and not love.keyboard.isDown('a','w','s','left','up','down') then
		direction = "e"
	elseif love.keyboard.isDown('a', "left") and not love.keyboard.isDown('d','w','s','right','up','down') then
		direction = "w"
	elseif love.keyboard.isDown('w', "up") and not love.keyboard.isDown('a','d','s','left','right','down') then
		direction = "n"
	elseif love.keyboard.isDown('s', "down") and not love.keyboard.isDown('a','w','d','left','up','right') then
		direction = "s"
	end
	
	-- showGlobals("rection")
		
	if direction and love.keyboard.isDown('d','a','w','s','right','left','up','down') then
		for i=1,#blocks do
			if blocks[i].color == color then
				blocks[i].facing = direction
				-- if not love.keyboard.isDown('d','a','w','s','right','left','up','down') then
				blocks[i].targetPos = getGridPosInFrontOfActor(blocks[i]) --? TODO
				-- end
				-- tablePrint(blocks[i].targetPos)
			
				going = true and going
				-- ping(going)
	
				-- get & set destination tile type
				if going and blocks[i].targetPos and blocks[i].targetPos ~= blocks[i].currentPos then
					-- local targetTileType = tileType(globalActors.hero.targetPos)
					if tileType(blocks[i].targetPos) == "collide" or
						getGlobalActorByPos(blocks[i].targetPos)
					then
						blocks[i].targetPos = nil
						going = false
					end
				end
			end
			-- blocks.targetDir = nil --? or give each block a target pos? would be slightly easier to cause reactions that way...
		end
	else
		direction = nil
		going = false
	end
	
	return going
end

function blocksGo()
	for i = 1, #blocks do
		-- tablePrint(blocks[i].targetPos)
-- 		tablePrint(blocks[i].currentPos)
		if blocks[i].targetPos and (blocks[i].targetPos.x ~= blocks[i].currentPos.x or blocks[i].targetPos.y ~= blocks[i].currentPos.y) then
			blocks[i].distanceFromTarget = tileSize
		
			blocksShifting = blocksShifting + 1
			-- blocks[i].translatorFunction = walk
			blocks[i].finishFunction = blockStop
		end
	end
	
	ping(blocksShifting)
end

function shiftBlocks(dt)
	-- ping("shifting blokcs")
	
	-- blocks[1].translatorFunction(blocks[1], dt) -- TODO can you use : or class notation somehow? hm
	for i=1,#blocks do
		if blocks[i].color == colorControlled then
			local xDelta = (blocks[i].targetPos.x - blocks[i].currentPos.x) * blocks[i].speed * dt
			local yDelta = (blocks[i].targetPos.y - blocks[i].currentPos.y) * blocks[i].speed * dt

			decrementDistanceFromTarget(blocks[i], math.abs(xDelta) + math.abs(yDelta))
			blocks[i].screenPos.x = blocks[i].screenPos.x + xDelta
			blocks[i].screenPos.y = blocks[i].screenPos.y + yDelta

			if blocks[i].distanceFromTarget <= 0 then
				blocks[i]:stop()
			end
		end
	end
end

function Block:stop()
	self.distanceFromTarget = 0
	self.currentPos = self.targetPos
	self:updateScreenPos()
	
	blocksShifting = blocksShifting - 1
	
	-- print("stop at", self.currentPos.x, self.currentPos.y)
end