extends Node2D

var health : int = 30
var max_health : int = 30
@onready var parent : Node2D = get_parent()
func _ready() -> void:

    pass # Replace with function body.

func _process(delta: float) -> void:
    pass

func take_damage(damage: int) -> void:
    health -= damage
    print(health)
    if health <= 0:
        parent.queue_free()