extends PathFollow2D

@onready var enemy: Node2D = $enemy

# 通过加载父节点Path2D的曲线资源来获取不同路径
# 在这里写敌人移动的逻辑

func _process(delta: float) -> void:
	# 巡逻
	var stats: StatsComponent = enemy.get_node("StatsComponent")
	var speed: int = stats.speed
	progress += speed * delta
