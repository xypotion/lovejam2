Human = class()

function Human:_init(id,pos)
	self.currentPos = self.currentPos or pos or {x=1,y=1}
	
	-- if id then --TODO differentiate
		self.sprite = {
			image = images.humans,
			anikey = anikeys.human,
			quadSet = quadSets.humans,
		}
		self.facing = self.facing or "s"
	-- end
	
	self.targetPos = {x=self.currentPos.x,y=self.currentPos.y}
	self.screenPos = {}
	self:updateScreenPos()
	
	self.distanceFromTarget = 0
	
	self.speed = 200 * zoom
end

function Human:draw()
	local s = self.sprite
	love.graphics.draw(s.image, s.quadSet[self.facing][s.anikey.frame], self.screenPos.x + currentMap.offset.x, self.screenPos.y + currentMap.offset.y)
end

function Human:updateScreenPos(dt)
	self.screenPos.x = (self.currentPos.x - 1) * tileSize
	self.screenPos.y = (self.currentPos.y - 1) * tileSize
end

---------------------------------------------------------------------------------------------------------------------


function Human:shift(dt)
	-- ping("shift")
	local xDelta = (self.targetPos.x - self.currentPos.x) * self.speed * dt
	local yDelta = (self.targetPos.y - self.currentPos.y) * self.speed * dt

	self.distanceFromTarget = self.distanceFromTarget - math.abs(xDelta + yDelta)

	self.screenPos.x = self.screenPos.x + xDelta
	self.screenPos.y = self.screenPos.y + yDelta
	
	if self.distanceFromTarget <= 0 then
		self:arrive()
	end
end

function Human:takeInput(dt, which)
	-- local h = which or currentHuman
	
	if love.keyboard.isDown('d', "right") and not love.keyboard.isDown('a','w','s','left','up','down') then
		self.facing = "e"
	elseif love.keyboard.isDown('a', "left") and not love.keyboard.isDown('d','w','s','right','up','down') then
		self.facing = "w"
	elseif love.keyboard.isDown('w', "up") and not love.keyboard.isDown('a','d','s','left','right','down') then
		self.facing = "n"
	elseif love.keyboard.isDown('s', "down") and not love.keyboard.isDown('a','w','d','left','up','right') then
		self.facing = "s"
	end
	
	if not love.keyboard.isDown('d','a','w','s','right','left','up','down') then
		self.targetPos = nil
	else
		self.targetPos = self:lookinAt()
	end
	
	--TODO make it better!
	if self.targetPos and self.targetPos ~= self.currentPos then
		if mapTileCollides(self.targetPos) or getBlock(self.targetPos) then
			self.targetPos = nil
		end
	end
end

function Human:go(dt)
	if self.targetPos and self.targetPos ~= self.currentPos and not mapTileCollides(self:lookinAt()) then
		self.distanceFromTarget = tileSize
	
		humansShifting = humansShifting + 1
		self.translatorFunction = walk --? TODO
		self.finishFunction = humanArrive --?
	end
end

function Human:arrive()
	self.currentPos = self.targetPos
	self:updateScreenPos()
	
	humansShifting = humansShifting - 1 --you know what TODO
	self.distanceFromTarget = 0
	self.targetPos = nil
end

function Human:lookinAt()
	local pos = {}
	
	if self.facing == "s" then
		pos = {x = self.currentPos.x, y = self.currentPos.y + 1}
	elseif self.facing == "n" then
		pos = {x = self.currentPos.x, y = self.currentPos.y - 1}
	elseif self.facing == "e" then
		pos = {x = self.currentPos.x + 1, y = self.currentPos.y}
	elseif self.facing == "w" then
		pos = {x = self.currentPos.x - 1, y = self.currentPos.y}
	else
		print "ERROR: human's facing not n/e/w/s. what's the bizness?"
	end
	
	-- tablePrint(pos)
	
	return pos
end

---------------------------------------------------------------------------------------------------------------------
-- static functions

function drawHumans()
	for i = 1, #humans do
		humans[i]:draw()
	end
end

-- function startFacingInteraction()
-- 	lookinAt = getLocalActorByPos(getGridPosInFrontOfActor(globalActors.hero))
--
-- 	if lookinAt and lookinAt.collide then
-- 		interactWith(lookinAt)
-- 	else
-- 		return false
-- 	end
-- end