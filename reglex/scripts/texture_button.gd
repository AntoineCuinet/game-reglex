extends TextureButton

const MAX_STOCK = 64;
var stock : int;
var game_manager = null;
var timer;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_parent().get_parent().get_node("GameManager");
	stock = 0;
	timer = get_parent().get_node("Timer");
	timer.wait_time = 1
	timer.start()




func _on_pressed() -> void:
	var buff: int = get_parent().get_parent().get_node("GameManager").get_produits_menstruels()
	if buff < MAX_STOCK - stock:
		get_parent().get_parent().get_node("GameManager").remove_produits_menstruels(buff)
		stock += buff	
	else	:
		get_parent().get_parent().get_node("GameManager").remove_produits_menstruels(MAX_STOCK)
		stock += MAX_STOCK	


func _on_timer_timeout() -> void:
	if (stock > 0):
		stock -= 1
		game_manager.add_blood(5 * game_manager.getPerf())
	elif stock < 0:
		stock = 0
