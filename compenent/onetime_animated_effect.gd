class_name OnetimeAnimatedEffect
extends AnimatedSprite2D


func _ready() -> void:
	# 当动画播放结束，Free节点
	animation_finished.connect(queue_free)
	# 可以在动画中设置循环，也可使用脚本修改，如下：
	# animation_looped.connect(queue_free)

# 设置要播放的动画
func initialize(flag: int = 0) -> void:
	if flag == 0:
		play("explosion_white")
	elif flag == 1:
		play("explosion_purple")
	elif flag == 2:
		play("explosion_red")
	elif flag == 3:
		play("explosion_blue")
	else:
		return
