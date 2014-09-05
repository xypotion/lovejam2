Map = class()

function Map:_init()
	--chipset/quads, tiles, type (puzzle or not), blocks
	self.chipset = images.chipset
	self.tiles = {
		{2,3,2,2},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
	}
	self.offsetRaw = {x=16,y=32}
	
	self:makeSpriteBatch()
	self:setOffset()
end

function Map:draw()
	love.graphics.draw(self.spriteBatch, self.offset.x, self.offset.y)
end

---------------------------------------------------------------------------------------------------------------------

function Map:makeSpriteBatch()
	self.spriteBatch = love.graphics.newSpriteBatch(self.chipset, xLen * yLen)
  
	self.spriteBatch:bind()
  self.spriteBatch:clear()
	for y=1,#(self.tiles) do
		for x=1,#(self.tiles[y]) do
      self.spriteBatch:add(quadSets.map[self.tiles[y][x]], (x-1)*tileSize, (y-1)*tileSize)
		end
	end
	self.spriteBatch:unbind()
end

function Map:setOffset()
	self.offset = {x=self.offsetRaw.x * zoom, y=self.offsetRaw.y * zoom}
end

---------------------------------------------------------------------------------------------------------------------

function mapTileCollides(pos)
	if not currentMap or not currentMap.tiles or not currentMap.tiles[pos.y] or not currentMap.tiles[pos.y][pos.x] then
		-- print "collide because no tile"
		return true
	else
		return collisionMatrix[currentMap.tiles[pos.y][pos.x]]
	end
end

collisionMatrix = {false,true,true,true}