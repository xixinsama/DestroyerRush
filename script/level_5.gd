extends Node2D
@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy
@onready var spawner_component: SpawnerComponent = $SpawnerComponent


# 三个阶段（25，50，75），每一阶段会放出另一个之前打过的BOSS，但是削弱过的版本
# 在放出之前的BOSS之后，不可索敌，停止移动，等杀死另一个BOSS之后恢复
# 召唤出的BOSS血量降低，只会一种弹幕攻击模式，移动方式随机
# 此BOSS每个阶段多增加一种弹幕，第三阶段就四种攻击模式，其中一种为全局攻击
# 这种全局攻击模式在随阶段增强（四种） timer_attack_1 大风车半径，750（尝试）
# 七种本身具有，三种召唤出的BOSS具有
var flag_prase: int = 0
var timer_prase: Timer = null
var timer_attack_1: Timer = null
func _ready() -> void:
	create_tween().tween_property(player, "global_position", Status.player_position, 0.3)
	player.tree_exited.connect(func():
		if enemy == null: # 不要动
			return
		else:
			await get_tree().create_timer(1.0).timeout
			var InventoryScene: PackedScene = preload("res://scene/game_over.tscn")
			Status.scene_into(InventoryScene)
		)
	enemy.tree_exited.connect(func():
		if player == null:
			return
		else:
			await get_tree().create_timer(1.0).timeout
			var InventoryScene: PackedScene = preload("res://Levels/level_3.tscn")
			Status.scene_into(InventoryScene)
		)
		
		

	##关于计时器
	#每秒判断一次阶段改变
	timer_prase = Timer.new()
	add_child(timer_prase)
	timer_prase.start()	
	##关于计时器的初始话
	timer_prase.wait_time = 1
	timer_prase.autostart = true
	timer_prase.one_shot = false
	timer_prase.timeout.connect(prase_des)
	##攻击1
	timer_attack_1 = Timer.new()
	add_child(timer_attack_1)
	timer_attack_1.start()	
	##关于计时器的初始话
	timer_attack_1.wait_time = 4
	timer_attack_1.autostart = true
	timer_attack_1.one_shot = false
	timer_attack_1.timeout.connect(attack_1)
	
	

func prase_des():##阶段判断
	if enemy !=null:
		if enemy.get_node("StatsComponent").health < 3 * enemy.enemy_health_max / 4 and enemy.get_node("StatsComponent").health > enemy.enemy_health_max / 2 :
			flag_prase = 1
			pass
			#prase_flag = 4
			#time_all.wait_time = 2
			#bomm_sprite_2d.play("boom")
			#animation_player.play("big_small")
		elif enemy.get_node("StatsComponent").health < enemy.enemy_health_max / 2 and  enemy.get_node("StatsComponent").health >  enemy.enemy_health_max / 4:
			flag_prase = 2
			pass
		elif enemy.get_node("StatsComponent").health <  enemy.enemy_health_max / 4 :
			flag_prase = 3
			pass

func attack_1():
	var bullet_left: Bullet = null
	var num: int = 6
	var brond_r:float = 700
	var time_ : float = 2.0
	var duan:int = 4
	var frame: int = 6
	if flag_prase == 0:
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.frame = frame
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
				bullet_left.initialize()
	elif  flag_prase == 1:
		duan = 6
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.frame = frame
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
				bullet_left.initialize()
		pass
	elif  flag_prase == 2:
		num = 15
		duan = 6
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.frame = frame
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
				bullet_left.initialize()
		pass
	elif  flag_prase == 3:
		num = 15
		duan = 6
		time_ = 1.0
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.life_timer.timeout.connect(roll_it_1.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.frame = frame
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
				bullet_left.initialize()
	pass

func roll_it(bullet:Bullet):
	var roll_v: float = PI/2
	bullet.roll_origin_rad_1 =  bullet.velocity.angle()
	bullet.velocity = Vector2(0,0)
	bullet.roll_r_1 = (bullet.global_position - Vector2(360,640)).length()
	bullet.roll_vec_rad_1 = roll_v
	bullet.life_timer.timeout.disconnect(roll_it)
	bullet.life_timer.timeout.connect(clear.bind(bullet))
	bullet.initialize()
	pass
func roll_it_1(bullet:Bullet):
	var roll_v: float = PI
	bullet.roll_origin_rad_1 =  bullet.velocity.angle()
	bullet.velocity = Vector2(0,0)
	bullet.roll_r_1 = (bullet.global_position - Vector2(360,640)).length()
	bullet.roll_vec_rad_1 = roll_v
	bullet.life_timer.timeout.disconnect(roll_it)
	bullet.life_timer.timeout.connect(clear.bind(bullet))
	bullet.initialize()
	pass

func clear(bullet:Bullet):
	bullet.queue_free()
	pass
