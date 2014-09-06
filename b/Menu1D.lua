Menu1D = class(Menu)

function Menu1D:_init(...)
	self.super:_init(...)
	
	-- tablePrint(self.cursor)
	
	-- self.options = {{1,2},{3,4}} --TODO why?
	self.pos.y = 10--(yLen - 3) * tileSize
	self.pos.x = 10
end

function Menu1D:drawCursor()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(arrowImage, self.cursor.screenPos.x, self.cursor.screenPos.y + (self.cursor.pos.y + 0) * 21 * zoom, 0, zoom/12, zoom/12)
end

function Menu1D:keyPressed(key)
	-- print(key.." pressed on generic menu.")
	if key == "w" or key == "up" then
		self:up()
	elseif key == "s" or key == "down" then
		self:down()
	elseif key == " " or key == "return" then
		self:confirm()
	elseif key == "x" then
		self:cancel()
	end
	
	self:updateCursorScreenPos()
end

function Menu1D:updateCursorScreenPos()
	-- m = menuStack[#menuStack]
	self.cursor.screenPos = self.cursor.screenPos or {} --in case it's unset
	
	self.cursor.screenPos.x = self.pos.x + self.cursor.pos.x * self.cursor.screenPosDelta.x * zoom
	self.cursor.screenPos.y = (self.pos.y + (self.cursor.pos.y - 1) * self.cursor.screenPosDelta.y - 4) * zoom
end

function Menu1D:up()
	self.cursor.pos.y = (self.cursor.pos.y - 2) % #(self.options) + 1
end

function Menu1D:down()
	self.cursor.pos.y = (self.cursor.pos.y) % #(self.options) + 1
end

function Menu1D:choice()
	return self.options[self.cursor.pos.y]
end