extends Node
enum state { LEFT, RIGHT, UP, DOWN }
enum rooms_type { START, NORMAL, BOSS }
var array_rooms : Array = []

var start_room = preload("res://scenes/room/room.tscn")
var rooms : Array = [
	preload("res://scenes/room/room1.tscn")
]

var room_finished = true
var number_enemy = 0
var current_room : Vector2 = Vector2(0, 0)
var current_room_instance = null
var boss_rooms : Array = [
	preload("res://scenes/room/room1.tscn")
]
var player : Player = null
var player_scene = preload("res://entities/player/player.tscn")
var size = 5

# Called when the node enters the scene tree for the first time.

func get_current_room_path() -> PackedScene:
	return array_rooms[current_room.x][current_room.y]

func instantiate_room(room: PackedScene) -> void:
	get_tree().change_scene_to_packed(room)
	#add player to the room
	await get_tree().process_frame
	current_room_instance = get_tree().get_root().get_child(0)
	get_tree().get_root().add_child(player)
	player.global_position = Vector2(160,168)

func _ready() -> void:
	player = player_scene.instantiate()
	for i in range(0, size):
		array_rooms.append([])
		for j in range(0, size):
			array_rooms[i].append(0)
	
	generate_rooms()

	instantiate_room(array_rooms[current_room.x][current_room.y])


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(room_finished)
	pass

func decrease_enemy(nb: int) -> void:
	number_enemy -= nb
	if number_enemy <= 0:
		room_finished = true
	else:
		room_finished = false


func change_room(direction: int) -> void:
	if !room_finished:
		print("Room not finished")
		return

	if direction == state.LEFT:
		current_room.x -= 1
	elif direction == state.RIGHT:
		current_room.x += 1
	elif direction == state.UP:
		current_room.y += 1
	elif direction == state.DOWN:
		current_room.y -= 1
	print(current_room)
	# current_room_instance.queue_free()
	if current_room.x < 0 or current_room.x >= size or current_room.y < 0 or current_room.y >= size:
		print("Out of bounds")
		return

	var players = get_tree().get_nodes_in_group("player")
	var player = players[0]

	player.global_position = Vector2(128, 128)
	
	instantiate_room(array_rooms[current_room.x][current_room.y])

	await current_room_instance.ready

	var enemies = current_room_instance.get_tree().get_nodes_in_group("enemy")
	number_enemy = enemies.size()
	if number_enemy <= 0:
		room_finished = true
	else:
		room_finished = false
func reset_array_rooms() -> void:
	for i in range(0, size):

		for j in range(0, size):
			array_rooms[i][j] = 0

func generate_rooms() -> void:
	reset_array_rooms()
	var nb_rooms = rooms.size()

	array_rooms[size - 1][int(size/2)] = rooms_type.START
	array_rooms[0][int(size/2)] = rooms_type.BOSS

	for i in range(1, size - 1):
		array_rooms[i][int(size/2)] = rooms_type.NORMAL

	current_room = Vector2(size - 1, int(size/2))

	for i in range(0, size):
		for j in range(0, size):
			if array_rooms[i][j] == rooms_type.START:
				array_rooms[i][j] = start_room
			elif array_rooms[i][j] == rooms_type.NORMAL:
				var random_room = randi() % nb_rooms
				array_rooms[i][j] = rooms[random_room]
			elif array_rooms[i][j] == rooms_type.BOSS:
				array_rooms[i][j] = boss_rooms[0]
	array_rooms[4][3]  = rooms[0]
func print_rooms() -> void:
	for i in range(0, size):
		for j in range(0, size):
			print(array_rooms[i][j])
		print("\n")
