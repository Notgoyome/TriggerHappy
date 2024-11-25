extends State
var pickable  : bool = false
var pick_request : bool = false
var player: Player = null
var bullet : Bullet

func _ready() -> void:
	pass

func enter() -> void:
	bullet = entity as Bullet
	pickable = true
	bullet.animation.play("idle")
	entity.shadow.position.y = 6 #TO DO put this variable in bullet
	pass

func process(delta: float) -> void:
	if pick_request:
		if player and player.selected_weapon != null:
			player.selected_weapon.bullets.append(entity)
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
	print("Player touched")
	pick_request = true
	self.player = player
		
		#TO DO better implementation
	pass # Replace with function body.


func _on_collider_component_on_player_exited() -> void:
	if pick_request:
		print("Player exited")
		pick_request = false
	pass # Replace with function body.
