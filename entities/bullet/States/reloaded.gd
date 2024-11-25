extends State
var bullet : Bullet
func enter() -> void:
    bullet = entity as Bullet
    pass

func process(delta: float) -> void:
    if bullet.enabled:
        emit_signal("state_finished", self, "shoot")
    pass

func physic_process(delta: float) -> void:
    pass