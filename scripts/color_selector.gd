extends GridContainer

var COLOR_SWATCH = load("res://scenes/color_swatch.tscn")

@onready var personality_trait_manager: Node2D = $"../../PersonalityTraitManager"
@onready var signal_manager: Node2D = $"../../SignalManager"

var color:Color = Color.WHITE

func _ready():
	for pt in personality_trait_manager.personality_traits:
		var color_swatch: ColorSwatch = COLOR_SWATCH.instantiate()
		add_child(color_swatch)
		color_swatch.set_pt_color(pt.color)
		color_swatch.set_pt_name(pt.name)
		color_swatch.set_owner(get_tree().edited_scene_root)
		color_swatch.connect("pressed",func():signal_manager._on_color_selected(pt.color))
