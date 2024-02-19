extends Control

"""
FALSE 	= 0 | O
TRUE 	= 1 | X

2 - 4 - 6
0 - 4 - 8

0 - 1 - 2
3 - 4 - 5
6 - 7 - 8

0 - 3 - 6
1 - 4 - 7
2 - 5 - 8

"""

var turn : bool = false : set = change_turn
var player : String = ""
var player_turn : bool = false : set = set_turn
var can_play : bool = false
var rng = RandomNumberGenerator.new()

@onready var turn_label = $vbox/RichTextLabel
@onready var grid = $grid
@onready var animator = $Animator

func _ready():
	rng.randomize()
	change_turn(rng.randf_range(-10.0, 10.0) >= 0)

func set_turn(value):
	player_turn = value
	update_label()
	can_play = true
	ia_play()

func change_turn(value):
	turn = value
	
	if !can_play or grid.check_lines():
		return
	
	update_label()
	
	for node in grid.get_children():
		node.set_process_input(turn == player_turn)
	
	ia_play()

func ia_play():
	if can_play and turn != player_turn:
		animator.play("overlay")
		await animator.animation_finished
		grid.get_child(grid.get_available().pick_random()).set_mark()
		animator.play_backwards("overlay")

func update_label():
	turn_label.text = "[center][wave amp=70.0 freq=5.0 connected=1][rainbow freq=0.5 sat=0.5 val=1.0]S U A    V E Z !" if player_turn == turn else "[center]A G U A R D E[pulse freq=3.0 color=#ffffff00 ease=-1.0] . . ."
