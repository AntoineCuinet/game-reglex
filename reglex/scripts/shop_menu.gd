extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed(extra_arg_0: String) -> void:
	var game_manager = get_parent().get_node("GameManager")
	print(extra_arg_0)
	match extra_arg_0:
		"Laboratoire":
			# if on a la thune :  
			game_manager.set_selected_building(extra_arg_0)
	pass # Replace with function body.
