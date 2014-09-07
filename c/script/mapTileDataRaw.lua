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
	--1: first hub
	{
		tileData = {
			{3,3,3,3,3},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{2,2,2,2,2},
			{1,4,1,4,1}
		},
		startAt = {x=8,y=3,default=1},
		localActorPointers = {
			{x=8,y=5,id=2001},
			{x=8,y=6,id=2002},
			{x=9,y=5,id=2003},
			{x=9,y=6,id=2004},
			{x=11,y=3,id=307},
			{x=9,y=3,id=308},
			{x=11,y=9,id=305},
			{x=9,y=9,id=306},
			{x=12,y=6,id=5},
			{x=12,y=5,id=212}
		},
		warpDrop = {wid=1,mx=10,my=5,facing="s"}
	},
	--2: second hub
	{
		tileData = {
			{1,1,1,3,3,3,3,3,3,3,3,1},
			{1,1,3,2,2,2,2,2,2,2,2,3},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,1,2,2,2,2,2,2,2,2,1},
		},
		startAt = {x=2,y=2,default=1},
		localActorPointers = {
			-- {x=8,y=5,id=1},
			-- {x=3,y=2,id=2},
			{x=2,y=6,id=221},
			{x=6,y=2,id=309}
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
	},
	--4, "blank"
	{
		tileData = {{1}}, 
		startAt = {x=1,y=1,default=1},
		localActorPointers = {}
	},
	--5: first real puzzle room
	{
		tileData = {
			{3,3,3,1,1,1,1,1,1,3,3,3},
			{2,2,2,3,3,3,3,3,3,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2}
		}, 
		startAt = {x=2,y=6,default=1},
		blocks = {
			{R,R,R,K,K,C},
			{C,Y,M,K,K},
			{B,B,B,K,K,M},
			{G,G,G,K,K,K},
		},
		blocksAt = {x=5,y=8},
		localActorPointers = {
			{x=3,y=6,id=355}, -- exit
			{x=12,y=7,id=1001},
		}
	},
	--6: puzzle
	{
		tileData = {
			{3,3,3,3},
			{2,2,2,2},
			{2,2},
			{2},
			{2},
			{2},
			{2},
			{2,1,1,3},
			{2,3,3,2},
			{2,2,2,2}
		}, 
		startAt = {x=2,y=2,default=1},
		blocks = {
			{B},
			{Y},
			{B},
			{Y},
			{R},
			{K}
		},
		blocksAt = {x=2,y=5},
		localActorPointers = {
			{x=5,y=2,id=356}, -- exit
			{x=5,y=10,id=1002},
		}
	},
	--7: puzzle
	{
		tileData = {
			{3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{1,1,4,1,2,2,2},
		}, 
		startAt = {x=4,y=3,default=1},
		blocks = {
			{X,C,W,W,W,W,W},
			{C,W,W,W,W,W,W},
			{W,W,W,W,W,W,W},
			{W,W,W,W,W,W,W},
			{W,W,W,W,W,W,W},
			{W,W},
			{X,X,X,X,X,R}
		},
		blocksAt = {x=4,y=4},
		localActorPointers = {
			{x=6,y=10,id=357}, -- exit
			{x=4,y=4,id=1003},
		}
	},
	--8: puzzle
	{
		tileData = {
			{3,3,3,3,3,3,3,1},
			{2,2,2,2,2,2,2,3},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,4},
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{X,K,K,K,K,K,},
			{K,Y,X,K,X,G,K},
			{K,X,C,K,M,X,K},
			{K,K,K,W,K,K,K},
			{K,X,M,K,C,X,K},
			{K,G,X,K,X,Y,K},
			{X,K,K,K,K,K},
		},
		blocksAt = {x=2,y=5},
		localActorPointers = {
			{x=9,y=12,id=358}, -- exit
			{x=4,y=6,id=1004},
		}
	},
	--9: puzzle
	{
		tileData = {
			{3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,3},
			{2,2,2,2,2,2,2,2},
			{1,1,1,1,1,1,1,4},
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{Y,Y,C,M,C,Y,C},
			{X},
			{C,M,Y,X,M,M,Y},
			{X},
			{M,Y,C,Y,C,C,M}
		},
		blocksAt = {x=2,y=6},
		localActorPointers = {
			{x=9,y=12,id=358}, -- exit
			{x=4,y=6,id=1004},
			{x=5,y=8,id=6},
		}
	},
	--10: puzzle; a cache of white blocks that have to be used to copy RGB blocks in order to clear a large CMY hedge :)
	{
		tileData = {
			{3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2},
			{2,6,2,6,2,6,2,6},
			{2,2,2,2,2,2,2,2},
			{6,2,6,2,6,2,6,2},
			{2,2,2,2,2,2,2,2},
			{2,6,2,6,2,6,2,6},
			{2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{W,W,W,W,W,W,W,W},
			{W,W,W,W,W,W,W,W},
			{X,X,R,X,G,X,B},
			{C,M,Y,C,M,Y,C,M},
			{M,Y,C,M,Y,C,M,Y},
			{Y,C,M,Y,C,M,Y,C},
			{C,M,Y,C,M,Y,C,M},
		},
		blocksAt = {x=2,y=6},
		localActorPointers = {
			{x=9,y=12,id=358}, -- exit
			{x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--11: puzzle; a big mess that collapses nicely into a spiral for player to walk through :) white can actually become an obstruction?
}

numberOfMaps = #mapDataRaw