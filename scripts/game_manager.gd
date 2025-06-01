extends Node2D

@onready var paint_manager: Node2D = $"../PaintManager"
@onready var ui_manager: Node2D = $"../UIManager"
@onready var personality_manager: Node2D = $"../PersonalityManager"
@onready var personality_trait_manager: Node2D = $"../PersonalityTraitManager"

func get_results():
	ui_manager.print_results(paint_manager.get_results())
	
func set_custom_brush_cursor(value: float):
	paint_manager.brush_width = value
	paint_manager.set_custom_brush_cursor(value)

func set_brush_color(color: Color):
	paint_manager.brush_color = color

func reset_paint():
	paint_manager.reset()
	
