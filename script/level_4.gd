extends Node2D

@onready var player_label: Label = $PlayerLabel
@onready var enemy_label: Label = $EnemyLabel
@onready var progress_bar: ProgressBar = $ProgressBar

const ROUND_DURATION = 0.5  # 每轮持续时间
const GOAL = 100  # 胜利的推进总距离
const START = 0  # 起始点
const END = 50

var player_count = 0
var enemy_count = 0
var progress = 50
var round_timer = ROUND_DURATION
var game_running = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			if game_running:
				player_count += 1
			else:
				game_running = true
				print("游戏开始！")
				enemy_label.text = "我要开始发力了。"



func _ready():
	progress_bar.value = 0.0
	enemy_label.text = "按空格开始吧！"

func _process(delta):
	if game_running:
		round_timer -= delta
		if round_timer <= 0:
			evaluate_round()
			round_timer = ROUND_DURATION
		update_ui()

# 每轮结算
func evaluate_round():
	# 随机生成敌方按键次数
	# 动态难度
	if 70 > progress and progress > 50:
		enemy_count = randi_range(1, 5)
	elif  90 > progress and progress >= 70:
		enemy_count = randi_range(2, 5)
	elif  100 > progress and progress >= 90:
		enemy_count = randi_range(3, 4)
	elif  50 >= progress and progress >= 0:
		enemy_count = randi_range(0, 6)
	else:
		return
	
	var count: int = player_count - enemy_count
	progress += count
	
	# 进度范围限制
	progress = clamp(progress, START, GOAL)

	# 检查游戏是否结束
	if progress >= GOAL:
		print("胜利")
	elif progress <= START:
		game_over()

	# 重置玩家按键次数
	player_count = 0

func update_ui():
	progress_bar.value = progress
	player_label.text = "剩余时间: %.2f" % round_timer + "按键次数: %d" % player_count
	enemy_label.text = "敌方按键: %d" % enemy_count

func game_over():
	print("杂鱼~杂鱼~")
	game_running= false
