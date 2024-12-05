extends Area2D
@onready var parent = null
signal on_player_touched
signal on_player_exited
signal on_enemy_touched
signal on_wall_touched
signal on_wall_exited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area:Area2D) -> void:
	if area.get_parent() is Player:
		emit_signal("on_player_touched", area.get_parent())
	pass # Replace with function body.


func _on_body_entered(body:Node2D) -> void:
	if body is TileMapLayer:
		emit_signal("on_wall_touched")
	elif body is Enemy:
		emit_signal("on_enemy_touched", body)
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		emit_signal("on_player_exited")
	pass # Replace with function body.


func _on_body_exited(body:Node2D) -> void:
	if body is TileMapLayer:
		emit_signal("on_wall_exited")
	pass # Replace with function body.
