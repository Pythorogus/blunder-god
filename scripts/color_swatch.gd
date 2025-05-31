extends Button
class_name ColorSwatch

@onready var color_rect: ColorRect = $ColorRect
@onready var label_node: Label = $Label

var pt_color: Color = Color.WHITE
var pt_name: String = ""

func _ready():
	for child in get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE

func set_pt_color(value):
	pt_color = value
	color_rect.color = value
	
func set_pt_name(value):
	pt_name = value
	label_node.text = value
