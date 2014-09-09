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
			{1,1,1,3,3,3,3,3,3,3,3,1},
			{1,1,3,2,2,2,2,2,2,2,2,3},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,7,7,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2,2},
			{1,1,1,2,2,2,2,2,2,2,2,1},
		},
		startAt = {x=2,y=2,default=1},
		localActorPointers = {
			--papers
			-- {x=8,y=5,id=2001},
			-- {x=8,y=6,id=2002},
			-- {x=9,y=5,id=2003},
			-- {x=9,y=6,id=2004},
			--doors
			-- {x=11,y=3,id=307},
			-- {x=9,y=3,id=308},
			-- {x=11,y=9,id=305},
			-- {x=9,y=9,id=306},
			--other
			{x=7,y=5,id=1},
			--stairs
			-- {x=12,y=5,id=212}
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
	--3: THIRD HUB
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
	--4, blank map for title screen. dumb, i know
	{
		tileData = {{1}}, 
		startAt = {x=1,y=1,default=1},
		localActorPointers = {}
	},
	
--puzzles:
	--5: silly first puzzle (doors 305, 355, notes 1001) **
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
			{G,G,G,K,K,M},
			{B,B,B,K,K,Y},
			{X,X,X,K,K,K},
		},
		blocksAt = {x=5,y=8},
		localActorPointers = {
			{x=3,y=6,id=355}, -- exit
			{x=12,y=7,id=1001},
			{x=2,y=9,id=903}
		}
	},
	--6: narrow puzzle, pretty easy *
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
	--7: white puzzle ** shirt candidate: white, hidden under a white block! maybe upper right corner. IF you put white shirt here, move to level 2 or 3
	{
		tileData = {
			{3,3,3,3,3,3,3},
			{2,2,2,2,2,2,6},
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
	--8: black grate puzzle **** shirt candidate: black? hmm. also where
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
	--9: CMY rows puzzle (needs plant + notes) **** shirt candidate: magenta (but where?)
	{
		tileData = {
			{3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,6,2,2,2},
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
			{x=9,y=12,id=359}, -- exit
			-- {x=4,y=6,id=1004},
			{x=9,y=5,id=6},
		}
	},
	--10: plant rows puzzle (needs plants + notes) ***
	{
		tileData = {
			{1,1,3,3,3,1,1},
			{3,3,2,2,2,3,3},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{6,2,6,2,6,2,6},
			{2,2,2,2,2,2,2},
			{2,6,2,6,2,6,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=3,default=1},
		blocks = {
			{X,B,G,R,B,G},
			{X,B,G,R,B,G},
			{X},
			{X},
			{X,Y,X,M,X,C},
			{Y,C,M,Y,C,M,Y},
			{C,X,Y,X,M,X,C},
		},
		blocksAt = {x=2,y=5},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--11: painting puzzle (needs notes, plant) *** shirt candidate: cyan?
	{
		tileData = {
			{3,3,3,3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,6,2,6,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{2},
			{4}
		}, 
		startAt = {x=3,y=3,default=1},
		blocks = {
			{R,R,R,R,R,R,R,R,R},
			{R,C,C,C,C,Y,C,C,R},
			{R,C,W,W,C,C,W,W,R},
			{R,C,C,C,C,C,C,C,R},
			{R,C,C,X,X,X,C,C,R},
			{R,B,B,G,G,G,B,B,R},
			{R,B,B,B,B,B,B,B,R},
			{R,R,R,R,R,R,R,R,R},
		},
		blocksAt = {x=4,y=4},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--12: white knight vs black rook (needs stuff) *** if no shirts, ***** if shirts. black shirt here?
	{
		tileData = {
			{3,1,1,1,1,1,1,1,1,1,1,1,3},
			{2,3,3,3,3,3,3,3,3,3,3,3,6},
			{2,2,2,2,2,2,2,2,2,6,2,6,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{X,W,W,X,X,X,G,X,K,X,K,X,K},
			{W,W,X,W,W,X,B,X,K,K,K,K,K},
			{W,W,W,W,W,X,R,X,K,K,K,K,K},
			{X,W,W,X,X,X,X,X,X,K,K,K},
			{X,W,W,X,X,X,R,X,X,K,K,K},
			{X,W,W,W,X,X,B,X,X,K,K,K},
			{W,W,W,W,W,X,G,X,K,K,K,K,K},
		},
		blocksAt = {x=2,y=6},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--13: baby puzzle "red shift" (needs stuff) * great place to offer R-for-reset hint!
	{
		tileData = {
			{3,3,3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2,2,2},
			{2,6,2,1,1,1,1,2,2,2},
			{2,2,2,1,1,1,1,2,2,2},
			{1,1,1,1,1,1,1,2,2,2},
			{3,3,3,3,3,3,3,2,2,2},
			{2,2,2,2,2,2,2,2,2,2},
			{1,4}
		}, 
		startAt = {x=4,y=2,default=1},
		blocks = {
			{R,X,X,R},
			{X,X,X,X,X,K},
			{},
			{X,X,X,X,K,X,K},
			{},
			{X,X,X,X,X,K}
		},
		blocksAt = {x=7,y=3},
		localActorPointers = {
		}
	},
	--14: stripes puzzle 1 (needs stuff) ***
	  --shirt candidate, place behind black blocks in a side corridor (red?)
	{
		tileData = {
			{3,3,3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2},
			{2,2,6,2,6,2,6,2,2},
			{2,2,2,2,2,2,2,2,2},
			{2,2,6,2,6,2,6,2,2},
			{2,2,2,2,2,2,2,2,2},
			{2,2,6,2,6,2,6,2,2},
			{2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{X,X,X,K,X,K},
			{X,W,X,K,X,K,X,W},
			{X,X,X,K,X,K},
			{G,G,G,X,X,X,B,B,B},
			{},
			{G,G,G,X,X,X,B,B,B},
			{X,X,X,R,X,R},
			{X,W,X,R,X,R,X,W},
			{X,X,X,R,X,R},
		},
		blocksAt = {x=2,y=5},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--15: green X (needs stuff) ***, shirt candidate (green), maybe a blacked-in side corridor
	{
		tileData = {
			{1,1,1,1,3},
			{1,1,1,3,2,3},
			{1,1,3,2,2,2,3},
			{1,3,6,2,2,2,6,3},
			{3,2,2,6,2,6,2,2,3},
			{2,2,2,2,2,2,2,2,2},
			{1,2,2,6,2,6,2,2},
			{1,1,6,2,2,2,6},
			{1,1,1,2,2,2},
			{1,1,1,1,2,}
		}, 
		startAt = {x=2,y=4,default=1},
		blocks = {
			{X,X,X,X,G},
			{R,R,X,G,G,G,X,B,B},
			{X,X,X,X,G},
		},
		blocksAt = {x=2,y=8},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--16: baby puzzle "+ vs X" (NEEDS STUFF) *
	{
		tileData = {
			{3,3,3,3,3,3,3},
			{2,2,2,2,2,2,2},
			{6,2,6,2,2,2,2},
			{2,6,2,2,2,2,2},
			{6,2,6,2,2,2,2},
			{2,2,2,2,2,2,2},
			{2,2,2,2,2,2,2},
			{1,1,1,4}
		}, 
		startAt = {x=4,y=6,default=1},
		blocks = {
			{X,K,X,X,W,X,W},
			{K,X,K},
			{X,K,X,X,W,X,W},
		},
		blocksAt = {x=4,y=8},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	--17: donut in the gas pump (needs stuff) *****
	{
		tileData = {
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{},
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2},
			{6,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,7,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{4,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=2,default=1},
		blocks = {
			{X,Y,X,M,X,Y,X,M},
			{},
			{},
			{X,G,X,X,K,X,X,B},
			{B,R,X,K,K,K,X,R,G},
			{X,X,K,K,K,K,K},
			{X,K,K,K,X,K,K,K},
			{K,K,K,X,X,X,K,K,K},
			{X,K,K,K,X,K,K,K},
			{X,X,K,K,K,K,K},
			{G,R,X,K,K,K,X,R,B},
			{X,B,X,X,K,X,X,G},
		},
		blocksAt = {x=4,y=3},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},
	{
		tileData = {
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{},
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2},
			{6,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,7,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{4,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=2,default=1},
		blocks = {
			{X,Y,X,M,X,Y,X,M},
			{},
			{},
			{X,G,X,X,K,X,X,B},
			{B,R,X,K,K,K,X,R,G},
			{X,X,K,K,K,K,K},
			{X,K,K,K,X,K,K,K},
			{K,K,K,X,X,X,K,K,K},
			{X,K,K,K,X,K,K,K},
			{X,X,K,K,K,K,K},
			{G,R,X,K,K,K,X,R,B},
			{X,B,X,X,K,X,X,G},
		},
		blocksAt = {x=4,y=3},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},--18
	{
		tileData = {
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{},
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2},
			{6,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,7,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{4,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=2,default=1},
		blocks = {
			{X,Y,X,M,X,Y,X,M},
			{},
			{},
			{X,G,X,X,K,X,X,B},
			{B,R,X,K,K,K,X,R,G},
			{X,X,K,K,K,K,K},
			{X,K,K,K,X,K,K,K},
			{K,K,K,X,X,X,K,K,K},
			{X,K,K,K,X,K,K,K},
			{X,X,K,K,K,K,K},
			{G,R,X,K,K,K,X,R,B},
			{X,B,X,X,K,X,X,G},
		},
		blocksAt = {x=4,y=3},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},--19
	{
		tileData = {
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{},
			{1,1,3,3,3,3,3,3,3,3,3},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{3,3,2,2,2,2,2,2,2,2,2},
			{6,2,2,2,2,2,2,2,2,2,2},
			{2,2,2,2,2,2,7,2,2,2,2},
			{2,2,2,2,2,2,2,2,2,2,2},
			{4,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
			{1,1,2,2,2,2,2,2,2,2,2},
		}, 
		startAt = {x=2,y=2,default=1},
		blocks = {
			{X,Y,X,M,X,Y,X,M},
			{},
			{},
			{X,G,X,X,K,X,X,B},
			{B,R,X,K,K,K,X,R,G},
			{X,X,K,K,K,K,K},
			{X,K,K,K,X,K,K,K},
			{K,K,K,X,X,X,K,K,K},
			{X,K,K,K,X,K,K,K},
			{X,X,K,K,K,K,K},
			{G,R,X,K,K,K,X,R,B},
			{X,B,X,X,K,X,X,G},
		},
		blocksAt = {x=4,y=3},
		localActorPointers = {
			-- {x=9,y=12,id=358}, -- exit
			-- {x=4,y=6,id=1004},
			-- {x=5,y=8,id=6},
		}
	},--20
	{
		tileData = {
			{3,3,3,3},
			{2,2,2,2},
			{2,2,2,2},
			{2,8,2,2},
			{7,7,2,2},
			{1,1,6,6},
		}, 
		startAt = {x=8,y=6,default=1},
		blocks = {},
		blocksAt = {x=4,y=3},
		localActorPointers = {
			{x=10,y=6,id=171}, -- exit
			{x=8,y=7,id=1001}, --TODO no
			{x=9,y=10,id=6},
			{x=9,y=10,id=7},
		}
	},--21: your office
}

-- ideas:
	-- black, white, and blue locked in corners; 3x3 yin-yang of blue and black with notes in middle; 1 green and 1 red on sides
	--13: a big mess that collapses nicely into a spiral for player to walk through :) white can actually become an obstruction? lone W locked up?
	--13.5: spiral of white with B/Y obstructions; white is locked by plants and cannot move, so forming more white with B+Y is dangerous
	--14: spiral of black; given just enough colors to make a white, which is needed since the path can never be cleared?
	--16: lone R/G/B blocks must pass through C/M/Y corridors to form a white; white is locked up, so you have to get RGB through safely by shifting CMY
	--18: white is locked up by a lone block in a closet AND is blocking in notes; must use magenta to clear a path

--[[names of rooms?:
	cafeteria
	kitchen
	bathroom
	lab = where clear shirt is found?
	conference room = chess
	lounge = painting
]]

numberOfMaps = #mapDataRaw