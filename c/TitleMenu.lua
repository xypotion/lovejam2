TitleMenu = class(Menu1D)

function TitleMenu:_init()
	self.super:_init()
	
	self.options = {"Continue", "New Game"}
	
	self.cursor = {
		pos = {y=1,x=0},
		screenPosDelta = {x=20,y=20},
	}
	
	self.pos.y = 304
	self.pos.x = 64
	
	self:updateCursorScreenPos()
end

function TitleMenu:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(images.title, quadSets.title[1])
	--hackity hack	
	love.graphics.print("\n     Continue from last autosave\n\n     New game (progress will be lost)", self.pos.x * zoom, self.pos.y * zoom, 0, zoom, zoom)
end

function TitleMenu:confirm()
	if self:choice() == "Continue" then
		loadSaveData()
		self:remove()
	elseif self:choice() == "New Game" then
		self:remove()
		addMenu(CharacterMenu)
	end
end

function TitleMenu:cancel()
	--do nothing!
end