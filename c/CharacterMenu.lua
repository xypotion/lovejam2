CharacterMenu = class(Menu1D)

function CharacterMenu:_init()
	self.super:_init()
	
	self.options = {"Confirm"}
	
	self.cursor = {
		pos = {y=1,x=0},
		screenPosDelta = {x=20,y=20},
	}
	
	self.pos.y = 304
	self.pos.x = 96
	
	self.previewFacing = "s"
	
	self:updateCursorScreenPos()
end

function CharacterMenu:draw()
	love.graphics.setColor(255,255,255,255)
	--hackity hack	
	love.graphics.print("      What do you look like?\n\n      Press TAB to generate.\nTurn with WASD or arrow keys.\n Confirm with SPACE or ENTER.", 
		self.pos.x * zoom, self.pos.y * zoom, 0, zoom, zoom)
		
	love.graphics.draw(images.characters.base, quadSets.hero[hp.gender][self.previewFacing][anikeys.characters.frame], 208, 176, 0, 2, 2) -- base
	love.graphics.draw(images.characters.skin[hp.skin], quadSets.hero[hp.gender][self.previewFacing][anikeys.characters.frame], 208, 176, 0, 2, 2)
	love.graphics.draw(images.characters.hair[hp.hair], quadSets.hero[hp.gender][self.previewFacing][anikeys.characters.frame], 208, 176, 0, 2, 2)
	love.graphics.draw(images.characters.shirts[hp.shirt], quadSets.hero[hp.gender][self.previewFacing][anikeys.characters.frame], 208, 176, 0, 2, 2)
end

function CharacterMenu:keyPressed(key)
	-- self.previewFacing
	if key == " " or key == "return" then
		self:confirm()
		print("confirmed:")
		tablePrint(hp)
	elseif key == "w" or key == "up" then
		self.previewFacing = "n"
	elseif key == "s" or key == "down" then
		self.previewFacing = "s"
	elseif key == "a" or key == "left" then
		self.previewFacing = "w"
	elseif key == "d" or key == "right" then
		self.previewFacing = "e"
	elseif key == "tab" then
		hp = { --"hero parts"
			skin = math.random(1,2),
			hair = math.random(1,5),
			gender = math.random(1,3),
			shirt = 1
		}
		print("generated:")
		tablePrint(hp)
	end
end

function CharacterMenu:drawCursor()
	--do no things.
end

function CharacterMenu:confirm()
	-- if self:choice() == "Continue" then
		-- loadSaveData()
	-- elseif self:choice() == "New Game" then
		newGame()
	-- end
	self:remove()
end

function CharacterMenu:cancel()
	--do nothing!
end