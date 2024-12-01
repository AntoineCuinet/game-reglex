extends TextureButton

const MAX_STOCK = 64;
var stock : int;
var game_manager = null;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_parent().get_parent().get_node("GameManager");
	stock = 0;




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (stock > 0):
		stock -= 5 * game_manager.getPerf()
		game_manager.add_blood(5 * game_manager.getPerf())
	elif stock < 0:
		stock = 0

func _on_pressed() -> void:
	var buff: int = get_parent().get_parent().get_node("GameManager").get_produits_menstruels()
	if buff < MAX_STOCK - stock:
		get_parent().get_parent().get_node("GameManager").remove_produits_menstruels(buff)
		stock += buff	
	else	:
		get_parent().get_parent().get_node("GameManager").remove_produits_menstruels(MAX_STOCK)
		stock += MAX_STOCK	
	print(stock)
