class_name PlayerManageComponent
extends Node

@export var hurtboxcomponent: HurtboxComponent
@export var statscomponent: StatsComponent

func _ready() -> void:
	# 自身碰撞盒发出信号，连接匿名函数，扣除血量
	hurtboxcomponent.hurt.connect(func(hitbox: HitboxComponent):
		statscomponent.health -= hitbox.damage
		)

# 当擦弹成功，增加能量
func _on_edge_ball_energy_up(energy_point: float) -> void:
	statscomponent.energy += energy_point
