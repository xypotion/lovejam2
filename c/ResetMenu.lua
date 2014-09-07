ResetMenu = class(Menu1D)

function ResetMenu:_init()
	self.super:_init()
	
	self.options = {"No", "Yes"}
	
	self.cursor = {
		pos = {y=1,x=0},
		screenPosDelta = {x=20,y=20},
	}
	
	self:updateCursorScreenPos()
end

function ResetMenu:keyPressed(key)
	if key == "w" or key == "up" then
		self:up()
	elseif key == "s" or key == "down" then
		self:down()
	elseif key == " " or key == "return" then
		self:confirm()
	elseif key == "x" or key == "r" then
		self:cancel()
	end
end

function ResetMenu:draw()
	-- print("drawing!")	
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("Reset room?\n     No\n     Yes", self.pos.x * zoom, self.pos.y * zoom, 0, zoom, zoom)
end

function ResetMenu:confirm()
	if self:choice() == "Yes" then
		ping("RESET")
		self:remove()
		startWarpTo(currentMap.warpDrop)
	else
		self:cancel()
	end
end