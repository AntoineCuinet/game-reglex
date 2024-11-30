extends Node

var LABS = preload("res://scenes/lab.tscn");
var ShopMenu = null;

#instantiate all metrics
var research_points: int = 0
var satisfaction: int = 0

var selected_building: String = "";

func add_research_points(points: int) -> void:
	research_points += points
	#$UI.update_research_points(research_points)
	print(research_points)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ShopMenu = get_parent().get_node("ShopMenu/PopupMenu")
	ShopMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

#TODO: récuperer le click et appeler cette fonction
func place_building(click_position: Vector2) -> void:
	if selected_building == "":
		return
	var node = null
	match selected_building:
		"Laboratoire":
			node = LABS.instantiate()
		_:
			return
	add_child(node)
	# TODO: vérifier que la position est valide
	node.position = click_position
	selected_building = ""

func set_selected_building(building: String):
	selected_building = building


func _on_shop_button_pressed() -> void:
	ShopMenu.visible = !ShopMenu.visible
	
	
