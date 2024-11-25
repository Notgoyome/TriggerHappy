extends Node
#TO REMOVE

@onready var parent : Node2D = get_parent()
var player : Player = null
var speed : float = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		#get group player
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0] as Player
		else:
			return
	var direction = (player.global_position - parent.global_position).normalized()
	parent.velocity = direction * speed * delta
	pass
