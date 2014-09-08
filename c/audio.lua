function loadAudio()
	sources = {}
	sources.bgm = love.audio.newSource("sound/Circuit_Monster_-_Jinko_Eisei.mp3", static)
	sources.bgm:setVolume(0.2)
	sources.bgm:setLooping(true)
	
	sources.thud = love.audio.newSource("sound/thud.mp3", static)
	
	tablePrint(sources)
end

function playBGM()
	love.audio.play(sources.bgm)
end

function stopBGM()
	love.audio.stop()
end

function pauseBGM()
	love.audio.pause(sources.bgm)
end

function resumeBGM()
	love.audio.resume(sources.bgm)
end

function toggleBGM()
	if playerSettings.bgmOn then
		playerSettings.bgmOn = false
		stopBGM()
	else
		playerSettings.bgmOn = true
		playBGM()
	end
end

function thudSFX()
	love.audio.play(sources.thud)
end