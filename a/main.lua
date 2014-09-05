require "helpers"
require "windowModes"
require "saveLoader"
require "image"

require "Map"
require "Block"
require "Human"

function love.load()
	xLen = 15
	yLen = 15
	
	loadSaveData()
	initWindowModes()
	initImageSystem()
	
	blocks = {
		Block(), --lol
	}
	humans = {
		Human(1,{x=2,y=2}),
	}
	
	currentHuman = 1
	humansShifting = 0
	blocksShifting = 0
	
	currentMap = Map()
	
	currentHuman = humans[1]
end

function love.update(dt)
	tickAnimationKeys(dt)
	
	if humansShifting > 0 then --TODO this might be pointless. just change a flag for shifting? simplify, at any rate. a loop to shift all shifting is fine
		currentHuman:shift(dt)
	end
	
	if blocksShifting > 0 then
		shiftBlocks()
	end
	
	if humansShifting == 0 then --constrain to game state TODO
		currentHuman:takeInput(dt)
		currentHuman:go(dt)
	end
end

function love.draw()
	currentMap:draw()
	drawHumans()
	drawBlocks()
end

function love.keypressed(key)
	if key == "q" or key == "escape" then
		love.event.quit()
	end
	
	if key == "z" then
		windowMode = (windowMode) % #windowModes + 1
		updateWindowModeSettings()
		updateZoomRelativeStuff()
	end
	--TODO tab & shift-tab to cycle through block colors
	--TODO something to toggle between human and block control? show state on HUD, too
	--TODO space-interaction, scripts :/
end

---------------------------------------------------------------------------------------------------------------------

function tickAnimationKeys(dt)
	for id,ak in pairs(anikeys) do
		tickAniKey(ak,dt)
	end
end