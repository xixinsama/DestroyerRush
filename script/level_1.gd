extends Node2D


@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy
@onready var spawner_component: SpawnerComponent = $SpawnerComponent



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
	pass
