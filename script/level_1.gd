extends Node2D


@onready var player: Node2D = $player
@onready var enemy_1: Node2D = $enemy1
@onready var enemy_2: Node2D = $enemy2
@onready var follow_path_component_1: FollowPathComponent = $FollowPathComponent
@onready var follow_path_component_2: FollowPathComponent = $FollowPathComponent2
@onready var bullet: Bullet = $Node2D/bullet
@onready var bullet_2: Bullet = $Node2D/bullet2
@onready var bullet_3: Bullet = $Node2D/bullet3
@onready var bullet_4: Bullet = $Node2D/bullet4

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
	#follow_path_component_1.start_follow(1)
	#follow_path_component_2.start_follow(1505)
	# get_node()并初始化
	#var bf1: FollowPathComponent = bullet.get_node("FollowPathComponent")
	#bf1.path_points = preload("res://asset/PathSrc/path_circle.tres")
	#bf1.start_follow()
	#bf1.speed = 200
	# 
	# bullet.initialize()
	
	#bullet_2.path_points = preload("res://asset/PathSrc/path_circle.tres") #失败
	#bullet_2.start_follow() # 成功
	#bullet_2.speed = 250
	#bullet_3.path_points = preload("res://asset/PathSrc/path_circle.tres")
	##bullet_3.start_follow()
	#bullet_2.speed = 300
	#bullet_4.path_points = preload("res://asset/PathSrc/path_circle.tres")
	##bullet_4.start_follow()
	#bullet_2.speed = 350
	pass
