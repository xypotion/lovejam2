-- just what it sounds like. initializes and manages various window modes/sizes
-- TODO implement fullscreen. bleh.

function initWindowStates()
	windowStates = {
		{
			z = 1,
			flags = {
				fullscreen = false, 
				fullscreentype = "desktop",
				highdpi = false
			}
		},
		{
			z = 2,
			flags = {
				fullscreen = false, 
				fullscreentype = "desktop",
				highdpi = false
			}
		}	
	}
	
	updateWindowStateSettings()
	
  love.window.setTitle('Mega-pixel Meltdown')
end

function updateWindowStateSettings()
	windowModeFlags = windowStates[windowState].flags
	zoom = windowStates[windowState].z
	tileSize = 32 * zoom
	
	-- xMargin = 0
	-- yMargin = 0
	-- xRightMargin = tileSize * 5
	-- yBottomMargin = 0
	
	screenWidth = xLen * tileSize --+ xMargin + xRightMargin
	screenHeight = yLen * tileSize --+ yMargin + yBottomMargin
	
	if(windowModeFlags.highdpi) then
	  love.window.setMode(screenWidth/2, screenHeight/2, windowModeFlags)
	else
	  love.window.setMode(screenWidth, screenHeight, windowModeFlags)
	end
end

function updateZoomRelativeStuff()
	--so many quads to resize ~
	makeQuads()
	
	--the main visible things gotta change immediately
	updateMapSpriteBatchFramesCurrent()
	loadLocalActors()

	--this is safe, don't worry :)
	initHero()
	
	for i = 1,#blocks do
		blocks[i]:_init()
	end
	
	scrollSpeed = 500 * zoom -- inelegant TODO maybe put somewhere else? or is it ok?
	
	showGlobals("zoom")
end