extends State

@export var rDispersion : float = 10

var target_position : Vector2 = Vector2()
var start_position : Vector2 = Vector2()
var mid_position : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var percentage_done : float = 0
var distance : float = 0
@export var max_distance : float = 80


var old_sprite_position : Vector2 = Vector2()
var dispersing : bool = false

var wall_ignore_timer : Timer = Timer.new()
var ignore_wall : bool = true
var _in_wall : bool = false

func _ready() -> void:
	wall_ignore_timer.timeout.connect(_enable_wall_collision)
	wall_ignore_timer.wait_time = 0.20
	wall_ignore_timer.one_shot = true
	add_child(wall_ignore_timer)
	pass

func enter() -> void:
	dispersing = true
	ignore_wall = true
	wall_ignore_timer.start()

	start_position = entity.global_position

	# calculate_direction
	target_position = predict_distance(entity.player.global_position, entity.player.input, start_position)
	# target_position = entity.player.global_position - (entity.player.global_position - start_position) * (0.05)
	direction = (target_position - start_position).normalized()
	distance = entity.global_position.distance_to(target_position)
	
	old_sprite_position = entity.animation.position
	pass

func process(delta: float) -> void:
	if !ignore_wall and _in_wall:
		emit_signal("state_finished", self, "pickable")
		return
	entity.global_position += direction * delta * entity.dispersion_speed

	var new_distance = entity.global_position.distance_to(target_position)
	percentage_done = (distance - new_distance) / distance + 0.05
	entity.animation.rotation_degrees = 360 * percentage_done * int(distance/25)

	add_perspective()

	if entity.global_position.distance_to(target_position) <= 5:
		emit_signal("state_finished", self, "pickable")
		return
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	dispersing = false
	entity.animation.position = old_sprite_position
	entity.shadow.scale = Vector2(1, 1)
	entity.animation.rotation_degrees = 0
	ignore_wall = true
	pass

func add_perspective() -> void:
	var factor = 0.6
	entity.shadow.scale = Vector2((1 - sin(percentage_done * PI) * factor), (1 - sin(percentage_done * PI)* factor))
	entity.animation.position.y = -10 * sin(percentage_done * PI)
	pass

func _enable_wall_collision() -> void:
	ignore_wall = false
	pass

func _on_wall_touched() -> void:
	_in_wall = true
	pass # Replace with function body.

func _on_wall_exited() -> void:
	_in_wall = false
	pass # Replace with function body.
	
func predict_distance(pA : Vector2, dirA : Vector2, pB : Vector2) -> Vector2:
	var predict_pA = pA + dirA * 50
	var distance = predict_pA.distance_to(pB)

	if distance > max_distance:
		var ratio = distance / max_distance
		var vector = (predict_pA - pB) / ratio
		predict_pA = pB + vector
	if dirA == Vector2():
		predict_pA += Vector2(randf_range(-rDispersion * 2, rDispersion * 2), randf_range(-rDispersion * 2, rDispersion * 2))
	else:
		predict_pA += Vector2(randf_range(-rDispersion, rDispersion), randf_range(-rDispersion, rDispersion))
	return predict_pA
