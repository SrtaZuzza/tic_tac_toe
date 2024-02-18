extends Control

"""
FALSE 	= 0 | O
TRUE 	= 1 | X
"""

var turn : bool = false : set = change_turn
var player_turn : bool = false : set = set_turn
var can_start : bool = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	change_turn(rng.randf_range(-10.0, 10.0) >= 0)

func set_turn(value):
	player_turn = value
	var text = "você joga" if player_turn == turn else "ia joga"
	can_start = true
	prints(text, player_turn, turn)

func change_turn(value):
	print("valor atual do turno: "+str(turn))
	turn = value
	print("novo valor do turno: "+str(turn))
	
	if !can_start:
		print("nao pode jogar")
		return
	print("pode jogar")
	match turn == player_turn:
		true:
			print("sua vez")
		false:
			print("vez da ia")


