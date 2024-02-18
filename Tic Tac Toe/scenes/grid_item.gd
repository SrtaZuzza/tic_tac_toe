extends TextureRect

var cross : Texture = preload("res://assets/images/cross.png")
var circle : Texture = preload("res://assets/images/circle.png")
var unmarked = true
var mouse_in = false

@onready var image : TextureRect = $texture
@onready var OWNER = get_tree().current_scene

func _ready():
	pass # Replace with function body.

func _input(_event):
	if Input.is_action_just_pressed("click") and mouse_in and unmarked:
		set_mark()
		print("clicou no " + name)

func set_mark():
	match int(OWNER.turn):
		0:
			image.set_texture(circle)
		1:
			image.set_texture(cross)
	
	unmarked = false
	OWNER.turn = !OWNER.turn
	print("turno trocado")

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
