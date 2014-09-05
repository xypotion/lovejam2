Block = class()

function Block:_init(color)
	self.currentPos = {x=2,y=3}
	self.sprite = {
		image = images.blocks[color],
		anikey = anikeys.map,
		quadSet = quadSets.block,
	}
	
	self.screenPos = {}
	self:updateScreenPos()
	
	self.interactionBehavior = behaviorsRaw.blocks[color]
	
	ping(color.." block made")
end

function Block:draw()
	local s = self.sprite
	love.graphics.draw(s.image, s.quadSet[s.anikey.frame], self.screenPos.x --[[+ currentMap.offset.x]], self.screenPos.y --[[+ currentMap.offset.y]])
end

function Block:updateScreenPos()
	self.screenPos.x = (self.currentPos.x - 1) * tileSize
	self.screenPos.y = (self.currentPos.y - 1) * tileSize
end

---------------------------------------------------------------------------------------------------------------------
-- static functions

function drawBlocks()
	for i = 1, #blocks do
		blocks[i]:draw()
	end
end

function getBlock(pos)
	for i = 1, #blocks do
		if blocks[i].currentPos.x == pos.x and blocks[i].currentPos.y == pos.y then
			return blocks[i]
		end
	end
	
	return nil
end