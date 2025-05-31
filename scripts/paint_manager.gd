extends Node2D

@onready var canvas: Sprite2D = $"../Canvas"
@onready var personality_trait_manager: Node2D = $"../PersonalityTraitManager"

var image: Image
var texture: ImageTexture
var pressed: bool = false
var last_pos: Vector2i = Vector2i.ZERO
var brush_width: float = 50.0
var brush_color: Color = Color(1, 0, 0, 1)
var color_results: Array[ColorResult] = []

func _ready():
	var tex2d: Texture2D = load("res://assets/textures/man.png")
	image = tex2d.get_image()
	texture = ImageTexture.create_from_image(image)
	canvas.texture = texture

func _input(event):
	if is_mouse_over_image(event.position) :
		if event is InputEventMouseButton :
			if event.button_index == MOUSE_BUTTON_LEFT:
				pressed = event.pressed
				var local_pos = get_image_pixel_from_mouse(canvas, event.position) #sprite.to_local(event.position)
				var x = int(local_pos.x)
				var y = int(local_pos.y)

				if x >= 0 and x < image.get_width() and y >= 0 and y < image.get_height() :
					paint(local_pos, brush_width, brush_color)
	
		elif event is InputEventMouseMotion and pressed:
			var current_pos = get_image_pixel_from_mouse(canvas, event.position)
			last_pos = current_pos
			paint(get_image_pixel_from_mouse(canvas, event.position), brush_width, brush_color)
	
		elif event is InputEventMouseButton and !pressed:
			last_pos = Vector2i.ZERO

func paint(pos: Vector2, width: float, color: Color) -> void:
	var radius := width / 2.0
	for x2 in range(width):
		for y2 in range(width):
			var dx := x2 - radius
			var dy := y2 - radius
			if dx * dx + dy * dy <= radius * radius:
				var px := int(pos.x + dx)
				var py := int(pos.y + dy)
				if is_inside_image(Vector2(px, py)) and image.get_pixel(px, py).a != 0:
					image.set_pixel(px, py, color)
	
	texture.update(image)

func get_image_pixel_from_mouse(sprite: Sprite2D, mouse_pos: Vector2) -> Vector2i:
	# Transforme la position de la souris en coordonnées locales du sprite
	var local_pos = sprite.get_global_transform().affine_inverse() * mouse_pos

	# Le sprite est centré par défaut → on remet l’origine en haut-gauche
	var image_size = sprite.texture.get_size()
	local_pos += image_size * 0.5

	# Divise par l’échelle du sprite pour obtenir les coordonnées dans l’image
	var tex_pos = local_pos / sprite.scale

	return Vector2i(tex_pos.floor())

func draw_line_between_points(start: Vector2i, end: Vector2i, width: int, color: Color):
	var distance = start.distance_to(end)
	var steps = int(distance)
	for i in range(steps + 1):
		var t = float(i) / max(steps, 1)
		var pos = Vector2(start).lerp(Vector2(end), t)
		paint(pos, width, color)

func is_mouse_over_image(mouse_pos: Vector2) -> bool:
	var img_pos = get_image_pixel_from_mouse(canvas, mouse_pos)
	return is_inside_image(img_pos)

func is_inside_image(pos: Vector2i) -> bool:
	return (
		pos.x >= 0 and pos.y >= 0 and
		pos.x < image.get_width() and
		pos.y < image.get_height()
	)

func reset() -> void:
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			if image.get_pixel(x, y).a != 0 :
				image.set_pixel(x, y, Color.WHITE)
	
	texture.update(image)

func get_results() :
	color_results = []
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			if image.get_pixel(x, y).a != 0 :
				var c = image.get_pixel(x, y)
				for pt in personality_trait_manager.personality_traits:
					#print(str(c) + " == " + str(pt.color))
					if colors_are_close(c, pt.color) :
						print("color !")
						if color_result_exist(pt.name) :
							var cr = get_color_result(pt.name)
							cr.pixels += 1
						else :
							var cr = ColorResult.new()
							cr.personality_trait = pt
							cr.pixels = 1;
							color_results.append(cr)
	
	return color_results

func color_result_exist(pt_name: String):
	var exist = false
	for cr in color_results:
		if pt_name == cr.personality_trait.name:
			exist = true
	
	return exist

func get_color_result(pt_name: String):
	var color_result_return = false
	for cr in color_results:
		if pt_name == cr.personality_trait.name:
			color_result_return = cr
	
	return color_result_return

func colors_are_close(c1: Color, c2: Color, tolerance := 0.01) -> bool:
	return abs(c1.r - c2.r) < tolerance and \
		   abs(c1.g - c2.g) < tolerance and \
		   abs(c1.b - c2.b) < tolerance and \
		   abs(c1.a - c2.a) < tolerance
