extends GridContainer

var arr : Array = []
var piece : String = ""
var item = preload("res://scenes/grid_item.tscn")

@onready var info_label = $"../vbox/RichTextLabel"

func _ready():
	add_item()
	mount_array()

func add_item():
	for i in range(9):
		var instance = item.instantiate()
		instance.name = str(i)
		add_child(instance)

func mount_array():
	arr.append(range(2, 8, 2))
	arr.append(range(0, 9, 4))
	for n in [0, 3, 6]:
		arr.append(range(n, n+3, 1))
	for i in [0, 1, 2]:
		arr.append(range(i, 9, 3))

func check_lines() -> bool:
	var match_found : bool = false
	
	for i in arr:
		match_found = compare(i)
		
		if match_found == true:
			if owner.player == piece:
				info_label.text = "[center][wave amp=70.0 freq=5.0 connected=1][rainbow freq=0.5 sat=0.5 val=1.0]VOCÊ GANHOU!!"
				for node in get_tree().get_nodes_in_group("particles"):
					node.emitting = true
			else:
				info_label.text = "[center]VOCÊ PERDEU!"
			break
	
	return match_found

func compare(array) -> bool:
	var middle : String = get_img_path(array[1])
	if middle.is_empty():
		return false
	piece = "cross" if middle.find("cross") > -1 else "circle"
	return get_img_path(array[0]) == middle and middle == get_img_path(array[2])

func get_img_path(index) -> String:
	var img = get_child(index).get_node("texture").texture
	return img.get_path() if img != null else ""

func get_available() -> Array:
	var list : Array = []
	for i in arr:
		for j in i:
			if get_img_path(j) == "":
				list.append(j)
	return list

func _on_button_pressed():
	get_tree().reload_current_scene()

