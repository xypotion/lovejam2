function saveData()
	love.filesystem.write("gigapixel.save", "nothing")
	
	for k,v in pairs(progress) do
	-- for k,v in pairs({what=true,the=true,fuck=false,duck=true}) do
		if v then
			love.filesystem.append("gigapixel.save", "\n"..k)
		end
	end
end

function loadSaveData()
	progress = {}
	for line in love.filesystem.lines("gigapixel.save") do		
		progress[line] = true
	end
	progress["items collected:"] = nil
	-- tablePrint(progress)

	--TODO
	colorControlled = 1
	controllableColors = {R,G,B,C,M,Y,W}
	
	finishLoadingGame()
	
	startScript(behaviorsRaw.resume)
end

function newGame()
	progress = {}
	playerSettings = {bgmOn = true}

	colorControlled = 1
	controllableColors = {R,G,B,C,M,Y,W}
	
	saveData()
	
	finishLoadingGame()
	
	startScript(behaviorsRaw.start)
end

function finishLoadingGame()
	--great for defaults; can use "or" when loading if they are set?
	playerSettings = {
		textSpeed = 60,
		anyKeyAdvancesText = true,
	}
	
	windowState = 1
	
	score = 0
	
	playBGM()
	
	--TODO load/create world here?
end