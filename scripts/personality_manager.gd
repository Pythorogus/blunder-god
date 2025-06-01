extends  Node2D

@export var personalities: Array[Personality]

var delta:float = 10.0

func get_personality(color_results: Array[ColorResult]) -> Personality:
	var personality = null
	for p in personalities:
		var traits_checks = []
		var percent_checks = []
		var pts = p.personality_traits
		var ptsp = p.personality_traits_percent
		
		for i in pts.size():
			for cr in color_results:
				if pts[i].name == cr.personality_trait.name:
					traits_checks.append(true)
		
		# Est-ce que les résultats possèdent les bons traits
		if traits_checks.size() == pts.size():
			for i in pts.size():
				for cr in color_results:
					if pts[i].name == cr.personality_trait.name:
						if ptsp[i] >= cr.percent - (delta/2) and ptsp[i] <= cr.percent + (delta/2):
							percent_checks.append(true)
						else:
							percent_checks.append(false)
			
			#for iptest in pts.size():
				#print(pts[iptest].name + " : " + str(percent_checks[iptest]))
			
			# Est-ce que les traits ont le bon %
			if percent_checks.all(equal_true):
				personality = p
				break
			else :
				var max_wrong_i = -1
				var max_wrong_percent = 0
				for ipc in percent_checks.size():
					if !percent_checks[ipc]:
						for cr2 in color_results:
							if pts[ipc].name == cr2.personality_trait.name and cr2.percent > max_wrong_percent:
								print("Check " + pts[ipc].name + " : " + str(percent_checks[ipc]) + " " + str(cr2.percent) + "% => " + str(ptsp[ipc]))
								max_wrong_percent = ptsp[ipc]
								max_wrong_i = ipc
				
				print("Mauvais trait le plus haut : " + pts[max_wrong_i].name)
				for pa in p.personality_antagonists:
					if pa.personality_antagonist_trait.name == pts[max_wrong_i].name:
						personality = pa
						break
	
	return personality

func equal_true(value):
	return value

func get_max_i_of_array(values:Array):
	var max_val = -INF
	var max_index = -1

	for i in values.size():
		if values[i] > max_val:
			max_val = values[i]
			max_index = i
	
	return max_index
