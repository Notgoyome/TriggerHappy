extends Camera2D

var off_set = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# disable camera
	set_process(false)
	enabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var distance = global_position.distance_to(mouse_pos)
	var direction = global_position.direction_to(mouse_pos)

	position = direction * 5 * distance/50
	pass
