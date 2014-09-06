Block = class()

function Block:_init(color, pos)
	color = color or self.color
	self.color = color or "green"
	self:setColorSpecificStuff()
	-- self.sprite = {
	-- 	image = images.blocks[color],
	-- 	anikey = anikeys.map,
	-- 	quadSet = quadSets.block,
	-- }

	-- self.targetColor = "cyan"
	-- self.targetImageOpacity = 0

	self.currentPos = self.currentPos or pos or {x=2,y=3}
	self.targetPos = nil--{x=self.currentPos.x,y=self.currentPos.y}
	
	self.screenPos = {}
	self:updateScreenPos()
	
	self.speed = 100 * zoom -- TODO
	
	ping(color.." block made")
end

function Block:draw()
	local s = self.sprite
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(s.image, s.quadSet[s.anikey.frame], self.screenPos.x --[[+ currentMap.offset.x]], self.screenPos.y --[[+ currentMap.offset.y]])
	
	if self.targetColor then
		love.graphics.setColor(255,255,255,self.targetImageOpacity)
		love.graphics.draw(images.blocks[self.targetColor], s.quadSet[s.anikey.frame], self.screenPos.x, self.screenPos.y)
	end
end

function Block:updateScreenPos()
	self.screenPos.x = (self.currentPos.x - 1) * tileSize
	self.screenPos.y = (self.currentPos.y - 1) * tileSize
end

function Block:setColorSpecificStuff()
	-- print("setting stuff based on"..self.color)
	
	self.sprite = {
		image = images.blocks[self.color],
		anikey = anikeys.map,
		quadSet = quadSets.block,
	}
	
	self.interactionBehavior = behaviorsRaw.blocks[self.color]
end

function Block:go()
	if self.targetPos and (self.targetPos.x ~= self.currentPos.x or self.targetPos.y ~= self.currentPos.y) then
		local targetBlock = getBlock(self.targetPos)
		
		if targetBlock and self.color ~= targetBlock.color then
			-- hacky since it affects two blocks, not just self
			self:setupColorCombination(targetBlock)
		end
		
		self.distanceFromTarget = tileSize
	
		blocksShifting = blocksShifting + 1
		-- self.translatorFunction = walk
		-- self.finishFunction = blockStop
		
		-- if getBlock()
		-- self:setTargetColor(getBlock(self.targetPos))
	end
end

function Block:shift(dt)
		-- print(" HELLO "..colorControlled)
		-- tablePrint(self)
	if self.targetPos and self.color == controllableColors[colorControlled] then
		local xDelta = (self.targetPos.x - self.currentPos.x) * self.speed * dt
		local yDelta = (self.targetPos.y - self.currentPos.y) * self.speed * dt

		self.distanceFromTarget = self.distanceFromTarget - (math.abs(xDelta) + math.abs(yDelta))
		
		self.screenPos.x = self.screenPos.x + xDelta
		self.screenPos.y = self.screenPos.y + yDelta
		
		-- hackoDistance = self.distanceFromTarget
		
		if self.distanceFromTarget <= 0 then
			blocksArrived = true
		end
	end
end

function Block:stop()
	self.distanceFromTarget = 0
	self.currentPos = self.targetPos
	self.targetPos = nil
	self:updateScreenPos()
	
	blocksShifting = blocksShifting - 1
	
	if blocksShifting < 0 then
	print("foo"..nil)
	end
	
	if self.targetColor then
		self.color = self.targetColor
		self.targetColor = nil
		self:setColorSpecificStuff()
	end
	
	print("stop at", self.currentPos.x, self.currentPos.y)
end

function Block:eliminate()
	-- self.distanceFromTarget = 0
	-- self.currentPos = self.targetPos
	-- tablePrint(self)
	
	self.currentPos.y = -100
	self:updateScreenPos()
	self.color = "gone"
		--
	-- blocksShifting = blocksShifting - 1
	--
	-- if self.targetColor then
	-- 	self.color = self.targetColor
	-- 	self:setColorSpecificStuff()
	-- end
	--
	-- print("stop at", self.currentPos.x, self.currentPos.y)
end

function Block:setupColorCombination(addend)
	if addend then
	-- 	local c1 = self.color
	-- 	local c2 = addend.color
	--
	-- 	if c1 == b and c2 == g or c1 == g and c2 == b then
	-- 		self.targetColor = "cyan"
	-- 		addend.targetColor = "cyan"
	-- 		-- addend.eliminate = true
	-- 		-- return "cyan"
	-- 	elseif c1 == c or c2 == c then
	-- 		--
	-- 	end
	-- else
	-- 	self.targetColor = nil
	
		local newColor = colorsCombine(self.color, addend.color)
		
		if newColor == "clear" then
			--soooOOOoo hacky
			self.targetColor = W
			addend.targetColor = K
			self.clearMe = true
			addend.clearMe = true
		else
			self.targetColor = newColor
			addend.targetColor = newColor
		end
	end
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

function blocksTakeInput()
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
			if blocks[i].color == controllableColors[colorControlled] then
				-- print("taking input"..os.time())
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
					if tileType(blocks[i].targetPos) == "collide" or --wall or local actor whatever
						getGlobalActorByPos(blocks[i].targetPos) or	--such as hero
						getBlock(blocks[i].targetPos) and not colorsCombine(blocks[i].color, getBlock(blocks[i].targetPos).color) --block there that does NOT combine
					then
						blocks[i].targetPos = nil
						going = false
					end
				end
			end
			-- blocks.targetDir = nil --? or give each block a target pos? would be slightly easier to cause reactions that way...
			if not going then
				for i=1,#blocks do
					blocks[i].targetPos = nil
					blocks[i].targetColor = nil
				end
			end
		end
	else
		direction = nil
		-- blocks[i].targetPos = nil
		going = false
	end
	
	-- if going then
	-- 	for i = 1, #blocks do
	-- 		blocks[i]:go()
	-- 	end
	-- end
	
	return going
end

function blocksGo()
	for i = 1, #blocks do
		blocks[i]:go()
	end
end

function shiftBlocks(dt)
	-- ping("shifting blokcs")
	-- local hackoDistance = 0
	
	for i=1,#blocks do
		blocks[i]:shift(dt)
	end

	if blocksArrived then
	-- if self.distanceFromTarget <= 0 then
		for i=1,#blocks do
			-- if blocks[i].targetColor ~= "clear" then
-- 				-- blocks[i]:stop()
-- 				blocks[i]:eliminate()
-- 				blocksShifting = blocksShifting - 1
			if blocks[i].targetPos then
				blocks[i]:stop()
				
				if blocks[i].clearMe then
					blocks[i]:eliminate()
				end
				
			elseif blocks[i].targetColor then
				blocks[i]:eliminate()
			end
		end
		-- self:stop()
		
		blocksArrived = false
	end
	
	-- return hackoDistance
end
			
function shiftBlockColors(dt)
	-- local opactiy 
	
	for i=1,#blocks do
		if blocks[i].targetColor then
			-- blocks[i].targetImageOpacity = 255 - (opacity * 8)
			blocks[i].shiftTargetColorOpacity(dt)
		end
	end
end

function Block:shiftTargetColorOpacity(dt)
	self.targetImageOpacity = self.targetImageOpacity + math.floor(dt * 8)
end

function colorsCombine(c1, c2)
	if c1 == c2 then
		return c1
	elseif c1 == W and c2 == K or c1 == K and c2 == W then
		return "clear"
	elseif c1 == B and c2 == G or c1 == G and c2 == B then
		return C
	elseif c1 == R and c2 == B or c1 == B and c2 == R then
		return M
	elseif c1 == G and c2 == R or c1 == R and c2 == G then
		return Y
	elseif c1 == W then
		return c2
	elseif c2 == W then
		return c1
	elseif c1 == C and c2 == R or
		c2 == C and c1 == R or
		c1 == Y and c2 == B or
		c2 == Y and c1 == B or
		c1 == M and c2 == G or
		c2 == M and c1 == G or
		c1 == K and c2 == W or
		c2 == K and c1 == W
	then
		return W
	elseif c1 == C and c2 ~= R or
		c2 == C and c1 ~= R or
		c1 == Y and c2 ~= B or
		c2 == Y and c1 ~= B or
		c1 == M and c2 ~= G or
		c2 == M and c1 ~= G or
		c1 == K and c2 ~= W or
		c2 == K and c1 ~= W
	then
		return false
	end
end