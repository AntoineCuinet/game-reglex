extends Control

var prices = {
	"Serviette": 175,
	"Laboratoire": 1200,
	"Distribution": 5000
}

func _on_menu_button_pressed(extra_arg_0: String) -> void:
	var game_manager = get_parent().get_node("GameManager")
	if game_manager.get_blood() >= prices[extra_arg_0]:
		game_manager.set_selected_building(extra_arg_0)
		game_manager.remove_blood(prices[extra_arg_0])
		visible = false
