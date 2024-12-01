extends Area2D

const FactoryType = preload("res://scripts/factory_type.gd")

var LABS = preload("res://scenes/lab.tscn");
var FACTORIES = preload("res://scenes/factory.tscn");
var ShopMenu = null;
var UpgradeMenu = null;
var Metrics = null;

#instantiate all metrics
var research_points: int = 0
var satisfaction: int = 0
var produits_menstruels: int = 0
var blood: int = 0
var perf: int = 0

var selected_building: String = "";

func updatePerf(amount: float) -> void:
	perf += amount;

func getPerf() -> int:
	return perf

func add_research_points(points: int) -> void:
	research_points += points
	#$UI.update_research_points(research_points)
	print(research_points)

func get_research_points() -> int:
	return research_points
	
func remove_research_points(amount) -> void:
	research_points -= amount

func add_produits_menstruels(type, amount):
	match type:
		FactoryType.Type.SERVIETTE:
			produits_menstruels += amount * 1

func get_produits_menstruels() -> int:
	return produits_menstruels

func remove_produits_menstruels(amount) -> void:
	produits_menstruels -= amount 

func add_blood(amount: int) -> void:
	blood += amount

func get_blood() -> int:
	return blood
	
func remove_blood(amount) -> void:
	blood -= amount

func get_cell_coord(coord: Vector2) -> Vector2i:
	var zoom: Vector2 = get_parent().get_node("Camera").zoom
	coord /= zoom
	var tile_size: int = get_parent().get_node("LandscapeTileMap").rendering_quadrant_size
	return (coord / tile_size) - $CityArea.correction

func get_cell_viewport_coord(coord: Vector2i) -> Vector2:
	var float_coord: Vector2 = coord
	var zoom: Vector2 = get_parent().get_node("Camera").zoom
	var tile_size: int = get_parent().get_node("LandscapeTileMap").rendering_quadrant_size
	var viewport_coord: Vector2 = (float_coord + $CityArea.correction) * tile_size
	viewport_coord -= get_viewport_rect().size / zoom / 2
	viewport_coord.x += tile_size / 2
	viewport_coord.y += tile_size / 2
	return viewport_coord

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ShopMenu = get_parent().get_node("ShopMenu")
	ShopMenu.visible = false
	UpgradeMenu = get_parent().get_node("UpgradeDistributionMenu")
	UpgradeMenu.visible = false
	Metrics = get_parent().get_node("Metrics")
	Metrics.update_produits_menstruels(0)
	Metrics.update_research_points(0)

#TODO: récuperer le click et appeler cette fonction
func place_building(click_position: Vector2) -> void:
	if selected_building == "":
		return
	var node = null
	match selected_building:
		"Laboratoire":
			node = LABS.instantiate()
		"Serviette":
			node = FACTORIES.instantiate()
			node.set_up(FactoryType.Type.SERVIETTE)
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
	if not ShopMenu.visible:
		selected_building = ""

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !event is InputEventMouseButton or !event.pressed:
		return
	selected_building = "Serviette"
	var cell: Vector2i = get_cell_coord(event.position)
	place_building(get_cell_viewport_coord(cell))

func _on_upgrade_pressed() -> void:
	UpgradeMenu.visible = !(UpgradeMenu.visible)


func _on_upgrade_distribution_menu_pressed() -> void:
	pass # Replace with function body.
