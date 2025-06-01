extends Node2D

@onready var result_label: RichTextLabel = $"../UIResults/Label"
@onready var mission_label: Label = $"../UIResults/MissionLabel"
@onready var next_mission_button: Button = $"../UIResults/NextMissionButton"

func print_mission(p:Personality):
	mission_label.text = "Create : \n" + p.name + "\n" + p.description

func show_next_mission_button():
	next_mission_button.visible = true
	
func hide_next_mission_button():
	next_mission_button.visible = false

func print_results(results:Array[ColorResult], personality:Personality):
	result_label.text = ""
	for cr in results:
		result_label.text += "[color=" + cr.personality_trait.color.to_html() + "]" + cr.personality_trait.name + "[/color] " + str(cr.percent) + " %\n"
	
	if personality:
			result_label.text += "\n" + personality.name + "\n"
			result_label.text += personality.description
	else:
		result_label.text += "\nYou need the right combination of 3 colors and proportions to get a result"

func reset_results():
	result_label.text = ""
