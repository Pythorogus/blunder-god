extends Node2D

@export var personality_traits: Array[PersonalityTrait]
var personality_traits_copy: Array[PersonalityTrait]

func _ready():
	personality_traits_copy = []
	for pt in personality_traits:
		var copy = pt.duplicate()
		personality_traits_copy.append(copy)

func reset():
	personality_traits = []
	for pt in personality_traits_copy:
		var copy = pt.duplicate()
		personality_traits.append(copy)
