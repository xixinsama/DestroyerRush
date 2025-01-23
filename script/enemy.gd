extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_component: StatsComponent = $StatsComponent
@onready var enemy_manage_component: PlayerManageComponent = $EnemyManageComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var destroy_effect_spawner_component: SpawnerComponent = $DestroyEffectSpawnerComponent
@onready var enemy_health_bar: TextureProgressBar = $EnemyHealthBar
@onready var health_label: Label = $HealthLabel
@onready var shake_component: ShakeComponent = $ShakeComponent

@export_range(0, 24) var enemy_looklike: int = 0 ## 选择敌人皮肤
@export_range(0,4) var enemy_destroy_effect: int = 0 ## 选择敌人爆炸效果
@export var enemy_health_max: int = 1## 在关卡中设置最大血量
@export var enemy_health: int = 1## 在关卡中设置血量
@export var enemy_speed: int = 200## 在关卡中设置敌人速度
@export var enemy_damage: int = 1 ## 敌人的碰撞伤害
@export var energy_point: int = 0 ## 敌人死亡(或其他情况)给玩家回复能量点数

signal init_finish

func _ready() -> void:
	# 初始化
	sprite_2d.frame = enemy_looklike
	stats_component.health_max = enemy_health_max
	stats_component.health = enemy_health
	stats_component.speed = enemy_speed
	enemy_manage_component.flag_num = enemy_destroy_effect
	hitbox_component.damage = enemy_damage
	hitbox_component.energy_point = energy_point
	init_finish.emit()
# 另一个ready()
# 通过spawner生成后调用，在本体ready后
func initialize(_flag: int = 0) -> void:
	pass
	
func _process(_delta):
	# 传递 位置 和 位移向量 信息同步至全局‘
	# 只同步了 普通移动 的位移向量，没有 翻滚 的位移向量
	Status.enemy_position = global_position
	Status.enemy_health = stats_component.health

# 血条显示百分比
func _on_stats_component_health_changed(HP_before: int, HP_now: int) -> void:
	var health_percent: float = 100 * float(stats_component.health) / float(stats_component.health_max)
	health_label.text = "%.1f" % health_percent + "%"
	# 使其晃动
	shake_component.tween_shake()
