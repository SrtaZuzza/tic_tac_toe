extends GridContainer

var item = preload("res://scenes/grid_item.tscn")

func _ready():
	add_item()

func add_item():
	for i in range(9):
		var instance = item.instantiate()
		instance.name = str(i)
		add_child(instance)





