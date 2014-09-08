math.randomseed(os.time())

-- say: start scrolling text, accepts single string or array of strings
-- warp: starts warp to given destination {wx,wy,mx,my}
-- scorePlus_: adds given value to current score

--EXAMPLE
--[[
	name = "foo" --how scripts will reference this actor in most cases. if omitted, most scripts will be unable to see or use this actor
	sc = {category="stillActors", image=1, quad=1} --"sprite construct"; when LOADED, category => anikey, category+image => image, category+quad => quad
		-- note: actors will still have their own image, anikey, and quad pointers; this is so they CAN BE ALTERED for cutscenes, etc withought messing with sc
			--TODO determine if above statement is necessary/true. emotes/complex actors cover... all of that? i think? (if you handle anikeys smartly)
		-- can also just omit if event is invisible! e.g. town exit points
	complex = false-- if false, may animate and "perform" e.g. hopping, but doesn't turn or emote
		-- or true: animates, but has a facing (south by default), and can emote (!!), interrupting normal animation temporarily
	collide = true -- if true, hero cannot pass through; if false, s/he can. also determines how interaction is triggered
	interactionBehavior = {say, "hello world"} -- commands in manual interaction script, listed in pairs
	interactionBehavior = interactionBehaviorsRaw[1] -- can also have shortcuts like so (TODO)
	idleBehavior = {} -- still need TODO this :)
	--that's it!
]] --TODO update this? lol

behaviorsRaw = {
	title = {
		addMenu, TitleMenu
	},
	resume = {
		-- fadeOut, 0.5,
		-- fadeIn, 0.5,
		-- warp, {wid=1,mx=12,my=7,facing="s"}, --the real one
		-- warp,{wid=10,mx=5,my=13,facing="n"},
		-- warp,{wid=12,mx=2,my=5,facing="s"},
		-- warp,{wid=9,mx=9,my=11,facing="n"},
		-- warp,{wid=14,mx=6,my=5,facing="s"},
		-- warp,{wid=15,mx=6,my=5,facing="s"},
		warp,{wid=16,mx=7,my=12,facing="n"},
		say, "I have to find the team's notes and get out of here!\nNow, where was I?",
	},
	start = {
		-- fadeOut, 0.5,
		-- fadeIn, 0.5,
		warp, {wid=1,mx=12,my=7,facing="w"},
		-- skip,3,
		think, {"An experiment has gone awry and your lab is"
			.."\noverrun with digital matter!",
			"You will need to move and fuse gigapixels"
			.."\nto find your research notes and escape the lab"
			.."\nsafely.",
			"Press RETURN to activate gigapixel control."
			.."\nWASD and the arrow keys allow you to move"
			.."\nthem out of your way.", 
			"When manipulating digital matter, all gigapixels"
			.."\nof the same type will move as one. However, not all"
			.."\ntypes can be controlled. Press TAB to cycle through"
			.."\ncontrollable colors.",
			"Press SPACE to open doors and inspect objects."
			.."\nWASD and the arrow keys let you walk around.", 
			"You can also press R to reset any room."
			.."\nGood luck!", 
			},
		say, "I have to collect my notes and get out of here!",
		makeBlock_, "green",
		collect_, "remote"
	},
	blocks = {
		green = {
			say, "A green gigapixel. I think this can be fused with\nblue or red digital matter to make cyan or yellow."
			.."\nIt also fuses with magenta, resulting in white\ndigital matter."
		},
		blue = {
			say, "A blue gigapixel. I think this can be fused with\ngreen or red matter to make cyan or magenta."
			.."\nIt also fuses with yellow, resulting in white\ndigital matter."
		},
		red = {
			say, "A red gigapixel. I think this can be fused with\nblue or green matter to make magenta or yellow."
			.."\nIt also fuses with cyan, resulting in white\ndigital matter."
		},
		cyan = {
			say, "A cyan gigapixel. Hm, I think this can only be fused\nwith red, which makes white digital matter."
		},
		magenta = {
			say, "A magenta gigapixel. Hm, I think this can only be fused\nwith green, which makes white digital matter."
		},
		yellow = {
			say, "A yellow gigapixel. Hm, I think this can only be fused\nwith blue, which makes white digital matter."
		},
		white = {
			say, "Oh, a white gigapixel! This is the only kind of\ndigital matter that can fuse with black. White"
			.."\ncan actually fuse with any color, which is useful,\nbut it's still just as dangerous as any other kind.",
		},
		black = {
			say, "Hm, black digital matter... not only can I not control\nit with my remote, but there's only one kind of"
			.."\ndigital matter that will fuse with it.",
			say, "This anomaly will require more research."
		},
	},
}

eventDataRaw = {
	--1:
	{
		sc = {category="characters", image="elf", quadId=1},
		name = "elf",
		complex = true, --TODO MAYBE slip into sc or sc.quadId instead of making separate? more concise, less redundant/confusing...
		collide = true,
		interactionBehavior = {
			shock_, "elf",
			shock_, "hero",
			scorePlus_, 10,
			wait, 0.5,
			noEmote_, "elf",
			noEmote_, "hero",
			say, "Hello!",
			scorePlus_, 11,
			scorePlus_, 12,
			say, {"Today my favorite number is "..math.random(1,100)..".", "I love it so much!"},
			scorePlus_, 5}
	},
	{
		name = "doorTo3",
		sc = {category="stillActors", image=1, quadId=3},
		collide = true,
		interactionBehavior = {
			choose, {"Leave room?", {"No", 1}, {"Yes",0}},
			warp,{wid=3,mx=5,my=7,facing="n"}
		}
	},
	--3
	{
		name = "doorTo5",
		sc = {category="stillActors", image=1, quadId=4},
		collide = true,
		interactionBehavior = {
			choose, {"Leave room?", {"No", 1}, {"Yes",0}},
			warp,{wid=5,mx=3,my=7,facing="s"}
		}
	},
	--4
	{
		name = "doorTo1a",
		sc = {category="stillActors", image=1, quadId=3},
		collide = true,
		interactionBehavior = {
			choose, {"Leave room?", {"No", 1}, {"Yes",0}},
			warp,{wid=1,mx=11,my=8,facing="n"}
		}
	},
	--5
	{
		name = "victory sign",
		sc = {category="stillActors", image=1, quadId=5},
		appearsIfAllCollected = {"notes 1", "notes 2", "notes 3"},
		appearsUntilAllCollected = {"notes 1","notes 4"},
		collide = true,
		interactionBehavior = {
			say, {"You got them all! Good job!", "Thanks for playtesting. :)\n -- Max"},
			saveData, nil,
			-- warp,{wid=1,mx=11,my=8,facing="n"}
		}
	},
	--6: sign? lol
	{
		name = "obstacle",
		sc = {category="stillActors", image=1, quadId=5},
		collide = true,
	}
}

--stairs
eventDataRaw[221] = {
	name = "stairsTo1",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Head upstairs?", {"No", 1}, {"Yes",0}},
		warp,{wid=1,mx=3,my=7,facing="s"}
	}
}
eventDataRaw[212] = {
	name = "stairsTo2",
	-- appearsIfAllCollected = {"notes 1", "notes 2", "notes 3"}, TODO
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Head downstairs?", {"No", 1}, {"Yes",0}},
		warp,{wid=2,mx=2,my=7,facing="e"}
	}
}

--doors
eventDataRaw[305] = {
	name = "doorTo5",
	sc = {category="stillActors", image=1, quadId=4},
	collide = true,
	appearsUntilAllCollected = {"notes 1","notes 4"},
	interactionBehavior = {
		choose, {"Leave room?", {"No", 3}, {"Yes",0}},
		playSFX, "door",
		warp,{wid=5,mx=3,my=7,facing="s"},
	}
}
eventDataRaw[355] = {
	name = "doorFrom5",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=1,mx=11,my=8,facing="n"}
	}
}
eventDataRaw[306] = {
	name = "doorTo6",
	sc = {category="stillActors", image=1, quadId=4},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=6,mx=5,my=3,facing="s"}
	}
}
eventDataRaw[356] = {
	name = "doorFrom6",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=1,mx=9,my=8,facing="n"}
	}
}
eventDataRaw[307] = {
	name = "doorTo7",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=7,mx=6,my=9,facing="n"}
	}
}
eventDataRaw[357] = {
	name = "doorFrom7",
	sc = {category="stillActors", image=1, quadId=4},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=1,mx=11,my=4,facing="s"}
	}
}
eventDataRaw[308] = {
	name = "doorTo8",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=8,mx=9,my=11,facing="n"}
	}
}
eventDataRaw[358] = {
	name = "doorFrom8",
	sc = {category="stillActors", image=1, quadId=4},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=1,mx=9,my=4,facing="s"}
	}
}
eventDataRaw[309] = {
	name = "doorTo9",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=9,mx=9,my=11,facing="n"}
	}
}
eventDataRaw[310] = {
	name = "doorTo10",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=10,mx=5,my=13,facing="n"},
	}
}
eventDataRaw[311] = {
	name = "doorTo11",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=11,mx=3,my=12,facing="n"},
	}
}
eventDataRaw[312] = {
	name = "doorTo12",
	sc = {category="stillActors", image=1, quadId=3},
	collide = true,
	interactionBehavior = {
		choose, {"Leave room?", {"No", 1}, {"Yes",0}},
		warp,{wid=12,mx=2,my=5,facing="s"},
		playSound, "door"
	}
}

--notes
eventDataRaw[1001] = {
	name = "notes 1",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = false,
	interactionBehavior = {
		collect_, "notes 1",
		say, "Recovered Research Notes 1!",
	}
	} -- notes 1 pickup
eventDataRaw[2001] = {
	name = "notes 1",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = true,
	interactionBehavior = {
		say, "Research Notes 1, got 'em.",
	}
	} -- notes 1 displayed at base
eventDataRaw[1002] = {
	name = "notes 2",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = false,
	interactionBehavior = {
		collect_, "notes 2",
		say, "Recovered Research Notes 2!",
	}
}
eventDataRaw[2002] = {
	name = "notes 2",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = true,
	interactionBehavior = {
		say, "Research Notes 2, got 'em.",
	}
}
eventDataRaw[1003] = {
	name = "notes 3",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = false,
	interactionBehavior = {
		collect_, "notes 3",
		say, "Recovered Research Notes 3!",
	}
}
eventDataRaw[2003] = {
	name = "notes 3",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = true,
	interactionBehavior = {
		say, "Research Notes 3, got 'em.",
	}
}
eventDataRaw[1004] = {
	name = "notes 4",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = false,
	interactionBehavior = {
		collect_, "notes 4",
		say, "Recovered Research Notes 4!",
	}
}
eventDataRaw[2004] = {
	name = "notes 4",
	sc = {category="stillActors", image=1, quadId=1},
	collide = true,
	appearIfCollected = true,
	interactionBehavior = {
		say, "Research Notes 4, got 'em.",
	}
}
	
	-- {
	-- 	sc = {category="stillActors", image=1, quadId=3},
	-- 	interactionBehavior = {
	-- 		choose, {"Jump down the hole?", {"no", 0}, {"yes", 1}, hint="You can come back!"},
	-- 		stop, false,
	-- 		say, "Here we go!",
	-- 		warp, {wx=1,wy=1,mx=8,my=8,facing="s"},
	-- 		say, "Wait, what am i doing here?"}
	-- },
	-- {
	-- 	sc = {category="characters", image="elf", quadId=1},
	-- 	name = "elf",
	-- 	complex = true, --TODO MAYBE slip into sc or sc.quadId instead of making separate? more concise, less redundant/confusing...
	-- 	collide = true,
	-- 	interactionBehavior = {
	-- 		shock_, "elf",
	-- 		shock_, "hero",
	-- 		scorePlus_, 10,
	-- 		wait, 0.5,
	-- 		noEmote_, "elf",
	-- 		noEmote_, "hero",
	-- 		say, "Hello!",
	-- 		scorePlus_, 11,
	-- 		scorePlus_, 12,
	-- 		say, {"Today my favorite number is "..math.random(1,100)..".", "I love it so much!"},
	-- 		scorePlus_, 5}
	-- },
	-- {
	-- 	name = "rock2",
	-- 	sc = {category="stillActors", image=1, quadId=2},
	-- 	collide = true,
	-- 	interactionBehavior = {
	-- 		vanish_, "rock2",
	-- 		say, "It disappeared!!"
	-- 	}
	-- },
	-- --5:
	-- {
	-- 	name = "rock3",
	-- 	sc = {category="stillActors", image=1, quadId=2},
	-- 	collide = true,
	-- 	interactionBehavior = {
	-- 		hop, "rock2",
	-- 		say, "Rock 2 hopped!!",
	-- 	}
	-- },
	-- --6:
	-- {
	-- 	name = "swirl1",
	-- 	sc = {category="swirl", image=1, quadId=1},
	-- 	collide = true,
	-- 	interactionBehavior = {
	-- 		say, "The hell is this?"
	-- 	}
	-- },
	-- {
	-- 	name = "swirl2",
	-- 	sc = {category="swirl", image=1, quadId=1},
	-- 	collide = false,
	-- 	interactionBehavior = {
	-- 		say, "a little scene!",
	-- 		hop_, "swirl1",
	-- 		hop, "hero",
	-- 		hop_, "swirl1",
	-- 		hop, "hero",
	-- 		hop_, "swirl1",
	-- 		hop, "hero",
	-- 		wait, 0.5,
	-- 		hop_, "swirl2",
	-- 		say, "...one more hop!",
	-- 		hop_, "swirl1",
	-- 		hop, "hero",
	-- 		scorePlus_,100,
	-- 	}
	-- },
	-- {
	-- 	name = "marble1",
	-- 	sc = {category="marble", image=1, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble2",
	-- 	sc = {category="marble", image=2, quadId=1},
	-- 	collide = false,
	-- },
	-- --10:
	-- {
	-- 	name = "marble3",
	-- 	sc = {category="marble", image=3, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble4",
	-- 	sc = {category="marble", image=5, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble5",
	-- 	sc = {category="marble", image=6, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble6",
	-- 	sc = {category="marble", image=7, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble6.1",
	-- 	sc = {category="marble", image=8, quadId=1},
	-- 	collide = false,
	-- },
	-- --15:
	-- {
	-- 	name = "marble6.8",
	-- 	sc = {category="marble", image=9, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble7",
	-- 	sc = {category="marble", image=10, quadId=1},
	-- 	collide = false,
	-- },
	-- {
	-- 	name = "marble8",
	-- 	sc = {category="marble", image=11, quadId=1},
	-- 	collide = false,
	-- },
	-- --18:
	-- {
	-- 	name = "sign1",
	-- 	sc = {category="stillActors", image=1, quadId=5},
	-- 	collide = true,
	-- 	interactionBehavior = {
	-- 		choose, {"What'll it be? Foo or bar?", {"foo", 0}, {"bar", 2}, {"baz", 4}},
	-- 		say, "You chose foo.",
	-- 		stop, false,
	-- 		say, {"You chose bar.", "Goodbye!"},
	-- 		stop, false,
	-- 		hop_, "sign1",
	-- 		wait, 0.25,
	-- 		say, "I didn't say you could have baz!"
	-- 	}
	-- },
	-- {
	-- 	name = "elf2",
	-- 	sc = {category="characters", image="elf", quadId=1},
	-- 	collide = true,
	-- 	complex = true,
	-- 	interactionBehavior = {
	-- 		--this was just to see if negative skips work. don't actually script events this like this unless there's no better way....
	-- 		skip,3,
	-- 		wait,.25,
	-- 		say,"But thou must!",
	-- 		wait,.25,
	-- 		choose, {"Wilt thou save my kingdom? (press H for a hint)", {"no", -4}, {"yes", 0}, hint="You GOTTA save it."},
	-- 		say, "My hero. <3"
	-- 	}
	-- },
	-- {
	-- 	name = "event1",
	-- 	sc = {category="event", image=1, quadId=1},
	-- 	interactionBehavior = {
	-- 		choose, {"start battle?", {"no", 0}, {"yes?", 0}},
	-- 		-- battle, 0
	-- 		say, "lol, sorry! not implemented yet."
	-- 	}
	-- },
	-- --21:
	-- {
	-- 	name = "marble",
	-- 	sc = {category="marble", image=6, quadId=1},
	-- 	collide = false,
	-- 	interactionBehavior = {
	-- 		Menu.scadd, MapMenu
	-- 	}
	-- },
-- }