-- TODO pretty hacky/devvy for now, but this is the gist of it. 1 = collide, 0 = clear
-- * should have as many members as there are chipsets
-- * each member should have as many members as there are in quadsets.map (1 per tile type)
-- collisionMaps = {}
-- collisionMaps[1] = {0,0,1,0,0,1,1} --normal chipset
-- collisionMaps[2] = {0,1,1,0,0,1,1} --"castle" derpset
collisionMatrix = {false,true} -- false assumed otherwise

G = "green"
B = "blue"
R = "red"
C = "cyan"
M = "magenta"
Y = "yellow"
W = "white"
K = "black"
X = nil

mapDataRaw = {
	{ -- start
		tileData = {
			{3,3,3,3,3},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
		},
		startAt = {x=8,y=3,default=1},
		localActorPointers = {
			{x=8,y=5,id=1},
			{x=13,y=2,id=2}
		},
		warpDrop = {wid=1,mx=10,my=5,facing="s"}
	},
	{
		tileData = {
			{3,3,3,3},
			{2,2,2,2,3},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{4,1,4,1,4}
		},
		startAt = {x=2,y=2,default=1},
		localActorPointers = {
			-- {x=8,y=5,id=1},
			{x=3,y=2,id=2},
			{x=2,y=6,id=3}
		}
	},
	--3
	{
		tileData = {
			{3,3,3,3,3,3},
			{2,2,2,2,2,2,3,3},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
		},
		startAt = {x=2,y=2,default=1},
		blocks = {
			{G,G,X,G,R},
			{X,B,G,B,B},
			{K,K,W}
		},
		blocksAt = {x=2,y=3},
		localActorPointers = {
					{x=8,y=5,id=1},
					-- {x=13,y=2,id=2}
		}
	}
}