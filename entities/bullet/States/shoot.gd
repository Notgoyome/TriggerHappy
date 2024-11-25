extends State
var shooting  : bool = false
var bullet : Bullet

func _ready() -> void:
    pass

func enter() -> void:
    bullet = entity as Bullet
    shooting = true
    bullet.animation.play("shoot")
    
    var angle = atan2(bullet.direction.y,bullet.direction.x)

    bullet.animation.rotation_degrees = rad_to_deg(angle) + 90
    pass

func process(delta: float) -> void:
    #TO DO , change entity to bullet
    entity.global_position += entity.direction * delta * entity.speed
    pass

func physic_process(delta: float) -> void:
    pass

func exit() -> void:
    shooting = false
pass
func _on_wall_touched() -> void:
    if shooting:
        emit_signal("state_finished", self, "Disperse")
    pass # Replace with function body.


func _on_enemy_touched(body : Enemy) -> void:
    if shooting:
        if body.has_node("HealthComponent"):
            var health_component = body.get_node("HealthComponent")
            health_component.take_damage(bullet.damage)
        emit_signal("state_finished", self, "Disperse")
    pass # Replace with function body.
