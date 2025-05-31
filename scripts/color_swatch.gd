extends Button
class_name ColorSwatch

@onready var color_rect: ColorRect = $ColorRect
@onready var label_node: Label = $Label

@export var pt_color: Color = Color.WHITE
@export var pt_name: String = "" 

func set_pt_color(value):
	pt_color = value
	if not color_rect:
		return
	color_rect.color = value
	print(value)
	
func set_pt_name(value):
	pt_name = value
	if not label_node:
		return
	label_node.text = value
	print(value)
