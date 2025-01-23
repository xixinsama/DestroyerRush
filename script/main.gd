extends Node2D
# 游戏主循环
# 将游戏的一切在此管理

@onready var status: Node = $status # 游戏全局变量
@onready var player: Node2D = $player
@onready var path_2d: Path2D = $Path2D # 更改路径资源
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var enemy: Node2D = $Path2D/PathFollow2D/enemy # 通过改变敌人纹理来选关
@onready var killzone: HurtboxComponent = $killzone

func _ready() -> void:
	player.tree_exited.connect(func():
		if enemy == null: # 不要动
			return
		else:
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://scene/game_over.tscn")
		)
	enemy.tree_exited.connect(func():
		if player == null:
			return
		else:
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://Levels/level_1.tscn")
		)

# 有多少关，最后一关连接到game_over
# 告诉player这是第几关，让其能力更新
