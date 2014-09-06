Menu1D = class(Menu)

function Menu1D:_init(...)
	self.super:_init(...)
	
	-- tablePrint(self.cursor)
	
	-- self.options = {{1,2},{3,4}} --TODO why?
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

function Menu1D:up()
	self.cursor.pos.y = (self.cursor.pos.y - 2) % #(self.options) + 1
end

function Menu1D:down()
	self.cursor.pos.y = (self.cursor.pos.y) % #(self.options) + 1
end

function Menu1D:choice()
	return self.options[self.cursor.pos.y]
end