extends Node2D

class_name Weapon

@export var margin : float = 0
@onready var fire_rate : Timer = $FireRate 
@onready var click_buffering : Timer = $ClickBuffering

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var _selected = false
var target_pos : Vector2 = Vector2()
var user : Player = null
var can_shoot = true
var request_shoot = false
var bullets : Array[Node2D] = []

# Sounds

@onready var shoot_sound : AudioStreamPlayer2D = $ShootSound
@onready var reload_sound : AudioStreamPlayer2D = $reloadSound

signal on_shoot
signal on_add_bullet

func _ready() -> void:
	hide()
	for child in get_children():
		if child is Bullet:
			bullets.append(child)
			child.player = user
	fire_rate.timeout.connect(_on_fire_rate_timeout)
	click_buffering.timeout.connect(_on_click_buffering_timeout)
	pass

func _process(delta: float) -> void:
	if _selected:
		handle_weapon_position()
	pass

func shoot() -> void:
	request_shoot = true
	click_buffering.start()
	if bullets.size() > 0 and can_shoot and request_shoot:
		click_buffering.stop()
		consumme_bullet()
		fire_rate.start()
		can_shoot = false
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

func consumme_bullet():
	if bullets.size() == 0:
		return
	emit_signal("on_shoot")
	var	selected_bullet : Bullet = bullets[0] as Bullet
	remove_child(selected_bullet)
	get_tree().current_scene.call_deferred("add_child", selected_bullet)
	selected_bullet.enable()
	selected_bullet.direction = (target_pos-user.global_position).normalized()
	selected_bullet.global_position = global_position
	bullets.pop_front()

func add_bullet(entity: Node2D) -> void:
	bullets.append(entity)
	emit_signal("on_add_bullet", entity)


func _on_on_shoot() -> void:
	shoot_sound.play()
	pass # Replace with function body.

#timeout

func _on_fire_rate_timeout() -> void:
	can_shoot = true
	pass

func _on_click_buffering_timeout() -> void:
	request_shoot = false
	pass


# single use function

func handle_weapon_position():
	var direction = (target_pos-user.global_position).normalized()
	global_position = user.global_position + direction * margin
	rotation_degrees = direction.angle() * 180 / PI
	if direction.x < 0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false     

func _on_on_add_bullet() -> void:
	print("on_add_bullet")
	reload_sound.play()
	pass # Replace with function body.
