extends StaticBody2D

class_name Enemy

var velocity: Vector2 = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_collide(velocity)
	pass


func _on_death() -> void:
	DungeonManager.decrease_enemy(1)
	queue_free()
	pass # Replace with function body.
