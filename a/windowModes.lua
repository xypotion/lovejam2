function initWindowModes()
	-- zoom = 2
	
	windowModes = {
		{
			z = 1,
			flags = {
				fullscreen = false, 
				fullscreentype = "desktop",
				highdpi = false
			}
		},
		{
			z = 3,
			flags = {
				fullscreen = false, 
				fullscreentype = "desktop",
				highdpi = true
			}
		}	
	}
	
	updateWindowModeSettings()
	
  love.window.setTitle('Löaf 2D')
end

function updateWindowModeSettings()
	windowModeFlags = windowModes[windowMode].flags
	zoom = windowModes[windowMode].z
	tileSize = 32 * zoom
	
	-- xMargin = 0
	-- yMargin = 0
	-- xRightMargin = tileSize * 5
	-- yBottomMargin = 0
	
	screenWidth = xLen * tileSize --+ offset--+ xMargin + xRightMargin
	screenHeight = yLen * tileSize --+ offset--+ yMargin + yBottomMargin
	
	if(windowModeFlags.highdpi) then
	  love.window.setMode(screenWidth/2, screenHeight/2, windowModeFlags)
	else
	  love.window.setMode(screenWidth, screenHeight, windowModeFlags)
	end
end

function updateZoomRelativeStuff()
	--so many quads to resize ~
	-- initImageSystem()
	makeQuads()
	
	--the main visible things gotta change immediately
	-- loadLocalActors()

	--this is safe, don't worry :)
	-- initHero()
	humans[1]:_init()-- = Human(1, currentHuman.currentPos)
	currentHuman = humans[1]
	blocks[1]:_init()
	
	currentMap:makeSpriteBatch()
	currentMap:setOffset()
end