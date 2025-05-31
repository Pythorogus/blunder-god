extends Node2D

@onready var paint_manager: Node2D = $"../PaintManager"

func _on_h_slider_value_changed(value: float) -> void:
	paint_manager.brush_width = value
