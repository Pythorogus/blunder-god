extends Node2D

@onready var paint_manager: Node2D = $"../PaintManager"
@onready var ui_manager: Node2D = $"../UIManager"

func _on_h_slider_value_changed(value: float) -> void:
	paint_manager.brush_width = value

func _on_color_selected(color: Color) :
	paint_manager.brush_color = color

func _on_reset_button_pressed() -> void:
	paint_manager.reset()

func _on_submit_button_pressed() -> void:
	var results = paint_manager.get_results()
	print(results)
	ui_manager.print_results(results)
