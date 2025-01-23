extends Node2D


@onready var player: Node2D = $player
@onready var enemy_1: Node2D = $enemy1
@onready var enemy_2: Node2D = $enemy2
@onready var follow_path_component_1: FollowPathComponent = $FollowPathComponent
@onready var follow_path_component_2: FollowPathComponent = $FollowPathComponent2

func _ready() -> void:
	#player.tree_exited.connect(func():
		#if enemy == null: # 不要动
			#return
		#else:
			#await get_tree().create_timer(1.0).timeout
			#get_tree().change_scene_to_file("res://scene/game_over.tscn")
		#)
	#enemy.tree_exited.connect(func():
		#if player == null:
			#return
		#else:
			#await get_tree().create_timer(1.0).timeout
			#get_tree().change_scene_to_file("res://Levels/level_2.tscn") # 改这里
		#)
	follow_path_component_1.start_follow(1)
	follow_path_component_2.start_follow(1505)
	pass
