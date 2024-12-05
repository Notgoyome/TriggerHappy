extends State
var target_position : Vector2 = Vector2()
var start_position : Vector2 = Vector2()
var mid_position : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var percentage_done : float = 0
var distance : float = 0

var old_sprite_position : Vector2 = Vector2()
var dispersing : bool = false

var wall_ignore_timer : Timer = Timer.new()
var ignore_wall : bool = true
func _ready() -> void:
    wall_ignore_timer.timeout.connect(_enable_wall_collision)
    wall_ignore_timer.wait_time = 0.1
    wall_ignore_timer.one_shot = true
    add_child(wall_ignore_timer)
    pass

func enter() -> void:
    dispersing = true
    ignore_wall = true
    wall_ignore_timer.start()

    target_position = entity.player.global_position
    start_position = entity.global_position

    mid_position = target_position - (target_position - start_position) * (0.05)
    direction = (target_position - start_position).normalized()
    
    distance = entity.global_position.distance_to(mid_position)
    
    old_sprite_position = entity.animation.position
    pass

func process(delta: float) -> void:
    entity.global_position += direction * delta * entity.dispersion_speed

    var new_distance = entity.global_position.distance_to(mid_position)
    percentage_done = (distance - new_distance) / distance + 0.05
    entity.animation.rotation_degrees = 360 * percentage_done * int(distance/25)

    add_perspective()

    if entity.global_position.distance_to(mid_position) <= 5:
        emit_signal("state_finished", self, "pickable")
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
    if dispersing and !ignore_wall:
        emit_signal("state_finished", self, "pickable")
    pass # Replace with function body.
