function loadAudio()
	sources = {}
	sources.bgm = love.audio.newSource("sound/Circuit_Monster_-_Jinko_Eisei.mp3", static)
	sources.bgm:setVolume(0.2)
	sources.bgm:setLooping(true)
	
	sources.collide = love.audio.newSource("sound/hit.wav", static)
	collideSoundTimer = 0
	
	tablePrint(sources)
end

function collideSoundTimerDecay(dt)
	if collideSoundTimer > 0 then
		collideSoundTimer = collideSoundTimer - dt
		if collideSoundTimer <= 0 then
			collideSoundTimer = 0
		end
	end
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
	if collideSoundTimer == 0 then
		love.audio.play(sources.collide)
		collideSoundTimer = 0.5
	end
end