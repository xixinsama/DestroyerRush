extends Node2D
@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy


# 三个阶段（25，50，75），每一阶段会放出另一个之前打过的BOSS，但是削弱过的版本
# 在放出之前的BOSS之后，不可索敌，停止移动，等杀死另一个BOSS之后恢复
# 召唤出的BOSS血量降低，只会一种弹幕攻击模式，移动方式随机
# 此BOSS每个阶段多增加一种弹幕，第三阶段就四种攻击模式，其中一种为全局攻击
# 这种全局攻击模式在随阶段增强（四种） 第一种数量很少，第二种数量变多，第三种旋转
# 七种本身具有，三种召唤出的BOSS具有

func _ready() -> void:
	player.tree_exited.connect(func():
		if enemy == null: # 不要动
			return
		else:
			await get_tree().create_timer(1.0).timeout
			var InventoryScene: PackedScene = preload("res://scene/game_over.tscn")
			Transitions.change_scene_to_instance(InventoryScene.instantiate(), 
			Transitions.FadeType.CrossFade)
		)
	enemy.tree_exited.connect(func():
		if player == null:
			return
		else:
			await get_tree().create_timer(1.0).timeout
			var InventoryScene: PackedScene = preload("res://Levels/level_3.tscn")
			Transitions.change_scene_to_instance(InventoryScene.instantiate(), 
			Transitions.FadeType.CrossFade)
			#FancyFade.swirl(InventoryScene.instantiate())
		)
