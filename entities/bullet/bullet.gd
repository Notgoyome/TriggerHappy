extends Node2D
class_name Bullet

@export var speed : float = 300
@export var damage : float = 10
@export var dispersion_speed : float = 90

@onready var collider_component : Area2D = $ColliderComponent
@onready var collision_shape : CollisionShape2D= $ColliderComponent/CollisionShape2D
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var shadow : AnimatedSprite2D = $Shadow
var direction : Vector2 = Vector2()
var enabled : bool = false
var player: Player = null


enum State { IDLE, MOVING, HIT }

func _ready() -> void:
	top_level = true
	if animation == null:
		print("No animation found")
	disable()
	pass # Replace with function body.

func _process(delta: float) -> void:
	# if enabled:
	#     global_position += direction * delta * speed
	#will change this later
	pass

func disable() -> void:
	hide()
	collision_shape.disabled = true
	enabled = false
	set_process(false)
	pass # Replace with function body.

func enable() -> void:
	show()
	collision_shape.disabled = false
	enabled = true
	set_process(true)
	pass # Replace with function body.

func _on_wall_touched() -> void:

	pass # Replace with function body.
