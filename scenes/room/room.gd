extends Node2D


func _ready() -> void:
    var enemies = get_tree().get_nodes_in_group("enemies")
    if enemies.size() != 0:
        DungeonManager.room_finished = false
    
    pass # Replace with function body.
