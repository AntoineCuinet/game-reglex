extends Node2D


@export var research_per_sec = 5;
@export var wait_time = 3;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 3
	$Timer.start()

func _on_timer_timeout():
	get_parent().get_node("GameManager").add_research_points($Timer.wait_time * research_per_sec)
