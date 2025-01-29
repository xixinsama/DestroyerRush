extends State
class_name Attack1

@export var enemy: Enemy
@export var spawner_component: SpawnerComponent

# 下落拉屎
func Enter():
	var luo: Bullet = null
	var num: int = 5 ##子弹数量
	var frame_bullet = 22 ##子弹样式
	for i in range(0,num):
		if enemy != null:
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.frame = frame_bullet
			luo.initialize()
			luo.life_timer.wait_time = randf_range(0, 0.7)+1
			luo.life_timer.timeout.connect(asign_value_1.bind(luo))
			luo.life_timer.one_shot = true
			luo.life_timer.start()
			await get_tree().create_timer(0.3).timeout
	
	Transitioned.emit(self, "EnemyIdle")


func asign_value_1(unfold: Bullet) -> void:
	var left_bullet: Bullet = null
	var right_bullet: Bullet = null
	if unfold != null:
		unfold.velocity = Vector2(0, 300 + randi_range(0,100))
		unfold.initialize()
