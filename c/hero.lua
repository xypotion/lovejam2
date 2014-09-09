--[[
- mostly hero input and navigation
]]

--called from love.load() AND from updateZoomRelativeStuff(), that's why this is a little more complex than you'd expect
function initHero()
	globalActors.hero = globalActors.hero or {} 
	
	globalActors.hero = {
		complex = true,
 		image = images.characters.base, --TODO way down the road, will need to respect choice of leaders
		quads = quadSets.hero[hp.gender],
		anikey = anikeys.characters,
		speed = 150 * zoom,
		
		--the ones we want to keep if simply changing zoom (otherwise set to default)
		currentPos = globalActors.hero.currentPos or heroGridPos,
		facing = globalActors.hero.facing or "s"
	}

	setActorXY(globalActors.hero)
end

-- TODO will eventually have to abstract parts of this when you add wandering townsfolk (i guess). maybe start by separating the first block?
-- TODO changing flow to not use the global var targetTileType would be nice, too
function setHeroGridTargetAndTileTypeIfDirectionKeyPressed()
	if love.keyboard.isDown('d', "right") and not love.keyboard.isDown('a','w','s','left','up','down') then
		globalActors.hero.facing = "e"
	elseif love.keyboard.isDown('a', "left") and not love.keyboard.isDown('d','w','s','right','up','down') then
		globalActors.hero.facing = "w"
	elseif love.keyboard.isDown('w', "up") and not love.keyboard.isDown('a','d','s','left','right','down') then
		globalActors.hero.facing = "n"
	elseif love.keyboard.isDown('s', "down") and not love.keyboard.isDown('a','w','d','left','up','right') then
		globalActors.hero.facing = "s"
	end
	
	if not love.keyboard.isDown('d','a','w','s','right','left','up','down') then
		globalActors.hero.targetPos = nil
	else
		globalActors.hero.targetPos = getGridPosInFrontOfActor(globalActors.hero)
	end
	
	-- get & set destination tile type
	if globalActors.hero.targetPos and globalActors.hero.targetPos ~= globalActors.hero.currentPos then
		-- local targetTileType = tileType(globalActors.hero.targetPos)
		if tileType(globalActors.hero.targetPos) == "collide" or
			getBlock(globalActors.hero.targetPos)
		then
			globalActors.hero.targetPos = nil
			thudSFX()
		end
	end
end

function setActorDest()
	-- eh? will need later i guess
end

--essentially a hero-specific action trigger, like say() and hop(), etc in cutscene.lua and scripted in cutscenes
function heroGo()
	-- if targetTileType == "clear" then
	if globalActors.hero.targetPos and globalActors.hero.targetPos ~= globalActors.hero.currentPos then
		globalActors.hero.distanceFromTarget = tileSize
		
		actorsShifting = actorsShifting + 1
		globalActors.hero.translatorFunction = walk
		globalActors.hero.finishFunction = heroArrive
	elseif targetTileType == "collide" then
		--
	end
end

function heroArrive()
	actorArrive(globalActors.hero)
	targetTileType = nil

	arrivalInteraction()
end

function startFacingInteraction()
	local x = getGridPosInFrontOfActor(globalActors.hero)
	local lookinAt = getLocalActorByPos(x)
	local lookinAtBlock = getBlock(x)
	
	if lookinAt and lookinAt.collide then 
		interactWith(lookinAt)
	elseif lookinAtBlock then
		interactWith(lookinAtBlock)
	else
		return false
	end
end