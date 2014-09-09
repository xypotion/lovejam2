-- initializes and manages pause menu/overlay
-- may eventually become the whole status menu controller, but we'll cross that bridge when we come to it

function initPauseMenuSystem()
	paused = false
end

function updatePauseScreen(dt)
	tickAniKey(anikeys.minimap, dt)
end

function drawPauseOverlay()
	--dark overlay
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
	
	--TODO progress

	love.graphics.setColor(255,255,255,255)
	love.graphics.print("PAUSED", screenWidth/3, screenHeight/6, 0, zoom*2, zoom*2)

	love.graphics.print("Controls:", screenWidth/6, screenHeight/3, 0, zoom, zoom)
	love.graphics.print("\nWASD/Arrow Keys: walk, move pixels\nSpace: interact\nReturn: activate pixel control"
		.."\n[Shift]-Tab: cycle through colors\nR: reset room\nM: mute background music\nZ: toggle zoom\nEsc: exit game",
		screenWidth/5, screenHeight/3, 0, zoom, zoom)
		
		--TODO shirt controls
end

function togglePause()
	if paused then
		paused = false
		resumeBGM()
	else
		paused = true
		pauseBGM()
	end
end