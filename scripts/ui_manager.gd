extends Node2D

@onready var result_label: Label = $"../UIResults/Label"

func print_results(results:Array[ColorResult], personality:Personality):
	result_label.text = ""
	for cr in results:
		result_label.text += cr.personality_trait.name + " " + str(cr.percent) + " %\n"
	
	if personality:
			result_label.text += "\n" + personality.name + "\n"
			result_label.text += personality.description
