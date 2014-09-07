TitleMenu = class(Menu1D)

function TitleMenu:_init()
	self.super:_init()
	
	self.options = {"Continue", "New Game"}
	
	self.cursor = {
		pos = {y=1,x=0},
		screenPosDelta = {x=20,y=20},
	}
	
	self.pos.y = 100--(yLen - 3) * tileSize
	
	self:updateCursorScreenPos()
end

function TitleMenu:draw()
	-- print("drawing!")	
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("\n     Continue from last autosave\n     New game (progress will be lost)", self.pos.x * zoom, self.pos.y * zoom, 0, zoom, zoom)
end

function TitleMenu:confirm()
	if self:choice() == "Continue" then
		loadSaveData()
	elseif self:choice() == "New Game" then
		newGame()
	end
	self:remove()
end

function TitleMenu:cancel()
	--do nothing!
end