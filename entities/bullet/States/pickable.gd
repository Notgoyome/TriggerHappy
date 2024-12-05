extends State
var pickable  : bool = false
var pick_request : bool = false
var player: Player = null
var bullet : Bullet
@export var speed : float = 20
var actual_speed : float = 0

func _ready() -> void:
	pass

func enter() -> void:
	bullet = entity as Bullet
	pickable = true
	bullet.animation.play("idle")
	entity.shadow.position.y = 6 #TO DO put this variable in bullet
	pass

func process(delta: float) -> void:
	var distance = entity.global_position.distance_to(entity.player.global_position)
	entity.global_position = entity.global_position.move_toward(entity.player.global_position, actual_speed * delta *max(50/distance,1))

	if pick_request:
		if bullet.player and bullet.player.selected_weapon != null:
			bullet.player.selected_weapon.add_bullet(entity)
			emit_signal("state_finished", self, "Reloaded")
			get_tree().get_root().add_child(entity)
			entity.disable()
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	pickable = false
	pass


func _on_player_touched(player: Player) -> void:
	bullet = entity as Bullet
	if bullet.player == player:
		pick_request = true
		
		#TO DO better implementation
	pass # Replace with function body.


func _on_collider_component_on_player_exited() -> void:
	if pick_request:
		pick_request = false
	pass # Replace with function body.



func _on_area_2d_body_exited(body:Node2D) -> void:
	if body is Player:
		actual_speed = speed

	pass # Replace with function body.

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is Player:
		actual_speed = speed
	pass # Replace with function body.
