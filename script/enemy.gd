extends Node2D


@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var spawn_points: Node2D = $SpawnPoints

func _ready() -> void:
	# 发射第一类子弹
	var fire_timer1: Timer = Timer.new() # 创建一个计时器节点
	add_child(fire_timer1)
	fire_timer1.wait_time = 0.5
	fire_timer1.autostart = true
	fire_timer1.name = "FireDelay"
	# 启动计时器
	fire_timer1.start()
	fire_timer1.timeout.connect(fire_bullet1)
	
func fire_bullet1() -> void:
	var l1: Marker2D = spawn_points.get_node("left_1")
	spawner_component.spawn(l1.global_position)
	var r1: Marker2D = spawn_points.get_node("right_1")
	spawner_component.spawn(r1.global_position)
