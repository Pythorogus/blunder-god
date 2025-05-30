extends Node2D

@onready var man: Sprite2D = $Man
@onready var sprite: Sprite2D = $Sprite2D

var image: Image
var texture: ImageTexture
var pressed: bool = false

func _ready():
	#image = Image.create(256, 256, false, Image.FORMAT_RGBA8)
	image = Image.new()
	image.load("res://assets/textures/man.png")
	#image.fill(Color(1, 1, 1, 1)) # Blanc opaque
	
	texture = ImageTexture.create_from_image(image)
	sprite.texture = texture

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		pressed = true
		var local_pos = get_image_pixel_from_mouse(sprite, event.position) #sprite.to_local(event.position)
		print("LOCAL")
		print(local_pos)
		print("EVENT POSITION")
		print(event.position)
		var x = int(local_pos.x)
		var y = int(local_pos.y)
		#print("x :" + str(local_pos.x))
		#print("y :" + str(local_pos.y))

		if x >= 0 and x < image.get_width() and y >= 0 and y < image.get_height() :
			image.set_pixel(x, y, Color(1, 0, 0, 1)) # Rouge
			paint(local_pos,10,Color(1, 0, 0, 1))
						
	elif event is InputEventMouseMotion and pressed:
		paint(get_image_pixel_from_mouse(sprite, event.position),10,Color(1, 0, 0, 1))

func paint(position:Vector2, width:int, color:Color)->void:
	for x2 in range(width):
		for y2 in range(width):
			if image.get_pixel(position.x+x2-(width/2),position.y+y2-(width/2)).a != 0 :
				image.set_pixel(position.x+x2-(width/2), position.y+y2-(width/2), color) # Rouge
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
