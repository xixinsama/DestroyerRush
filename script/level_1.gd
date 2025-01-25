extends Node2D


@onready var player: Node2D = $player
@onready var enemy_1: Node2D = $enemy1
@onready var enemy_2: Node2D = $enemy2
@onready var follow_path_component: FollowPathComponent = $FollowPathComponent
@onready var follow_path_component_2: FollowPathComponent = $FollowPathComponent2
@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var attack_method1: Timer
var attack_method2: Timer
var attack_method3: Timer

func _ready() -> void:
	player.tree_exited.connect(_on_player_exited)
	enemy_1.tree_exited.connect(_on_enemy1_exited)
	enemy_2.tree_exited.connect(_on_enemy2_exited)
	follow_path_component.start_follow()
	follow_path_component_2.start_follow()
	
	attack_method1 = Timer.new()
	add_child(attack_method1)
	attack_method1.wait_time = 6.0
	attack_method1.timeout.connect(attack_1)
	attack_method1.start()
	
	attack_method2 = Timer.new()
	add_child(attack_method2)
	attack_method2.wait_time = 8.0
	attack_method2.timeout.connect(attack_2)
	attack_method2.start()
	
	attack_method3 = Timer.new()
	add_child(attack_method3)
	attack_method3.wait_time = 12.0
	attack_method3.timeout.connect(attack_3)
	attack_method3.start()

func _process(delta: float) -> void:
	# 根据玩家位置上传敌人位置信息至全局
	if player != null:
		if player.global_position.x < 360:
			Status.enemy_position = enemy_1.global_position
		elif player.global_position.x >= 360:
			Status.enemy_position = enemy_2.global_position
		else:
			print("玩家位于三界之外")
			return

func _on_player_exited() -> void:
	if enemy_1 or enemy_2 == null: # 不要动
			return
	else:
		await get_tree().create_timer(1.0).timeout
		set_process(false)
		get_tree().change_scene_to_file("res://scene/game_over.tscn")

func _on_enemy1_exited() -> void:
	pass

func _on_enemy2_exited() -> void:
	pass

# 全局下攻击
func attack_1() -> void:
	var line_down: Bullet # 一排竖着随机水平位置往下落
	var num: int = 8 ##子弹数量
	var speed: int = 150 ##子弹速度
	var frame_bullet = 5 ##子弹样式
	for i in range(0,num):
		line_down = spawner_component.spawn(Vector2(25 + i * round(720 / num) +randi_range(20,50) , -50 + randi_range(-50,50) ),self,0)
		line_down.frame = frame_bullet
		line_down.velocity = Vector2(0,speed)
		line_down.initialize()

# 敌人二的攻击
func attack_2() -> void:
	var direct_follow: Bullet # 瞬间跟踪并很快的往玩家身上射
	var num: int = 40 ##子弹数量
	var speed: int = 600 ##子弹速度
	var frame_bullet = 16 ##子弹样式
	for i in range(0,num):
		var offset: Vector2 = Vector2(randi_range(-4,4), randi_range(-4,4))
		direct_follow = spawner_component.spawn(enemy_2.global_position + Vector2(0 ,48) + offset, self, 0)
		direct_follow.frame = frame_bullet
		direct_follow.speed_trail_2 = speed
		direct_follow.initialize()
		await get_tree().create_timer(0.05).timeout

# 敌人一的攻击
func attack_3() -> void:
	var scatter: Bullet # 散射
	var num: int = 15 ##子弹数量
	var speed: int = 250 ##子弹速度
	var frame_bullet = 7 ##子弹样式
	for i in range(0,num):
		scatter = spawner_component.spawn(enemy_1.global_position + Vector2(0 ,48), self, 0)
		scatter.frame = frame_bullet
		scatter.velocity = speed * Vector2(sin(i) ,abs(cos(i)))
		scatter.initialize()
