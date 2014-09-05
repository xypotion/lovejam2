-- image.lua

function initImageSystem()
	images = {
		block = love.graphics.newImage("img/block.png"),
		chipset = love.graphics.newImage("img/chipset.png"),
		humans = love.graphics.newImage("img/humans.png"),
	}
	
	anikeys = {
		block = {
			frame = 1,
			count = 2,
			interval = .25,
			time = 0
			},
		human = {
			frame = 1,
			count = 2,
			interval = .3,
			time = 0
			},
	}
	
	makeQuads()
end

function makeQuads()
	quadSets = {}
	
	qs = {1,1,2,1}
	quadSets.block = {quadAt(0,0,qs),quadAt(1,0,qs)}
	
	qs = {1,1,8,1}
	quadSets.humans = {
		s = {quadAt(0,0,qs),quadAt(1,0,qs)},
		n = {quadAt(2,0,qs),quadAt(3,0,qs)},
		w = {quadAt(4,0,qs),quadAt(5,0,qs)},
		e = {quadAt(6,0,qs),quadAt(7,0,qs)},
	}
	
	qs = {1,1,4,4}
	quadSets.map = {
		quadAt(0,0,qs),
		quadAt(0,1,qs),
		quadAt(0,2,qs),
		quadAt(0,3,qs),
	}
end

function tickAniKey(ak, dt)
	if ak.interval then --if it's nil, then it's still!
		ak.time = ak.time + dt
		if ak.time > ak.interval then
			ak.time = 0
			ak.frame = (ak.frame) % ak.count + 1
		end
	end
end

-- makes a quad with provided args. just saves space above ~
function quadAt(x, y, qs)
	return love.graphics.newQuad(x*tileSize, y*tileSize, qs[1]*tileSize, qs[2]*tileSize, qs[3]*tileSize, qs[4]*tileSize)
end