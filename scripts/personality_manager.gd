extends  Node2D

@export var personalities: Array[Personality]

var delta:int = 10

func get_personality(color_results: Array[ColorResult]) -> Personality:
	var personality = null
	for p in personalities:
		var checks = []
		for cr in color_results:
			for i in p.personality_traits.size():
				var pts = p.personality_traits
				var ptsp = p.personality_traits_percent
				if pts[i].name == cr.personality_trait.name:
					if ptsp[i] >= cr.percent - (delta/2) and ptsp[i] <= cr.percent + (delta/2):
						checks.append(true)
		
		if checks.size() == p.personality_traits.size():
			personality = p
	
	return personality
