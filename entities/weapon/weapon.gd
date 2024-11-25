extends Node2D

class_name Weapon

@export var margin : float = 5
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var _selected = false
var target_pos : Vector2 = Vector2()
var user : Player = null

var bullets : Array[Node2D] = []

func _ready() -> void:
	hide()
	for child in get_children():
		if child is Bullet:
			bullets.append(child)
			child.player = user
	pass

func _process(delta: float) -> void:
	if _selected:
		var direction = (target_pos-user.global_position).normalized()
		global_position = user.global_position + direction * margin
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false        
	pass

func shoot() -> void:
	if bullets.size() > 0:
		var selected_bullet : Bullet = bullets[0] as Bullet
		#TO DO créer un interface qui permet d'utiliser seuelement une fonction
		remove_child(selected_bullet)
		get_tree().get_root().add_child(selected_bullet)
		selected_bullet.enable()
		selected_bullet.direction = (target_pos-user.global_position).normalized()
		selected_bullet.global_position = global_position
		bullets.pop_front()
	pass

func select_weapon(parent: Node2D) -> Weapon:
	_selected = true
	user = parent
	for bullet in bullets:
		bullet.player = user
	show()
	return self

func deselect_weapon() -> void:
	_selected = false
	user = null
	hide()
	pass
