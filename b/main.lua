require "helpers"
require "windowStates"
require "pause"
require "map"
require "hero"
require "cutscene"
require "warp"
require "textScroll"
require "actorManager"
require "sidebar"
require "menuStack"

require "Menu"
-- require "Menu2D"
-- require "MapMenu"
require "Block"

require "script/saveLoader"
require "script/mapLoader"
require "script/eventLoader"
require "script/imgKey"

--TODO quite possibly better to use dofile() instead of require for large script files

function love.load()
	loadSaveData() -- just the data values, not applying/drawing anything
	
	--TODO put these somewhere else
	yLen = 15
	xLen = 15
	initWindowStates()
	
	-- initialize and load data
	-- load map art, hero art, event art, GUI assets
	loadImages() --actually does almost nothing now, haha
	
	--initialize other game parts
	initActorManager()
	initMapSystem()
	initHero()
	initTextEngine()
	initWarpSystem()
	initMenuSystem()
	
	math.randomseed(os.time())
	
	initPauseMenuSystem()
	
	keyDelayTimer = 0
	keyRepeatDelay = 2
	notBusy = true
	
	blocks = {}
	blocksShifting = 0
	
	controllingBlocks = false
	
	startScript(behaviorsRaw.start)
end

function love.update(dt)
	
	-- notBusy = not screenShifting and actorsShifting == 0 and not warping and not dewarping and not textScrolling and #menuStack == 0 --TODO
	-- keyDelayTimer = keyDelayTimer + dt --TODO
	
	updateMenuStack(dt)
	
	if paused then
		-- updatePauseScreen(dt)
	else
		tickAnimationKeys(dt)

		--MOVEMENT
		-- move map if needed
		-- if screenShifting then
		-- 	shiftTiles(dt)
		-- end
	
		-- update/"shift" actors if needed
		if actorsShifting > 0 then
			-- don't forget: lots happens here, including heroArrive and arrivalInteraction.
			moveActors(dt)
		end
	
		if blocksShifting > 0 then
			shiftBlocks(dt)
			-- shiftBlockColors(dt)
		end
		
		warpUpdate(dt)
		
		if textScrolling then
			updateScrollingText(dt)
		end
	
		-- if notBusy then --i tried :'( TODO
		if blocksShifting == 0 and actorsShifting == 0 and not paused and not warping and not dewarping and not textScrolling and #menuStack == 0 then
			if runningScript then
				if not runningScriptLine then
					-- print ("STARTING NEXT LINE")
					runningScriptLine = true
					doNextScriptLine()
				else
					-- print "DONE WITH SCRIPT LINE"
					runningScriptLine = false
				end
			else
				if controllingBlocks then
					local going = blocksTakeInput()
					if going then
						-- print("barthello, we're leaving.")
						blocksGo()
					else
						--this is sooo hacky :/
						-- for i = 1,#blocks do
-- 							-- print("block "..i)
-- 							if blocks[i].eliminate then
-- 								blocks[i].currentPos.y = -100
-- 								blocks[i].color = "gone"
-- 							end
-- 						end
					end				
				else
				-- allow player to move hero/play normally
					setHeroGridTargetAndTileTypeIfDirectionKeyPressed()
					heroGo()
				end
			end
		end
	end
end

function love.draw()
	drawMap()
	
	if screenShifting then 
		drawGlobalActors()
	else
		drawAllActors()
	end
	
	drawBlocks()
	
	--black screen for fadeouts, e.g. when warping
	love.graphics.setColor(0, 0, 0, blackOverlayOpacity)
  love.graphics.rectangle('fill', 0, 0, xLen * tileSize, yLen * tileSize)
	
	--sidebar
	-- drawSidebar()
	
	--menus
	if Menu:top() then
		drawMenuStack()
	end
	
	if controllingBlocks then
		love.graphics.setColor(255, 255, 255, 191)
		love.graphics.draw(images.blocks[controllableColors[colorControlled]], quadSets.block[1], screenWidth - tileSize * 2, screenHeight - tileSize * 3)
		love.graphics.draw(images.remote, screenWidth - tileSize * 2.5, screenHeight - tileSize * 4)
		-- ping("remote")
	else
		love.graphics.setColor(255, 255, 255, 63)
		love.graphics.draw(images.remote, screenWidth - tileSize * 2.5, screenHeight - tileSize * 4)
	end 		
	
	--debug junk
	-- if score >= 300 then
	-- 	love.graphics.setColor(255, 0, 255, 255)
	-- else
	-- end
	
  if controllingBlocks then love.graphics.print("controlling "..controllableColors[colorControlled], 10, 26*zoom, 0, zoom, zoom) end
  if controllingBlocks then love.graphics.print("Blocks Shifting: "..blocksShifting, 10, 42*zoom, 0, zoom, zoom)
	else love.graphics.print("Actors Shifting: "..actorsShifting, 10, 42*zoom, 0, zoom, zoom) end
	
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10*zoom, 0, zoom, zoom) --zoom, zoom!
	-- love.graphics.print("x="..worldPos.x.." y="..worldPos.y, tileSize * xLen - 96, 10*zoom, 0, zoom, zoom)
	-- love.graphics.print("x="..globalActors.hero.currentPos.x.." y="..globalActors.hero.currentPos.y, tileSize * xLen - 96, 26*zoom, 0, zoom, zoom)	
	
  love.graphics.setColor(255, 255, 255, 255)
	-- so that it draws above the debug junk :P
	if textScrolling then
		drawScrollingText()
	end

	if paused then
		drawPauseOverlay()
	end
end

function love.keypressed(key)
	if key == "q" or key == "escape" then
		love.quit()
	elseif key == "p" then
		togglePause()
	elseif not paused then
		-- keyDelayTimer = 0 TODO just not quite this simple. think it needs a boolean
		if(#menuStack > 0) then
			takeMenuStackInput(key)
		elseif blocksShifting == 0 and actorsShifting == 0 and not warping and not dewarping and not textScrolling and not runningScript and #menuStack == 0 then
		--if notBusy then --TODO this. maybe notBusy() or not busy()?
			--pause
			-- if key == "m" then
			-- 	-- paused = not paused
			-- 	-- return
			-- 	-- addMenu("fast travel")
			-- 	Menu.add(MapMenu)--():add()
			-- end
	
			--cycle through zoom settings TODO eventually make a player option of this, but this is fine for dev
			if key == "z" then
				windowState = (windowState) % #windowStates + 1
				updateWindowStateSettings()
				updateZoomRelativeStuff()
			end
		
			if key == " " then 
				-- print "ping main"
				startFacingInteraction()
				-- print "ping main; keypressed finished"
			end	
			
			if key == "return" then
				controllingBlocks = not controllingBlocks
			end
			
			if key == "tab" and controllingBlocks then
				if love.keyboard.isDown("lshift", "rshift") then
					colorControlled = (colorControlled - 2) % #controllableColors + 1
				else
					colorControlled = colorControlled % #controllableColors + 1
				end
			end
			
		elseif textScrolling then --if not else'd off the above, bad things happen. i don't love this here, but it works for now
			-- advance to end of line and halt
			keyPressedDuringText(key)
		end
	
		--shh! TODO remove
		if key == "0" and love.keyboard.isDown("3") then
			score = score + 1
			return
		end
	end
end

function love.keyreleased(key)
	-- keyDelayTimer = 0
end

------------------------------------------------------------------------------------------------------

-- TODO auto-save here? meh. we'll see.
function love.quit()
	love.event.quit()
end

-- moved from imgKey.lua. so many things rely on it that i'm not sure where would be better to put it than here!
function tickAnimationKeys(dt)
	for id,ak in pairs(anikeys) do
		tickAniKey(ak,dt)
	end
end