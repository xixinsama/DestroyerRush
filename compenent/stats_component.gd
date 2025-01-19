## 保存记录精灵状态的节点，包括HP, EP, Speed
class_name StatsComponent
extends Node

@export var health_max: int = 1
@export var health: int = 1: ## 最大血量，最小值为0
	# 当此值修改时调用下面的函数
	set(value):
		health = value
		
		# 当HP改变时，发送信号
		health_changed.emit(health)
		
		print("hp:", health)
		
		# 当HP等于0时，发送信号
		if health == 0: no_health.emit()

# HP的信号
signal health_changed(HP: int)
signal no_health()

@export var energy_max: int = 10 ## 最大能量容量
@export var energy: float = 0.0: ## 最小值为0.0
	# 当此值修改时调用下面的函数
	set(value):
		energy = value
		
		# 当EP改变时，发送信号
		energy_changed.emit(energy)
		
		print("ep:", energy)
		 
		# 当EP等于0时，也就是EP积累满时，发送信号
		if energy == 0: full_energy.emit()

# EP的信号
signal energy_changed(EP: int)
signal full_energy()

@export var speed: int = 200: ## 移动速度，可为负值，若此则反向移动
	# 当此值修改时调用下面的函数
	set(value):
		speed = value
		
		# 当Speed改变时，发送信号
		speed_changed.emit(speed)

# Speed的信号
signal speed_changed(speed_value: int) ## 也不知道有什么用，但就是加上去了

@export var roll_speed: int

func _ready() -> void:
	health = health_max
