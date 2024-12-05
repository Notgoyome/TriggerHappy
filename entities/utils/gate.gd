extends Area2D

@export var door_direction = DungeonManager.state.LEFT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	if body is Player and is_instance_valid(DungeonManager) and DungeonManager.room_finished:
		DungeonManager.change_room(door_direction)
	pass # Replace with function body.
