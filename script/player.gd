extends Node2D

# 首先把所有子节点搬过来
@onready var stats_component: StatsComponent = $StatsComponent
@onready var player_manage_component: PlayerManageComponent = $PlayerManageComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var move_component: MoveComponent = $MoveComponent
@onready var move_input_component: MoveInputComponent = $MoveInputComponent
@onready var position_clamp_component: PositionClampComponent = $PositionClampComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var graze_area: Area2D = $GrazeArea
@onready var edge_ball: EdgeBall = $EdgeBall
@onready var spawn_points: Node2D = $SpawnPoints
@onready var bullet_spawner_component: SpawnerComponent = $BulletSpawnerComponent
@onready var destroy_effect_spawner_component_2: SpawnerComponent = $DestroyEffectSpawnerComponent2
@onready var frame_animated_sprite_2d: AnimatedSprite2D = $FrameAnimatedSprite2D

# 翻滚计时器
var roll_timer: Timer = null
var trail_timer: Timer = null
# var is_double_click: bool = false
@export_range(0, 4) var play_looklike: int = 0 ## 选择玩家皮肤

func _ready():
	# 发射第一类子弹
	var fire_timer1: Timer = Timer.new() # 创建一个计时器节点
	add_child(fire_timer1)
	fire_timer1.wait_time = 0.5
	fire_timer1.autostart = true
	fire_timer1.name = "FireDelay"
	# 启动计时器
	fire_timer1.start()
	fire_timer1.timeout.connect(fire_bullet1)
	
	
	## 翻滚等待CD的计时器
	#roll_timer = Timer.new()
	#roll_timer.one_shot = true
	#roll_timer.wait_time = 0.25
	#add_child(roll_timer)
	#roll_timer.name = "DoubleClickTimer"
	## 翻滚时的残影计时器
	trail_timer = Timer.new()
	add_child(trail_timer)
	trail_timer.name = "TrailTimer"
	trail_timer.wait_time = 0.1
	# trail_timer.autostart = true
	trail_timer.timeout.connect(start_trail)
	

func fire_bullet1() -> void:
	var l1: Marker2D = spawn_points.get_node("left_1")
	bullet_spawner_component.spawn(l1.global_position)
	var r1: Marker2D = spawn_points.get_node("right_1")
	bullet_spawner_component.spawn(r1.global_position)

func _process(_delta):
	# 改变移动动画
	animate_the_ship()
	# 传递 位置 和 位移向量 信息同步至全局‘
	# 只同步了 普通移动 的位移向量，没有 翻滚 的位移向量
	Status.player_position = position
	Status.player_velocity = move_component.velocity + move_component.roll_velocity

#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("roll"):
		#if roll_timer.is_stopped():
			#is_double_click = false
			#roll_timer.start()
		#else:
			#is_double_click = true
			#print("Double Click!")

func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		sprite_2d.frame_coords = Vector2(0, play_looklike)
		frame_animated_sprite_2d.play("left")
	elif move_component.velocity.x > 0:
		sprite_2d.frame_coords = Vector2(2, play_looklike)
		frame_animated_sprite_2d.play("right")
	else:
		sprite_2d.frame_coords = Vector2(1, play_looklike)
		frame_animated_sprite_2d.play("centre")

## 试图实现双击翻滚
#func double_click_roll() -> void:
	#pass

func start_trail() -> void:
	if move_component.sum_velocity == Vector2():
		return
	
	var trail = preload("res://scene/trail.tscn").instantiate()
	get_parent().add_child(trail)
	get_parent().move_child(trail, get_index())
	
	var properties = [
		"hframes",
		"vframes",
		"frame",
		"texture",
		"global_position",
		"filp_h"
	]
	
	for name_prop in properties:
		trail.set(name_prop, sprite_2d.get(name_prop))
	trail.set("scale", self.scale) # player的根节点放大了，所以这里也要放大

# 在翻滚时留下残影，并取消玩家碰撞检测
func _on_move_input_component_roll_start() -> void:
	trail_timer.start()
	hurtbox_component.monitorable = false
func _on_move_input_component_roll_finish() -> void:
	trail_timer.stop()
	hurtbox_component.monitorable = true
	
