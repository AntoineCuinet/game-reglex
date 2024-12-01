extends Area2D

const FactoryType = preload("res://scripts/factory_type.gd")

var type: FactoryType.Type;
var is_set_up: bool = false
var amount_per_harvest: int = 10

func set_up(t: FactoryType.Type) -> void:
	is_set_up = true
	type = t
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Clock.timeout.connect(place_product)
	#set_up(FactoryType.Type.SERVIETTE)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_product()
		$Clock.start()
		print("get serviette")
		harvest()

func place_product() -> void:
	$ProductCollider.disabled = false
	$ProductCollider/Product.visible = true
	

func get_product() -> void:
	$ProductCollider.disabled = true
	$ProductCollider/Product.visible = false

func harvest() -> void:
	get_parent().get_node("GameManager").add_produits_menstruels(type, amount_per_harvest)
