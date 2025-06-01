extends Node2D

@onready var menu_animation: AnimatedSprite2D = $"../Menu/MenuAnimation"
@onready var painceau6: Node2D = $"../Painceau6"
@onready var painceau6_animation: AnimatedSprite2D = $"../Painceau6/Painceau6Animation"
@onready var start: Sprite2D = $"../Start"
@onready var bourdieu: Node2D = $"../Bourdieu"
@onready var bourdieu_animation: AnimatedSprite2D = $"../Bourdieu/BourdieuAnimation"
@onready var voice: AudioStreamPlayer = $"../Bourdieu/Voice"
@onready var choir_music: AudioStreamPlayer = $"../ChoirMusic"
@onready var zelda_music: AudioStreamPlayer = $"../Zelda"
@onready var rules: Node2D = $"../Rules"
@onready var start_sound: AudioStreamPlayer = $"../StartSound"

var intro_finished = false
var start_played = false

func _ready():
	choir_music.play()
	menu_animation.play("default")
	menu_animation.animation_finished.connect(_on_intro_finished)
	
func _input(event):
	if event is InputEventMouseButton and intro_finished :
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !start_played:
			start_played = true
			start_sound.play()
			var tween = get_tree().create_tween()
			tween.tween_property(start, "modulate:a", 0.0, 0.1)
			menu_animation.play("zoom")
			menu_animation.animation_finished.connect(_on_zoom_finished)
	
func _on_intro_finished():
	intro_finished = true
	var tween = get_tree().create_tween()
	tween.tween_property(start, "modulate:a", 1.0, 0.5)

func _on_zoom_finished():
	bourdieu.process_mode = Node.PROCESS_MODE_INHERIT
	bourdieu.visible = true
	bourdieu_animation.play("default")
	voice.play()
	bourdieu_animation.animation_finished.connect(_on_bourdieu_finished)
	
func _on_bourdieu_finished():
	painceau6.process_mode = Node.PROCESS_MODE_INHERIT
	painceau6.visible = true
	painceau6_animation.play("default")
	zelda_music.play()
	painceau6_animation.animation_finished.connect(_on_painceau6_finished)

func _on_painceau6_finished():
	rules.process_mode = Node.PROCESS_MODE_INHERIT
	rules.visible = true
	var timer = get_tree().create_timer(2.0)
	await timer.timeout

func _on_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
