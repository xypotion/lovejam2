function loadAudio()
	sources = {}
	sources.bgm = love.audio.newSource("sound/Circuit_Monster_-_Jinko_Eisei.mp3", static)
	sources.bgm:setVolume(0.2)
	sources.bgm:setLooping(true)

	sources.item = love.audio.newSource("sound/pickup.wav", static)
	
	sources.phase = love.audio.newSource("sound/phase.wav", static)
	sources.phase:setVolume(0.2)
	
	sources.zoop = love.audio.newSource("sound/zoopzoop.wav", static)
	sources.zoop:setVolume(0.2)
	
	sources.lowblip = love.audio.newSource("sound/low blip.wav", static)
	sources.lowblip:setVolume(0.2)
	
	sources.highblip = love.audio.newSource("sound/high blip.wav", static)
	sources.highblip:setVolume(0.2)
	
	sources.stairs = love.audio.newSource("sound/stairs down.wav", static)
	
	sources.door = love.audio.newSource("sound/door.wav", static)
	sources.door:setVolume(0.2)
	
	-- sources.doorDone = love.audio.newSource("sound/doorDone.wav", static)
	-- sources.doorDone:setVolume(0.2)
	
	sources.collide = love.audio.newSource("sound/hit.wav", static)
	collideSoundTimer = 0
	
	-- --tablePrint(sources)
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

function playSFX(name)
	if name and sources[name] then
		love.audio.play(sources[name])
	end
end