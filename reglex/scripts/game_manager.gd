extends Node

const FactoryType = preload("res://scripts/factory_type.gd")

var LABS = preload("res://scenes/lab.tscn");
var FACTORIES = preload("res://scenes/factory.tscn");
var ShopMenu = null;
var UpgradeMenu = null;

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
	#$UI.update_research_points(research_points)
	print(research_points)

func add_produits_menstruels(type, amount):
	stocks_menstruel[type] += amount
	#match type:
	#	FactoryType.Type.SERVIETTE:
			
	print(stocks_menstruel)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ShopMenu = get_parent().get_node("ShopMenu")
	ShopMenu.visible = false
	UpgradeMenu = get_parent().get_node("UpgradeDistributionMenu")
	UpgradeMenu.visible = false


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
	


func _on_upgrade_pressed() -> void:
	UpgradeMenu.visible = !(UpgradeMenu.visible)
