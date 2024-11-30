extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Clock.timeout.connect(place_product)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_product()
		$Clock.start()
		print("get serviette")

func place_product() -> void:
	$ProductCollider.disabled = false
	$ProductCollider/Product.visible = true

func get_product() -> void:
	$ProductCollider.disabled = true
	$ProductCollider/Product.visible = false
