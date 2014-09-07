-- loads all progress-related data

-- TODO actually save & load files here! just kinda hard-coded playtesting data for now

function loadSaveData()
	newGame()
end

function newGame()
	worldPos = 4--{x=1,y=1}
	-- worldPos = 1--{x=1,y=1}
	
	heroGridPos = {x=100,y=5}
	-- heroGridPos = {x=10,y=5}
	
	facing = "s" -- for south
	
	--great for defaults; can use "or" when loading if they are set?
	playerSettings = {
		textSpeed = 60,
		anyKeyAdvancesText = true,
	}
	
	progress = {}

	colorControlled = 1
	controllableColors = {R,G,B,C,M,Y,W}
	
	windowState = 1
	
	-- derp derp
	-- storyProgress = 0
	score = 0
	
	rockTriggered = false
	
	--TODO load/create world here?
end