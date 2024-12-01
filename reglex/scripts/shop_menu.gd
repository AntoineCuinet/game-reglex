extends Control

func _on_menu_button_pressed(extra_arg_0: String) -> void:
	var game_manager = get_parent().get_node("GameManager")
	game_manager.set_selected_building(extra_arg_0)
	visible = false
