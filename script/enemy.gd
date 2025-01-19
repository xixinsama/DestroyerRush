extends Node2D


@onready var stats_component: StatsComponent = $StatsComponent
@onready var enemy_manage_component: PlayerManageComponent = $EnemyManageComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroy_effect_spawner_component: SpawnerComponent = $DestroyEffectSpawnerComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var spawn_points: Node2D = $SpawnPoints
@onready var enemy_health_bar: TextureProgressBar = $EnemyHealthBar

func _ready() -> void:
	# 发射第一类子弹
	var fire_timer1: Timer = Timer.new() # 创建一个计时器节点
	add_child(fire_timer1)
	fire_timer1.wait_time = 05
	fire_timer1.autostart = true
	fire_timer1.name = "FireDelay"
	# 启动计时器
	fire_timer1.start()
	fire_timer1.timeout.connect(fire_bullet1)
	
func fire_bullet1() -> void:
	var l1: Marker2D = spawn_points.get_node("left_1")
	#spawner_component.spawn(l1.global_position)
	var r1: Marker2D = spawn_points.get_node("right_1")
	#spawner_component.spawn(r1.global_position)

func initialize(_flag: int = 0) -> void:
	pass
	#sprite_2d.frame = flag
	#if flag == 2:
		#stats_component.speed == 300
