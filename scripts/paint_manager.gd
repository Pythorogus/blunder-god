extends Node2D

@onready var canvas: Sprite2D = $"../Canvas"

var image: Image
var texture: ImageTexture
var pressed: bool = false
var last_pos: Vector2i = Vector2i.ZERO
var brush_width:float = 20.0
var brush_color:Color = Color(1, 0, 0, 1)

func _ready():
	var tex2d: Texture2D = load("res://assets/textures/man.png")
	image = tex2d.get_image()
	texture = ImageTexture.create_from_image(image)
	canvas.texture = texture

func _input(event):
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
		
		if last_pos and last_pos != Vector2i.ZERO:
			pass
			#draw_line_between_points(last_pos, current_pos, brush_width, brush_color)
		
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
				if image.get_pixel(px, py).a != 0:
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
