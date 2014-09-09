function saveData()
	love.filesystem.remove("gigapixel.save")
	
	love.filesystem.write("gigapixel.save","BODY"..hp.gender..hp.skin..hp.hair.."\n")
	
	for k,v in pairs(progress) do
		if v then
			love.filesystem.append("gigapixel.save", k.."\n")
		end
	end
	
	-- for k,v in pairs(playerSettings) do
	-- 	t = {}
	-- 	 s = "from=world, to=Lua"
	-- 	 for k, v in string.gmatch(s, "(%w+)=(%w+)") do
	-- 	   t[k] = v
	-- 	 end
	-- 	 			love.filesystem.append("gigapixel.save", k.."\n")
	-- 	end
	-- end
	--...wait, this doesn't matter. mute and zoom and text speed, who cares
end

function loadSaveData()
	progress = {}
	hp = {shirt = 1}
	for line in love.filesystem.lines("gigapixel.save") do
		if line:find("BODY") then
			hp.gender = tonumber(line:sub(5,5))
			hp.skin = tonumber(line:sub(6,6))
			hp.hair = tonumber(line:sub(7,7))
			print("loaded body:")
			tablePrint(hp)
		else
			progress[line] = true
		end
	end
	-- progress["items collected:"] = nil
	tablePrint(progress)

	--TODO
	colorControlled = 1
	controllableColors = {R,G,B,C,M,Y,W}
	
	finishLoadingGame()
	
	startScript(behaviorsRaw.resume)
end

function newGame()
	progress = {}

	colorControlled = 1
	controllableColors = {R,G,B,C,M,Y,W}
	
	saveData()
	
	finishLoadingGame()
	
	startScript(behaviorsRaw.start)
end

function finishLoadingGame()
	--great for defaults; can use "or" when loading if they are set?
	playerSettings = {
		bgmOn = true,
		textSpeed = 60,
		anyKeyAdvancesText = true,
	}
	
	windowState = 1
	
	score = 0
	
	playBGM()
	initHero()
	
	--TODO load/create world here?
end