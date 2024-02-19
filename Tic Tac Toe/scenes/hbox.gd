extends HBoxContainer

var tween : Tween
var tween2 : Tween
var tween3 : Tween

@onready var label = $"../RichTextLabel"
@onready var cross = $cross
@onready var circle = $circle
@onready var animator = $"../../../Animator"
@onready var alert = $"../.."
@onready var vbox = $".."

func _ready():
	cross.toggled.connect(_btn_toggled.bind(cross))
	circle.toggled.connect(_btn_toggled.bind(circle))

func _btn_toggled(_toggled_on, btn):
	animate_gui()
	owner.player = btn.name
	owner.player_turn = true if btn.name == "cross" else false
	label.text = "[center]Você escolheu [img=20x20]%s[/img][/center]" % btn.get_child(0).texture.get_path()

func animate_gui() -> void:
	tween = create_tween()
	tween2 = create_tween()
	tween3 = create_tween()
	
	tween.tween_property(alert, "position:y", 0, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	tween2.tween_property(alert, "size:y", 104, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	tween3.tween_property(self, "custom_minimum_size:y", 40, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "visible", false, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
