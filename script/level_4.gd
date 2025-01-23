extends Node2D

@onready var player_label: Label = $PlayerLabel
@onready var enemy_label: Label = $EnemyLabel
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var player: Sprite2D = $Player
@onready var enemy: Sprite2D = $Enemy
@onready var enemy_2d: Node2D = $Enemy2D
@onready var player_2d: Node2D = $Player2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var trash_talk: Label = $TrashTalk

const ROUND_DURATION = 0.5  # 每轮持续时间
const GOAL = 100  # 胜利的推进总距离
const START = 0  # 起始点
const END = 50 # 重置值

var player_count = 0
var enemy_count = 0
var progress = 50
var round_timer = ROUND_DURATION
var game_running = false

# 震动模块的变量
# 存储当前震动幅度，将随时间减小
var player_shake: float = 0.0
var enemy_shake: float = 0.0
var shake_amount: float = 50.0 # 震动幅度
var shake_duration: float = 0.3 # 震动持续时间

# 包装后节点的信息
var player_scale: Vector2
var enemy_scale: Vector2
#记录当前位置
var player_position: Vector2
var enemy_position: Vector2

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("skill"):
		if game_running:
			player_count += 1
		else:
			animation_player.play("start")
			# 重置
			player.visible = true
			player_2d.visible = true
			enemy_2d.visible = true
			animation_player.animation_finished.connect(start_game.unbind(1))


func start_game() -> void:
	print("游戏开始！")
	# 记录当前缩放尺寸
	player_scale = player_2d.scale
	enemy_scale = enemy_2d.scale
	player_position = player_2d.position
	enemy_position = enemy_2d.position
	enemy_label.text = "我要开始发力了。"
	game_running = true

func _ready():
	player_2d.visible = false
	enemy_2d.visible = false
	progress_bar.value = 0.0
	enemy_label.text = "按空格开始吧！"

func _process(delta):
	if game_running:
		round_timer -= delta
		if round_timer <= 0:
			evaluate_round()
			round_timer = ROUND_DURATION
		update_ui()
		update_laser(delta)

# 每轮结算
func evaluate_round():
	# 随机生成敌方按键次数
	# 动态难度
	if 70 > progress and progress > 50:
		enemy_count = randi_range(1, 4)
	elif  90 > progress and progress >= 70:
		enemy_count = randi_range(2, 4)
	elif  100 > progress and progress >= 90:
		enemy_count = randi_range(2, 5)
	elif  50 >= progress and progress >= 0:
		enemy_count = randi_range(-1, 6)
	else:
		return
	
	var count: int = player_count - enemy_count
	progress += count
	# 后面减少震动幅度
	shake_amount += count
	
	if count >= 0:
		tween_shake(player_2d)
	else:
		tween_shake(enemy_2d)
	# 进度范围限制
	progress = clamp(progress, START, GOAL)

	# 检查游戏是否结束
	if progress >= GOAL:
		level_win()
	elif progress <= START:
		game_over()

	# 重置玩家按键次数
	player_count = 0

func update_ui():
	progress_bar.value = progress
	player_label.text = "剩余时间: %.2f" % round_timer + "按键次数: %d" % player_count
	enemy_label.text = "敌方按键: %d" % enemy_count

func update_laser(delta: float) -> void: 
	var progress_change = 2.7 * delta * (progress - 50)# (0-100, now)
	var final_ps: Vector2 = player_scale + Vector2(progress_change/2, progress_change)
	var final_es: Vector2 = enemy_scale - Vector2(progress_change/2, progress_change)
	create_tween().tween_property(player_2d, "scale", final_ps, 0.2)
	create_tween().tween_property(enemy_2d, "scale", final_es, 0.2)
	
func level_win() -> void:
	print("胜利")
	enemy.visible = false
	enemy_2d.visible = false
	# 等待一定时间进入下一场景
	
func game_over() -> void:
	print("杂鱼~杂鱼~")
	game_running= false
	# 重置场景
	player.visible = false
	player_2d.visible = false
	enemy_2d.visible = false
	progress = END

func tween_shake(node_name: Node2D):
	# 创造一个缓动效果，并最终降到0
	if node_name == player_2d:
		player_shake = shake_amount
		create_tween().tween_property(self, "player_shake", 0.0, shake_duration).from_current()
	if node_name == enemy_2d:
		enemy_shake = shake_amount
		create_tween().tween_property(self, "enemy_shake", 0.0, shake_duration).from_current()

func _physics_process(_delta: float) -> void:
	# Manipulate the position of the node by the shake amount every physics frame
	# Use randf_range to pick a random x and y value using the shake value
	if game_running == true:
		player_2d.position = player_position + Vector2(randf_range(-player_shake, player_shake), randf_range(-player_shake, player_shake))
		enemy_2d.position = enemy_position + Vector2(randf_range(-enemy_shake, enemy_shake), randf_range(-enemy_shake, enemy_shake))
	else:
		return
