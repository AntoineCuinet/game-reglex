extends Node

const prices = [1000, 2000, 5000, 10000, 15000, 25000, 50000, 75000, 1000000]
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var my_label = $TileMapLayer/Prix
	my_label.text = "Prix : " + str(prices[index]) + " point de recherche"
	print(index);


func _on_upgrade_pressed() -> void:
	if index > 9:
		index = 0
	if get_parent().get_node("GameManager").get_research_points() >= prices[index]:
		get_parent().get_node("GameManager").remove_research_points(prices[index]);
		get_parent().get_node("GameManager").updatePerf(0.5);
		index += 1
	
