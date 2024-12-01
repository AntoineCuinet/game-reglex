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
var stocks_menstruel = {
	FactoryType.Type.SERVIETTE: 0,
}
var somme_PM = 0

var selected_building: String = "";

func add_research_points(points: int) -> void:
	research_points += points
	Metrics.update_research_points(research_points)
	print(research_points)

func add_produits_menstruels(type, amount):
	stocks_menstruel[type] += amount
	match type:
		FactoryType.Type.SERVIETTE:
			somme_PM += amount
	Metrics.update_produits_menstruels(somme_PM)

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
	get_parent().add_child(node)
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
	var cell: Vector2i = get_cell_coord(event.position)
	place_building(get_cell_viewport_coord(cell))

func _on_upgrade_pressed() -> void:
	UpgradeMenu.visible = !(UpgradeMenu.visible)


func _on_upgrade_distribution_menu_pressed() -> void:
	pass # Replace with function body.
