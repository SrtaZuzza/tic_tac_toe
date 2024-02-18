extends HBoxContainer

@onready var label = $"../RichTextLabel"
@onready var cross = $cross
@onready var circle = $circle
@onready var animator = $"../../Animator"

func _ready():
	cross.toggled.connect(_btn_toggled.bind(cross))
	circle.toggled.connect(_btn_toggled.bind(circle))

func _btn_toggled(toggled_on, btn):
	owner.player_turn = true if btn.name == "cross" else false
	label.text = "[center]Você escolheu [img=20x20]%s[/img][/center]" % btn.get_child(0).texture.get_path()
	animator.play("question")

