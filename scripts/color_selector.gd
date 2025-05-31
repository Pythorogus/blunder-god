extends GridContainer

const COLOR_SWATCH = preload("res://scenes/color_swatch.tscn")

@onready var personality_trait_manager: Node2D = $"../../PersonalityTraitManager"

var color:Color = Color.WHITE

func _ready():
	for pt in personality_trait_manager.personality_traits:
		var color_swatch: ColorSwatch = COLOR_SWATCH.instantiate()
		color_swatch.set_pt_color(pt.color)
		color_swatch.set_pt_name(pt.name)
		add_child(color_swatch)
		color_swatch.set_owner(get_tree().edited_scene_root)
		#color_swatch.connect("pressed", self, "_on_ColorSwatch_pressed", [color])
		
func _on_ColorSwatch_pressed(color_string: String):
	color = Color(color_string)
