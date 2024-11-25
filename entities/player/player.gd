extends CharacterBody2D
class_name Player
@export var speed = 5000
var weapons : Array[Weapon] = []
var selected_weapon : Weapon = null
var input = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Weapon:
			weapons.append(child as Weapon)
	if weapons.size() > 0:
		selected_weapon = weapons[0].select_weapon(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	selected_weapon.target_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("shoot"):
		selected_weapon.shoot()
	pass

func _physics_process(delta: float) -> void:
	input = Vector2()
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()
	velocity = input * speed * delta
	move_and_slide()
