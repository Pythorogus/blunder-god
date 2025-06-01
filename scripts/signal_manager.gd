extends Node2D

@onready var game_manager: Node2D = $"../GameManager"
@onready var paint_manager: Node2D = $"../PaintManager"
@onready var ui_manager: Node2D = $"../UIManager"

func _on_h_slider_value_changed(value: float):
	game_manager.set_custom_brush_cursor(value)

func _on_color_selected(color: Color) :
	game_manager.set_brush_color(color)
	
func _on_reset_button_pressed():
	game_manager.reset_paint()

func _on_submit_button_pressed():
	game_manager.get_results()

func _on_next_mission_button_pressed() -> void:
	game_manager.next_mission()
