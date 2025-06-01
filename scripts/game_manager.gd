extends Node2D

@onready var paint_manager: Node2D = $"../PaintManager"
@onready var ui_manager: Node2D = $"../UIManager"
@onready var personality_manager: Node2D = $"../PersonalityManager"
@onready var personality_trait_manager: Node2D = $"../PersonalityTraitManager"
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

var mission_checks : Array[bool] = []

func _ready():
	get_mission()
	audio_stream_player.play()

func next_mission():
	mission_checks.append(true)
	ui_manager.hide_next_mission_button()
	paint_manager.reset()
	if mission_checks.size() >= personality_manager.personalities.size():
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	else :
		get_mission()
	
func get_mission():
	var ps = personality_manager.personalities
	ui_manager.print_mission(ps[mission_checks.size()])
	ui_manager.reset_results()

func get_results():
	var ps = personality_manager.personalities
	var results = paint_manager.get_results()
	var personality = personality_manager.get_personality(results)
	ui_manager.print_results(results,personality)
	if personality and personality.name == ps[mission_checks.size()].name:
		ui_manager.show_next_mission_button()

func set_custom_brush_cursor(value: float):
	paint_manager.brush_width = value
	paint_manager.set_custom_brush_cursor(value)

func set_brush_color(color: Color):
	paint_manager.brush_color = color

func reset_paint():
	paint_manager.reset()
	
