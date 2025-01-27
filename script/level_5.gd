extends Node2D

# 三个阶段（25，50，75），每一阶段会放出另一个之前打过的BOSS，但是削弱过的版本
# 在放出之前的BOSS之后，不可索敌，停止移动，等杀死另一个BOSS之后恢复
# 召唤出的BOSS血量降低，只会一种弹幕攻击模式，移动方式随机
# 此BOSS每个阶段多增加一种弹幕，第三阶段就四种攻击模式，其中一种为全局攻击
# 这种全局攻击模式在随阶段增强（四种） timer_attack_1 大风车半径，750（尝试）
# 七种本身具有，三种召唤出的BOSS具有

@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var enemy_spawner_component: SpawnerComponent = $EnemySpawnerComponent

var jumping: bool = false
var flag_prase: int = 0
var timer_prase: Timer = null
var timer_attack_1: Timer = null
var timer_attack_2: Timer = null
var timer_attack_3: Timer = null
var timer_attack_4: Timer = null
func _ready() -> void:
	create_tween().tween_property(player, "global_position", Status.player_position, 0.3)
	player.tree_exited.connect(func():
		set_process(false)
		if jumping: return
		jumping = true
		await get_tree().create_timer(1.0).timeout
		var InventoryScene: PackedScene = preload("res://scene/game_over.tscn")
		Status.scene_into(InventoryScene)
		)
	enemy.tree_exited.connect(func():
		set_process(false)
		if jumping: return
		jumping = true
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
	timer_attack_1.wait_time = 12
	timer_attack_1.autostart = true
	timer_attack_1.one_shot = false
	timer_attack_1.timeout.connect(attack_1)
	##攻击2
	timer_attack_2 = Timer.new()
	add_child(timer_attack_2)
	timer_attack_2.start()	
	##关于计时器的初始话
	timer_attack_2.wait_time = 4
	timer_attack_2.autostart = true
	timer_attack_2.one_shot = false
	timer_attack_2.timeout.connect(attack_2)
	##攻击3
	timer_attack_3 = Timer.new()
	add_child(timer_attack_3)
	timer_attack_3.start()	
	##关于计时器的初始话
	timer_attack_3.wait_time = 20
	timer_attack_3.autostart = true
	timer_attack_3.one_shot = false
	timer_attack_3.timeout.connect(attack_3)
	##攻击4
	timer_attack_4 = Timer.new()
	add_child(timer_attack_4)
	timer_attack_4.start()	
	##关于计时器的初始话
	timer_attack_4.wait_time = 10
	timer_attack_4.autostart = true
	timer_attack_4.one_shot = false
	timer_attack_4.timeout.connect(attack_4)

func _process(_delta: float) -> void:
	# 开发者跳关
	if Input.is_action_just_pressed("creator_jump"):
		jumping = true
		get_tree().change_scene_to_file("res://Levels/level_3.tscn")

	




func prase_des():##阶段判断
	if enemy !=null:
		if enemy.get_node("StatsComponent").health < 3 * enemy.enemy_health_max / 4 and enemy.get_node("StatsComponent").health > enemy.enemy_health_max / 2 and flag_prase == 0:
			flag_prase = 1
			pass
		elif enemy.get_node("StatsComponent").health < enemy.enemy_health_max / 2 and  enemy.get_node("StatsComponent").health >  enemy.enemy_health_max / 4:
			flag_prase = 2
			pass
		elif enemy.get_node("StatsComponent").health <  enemy.enemy_health_max / 4 :
			flag_prase = 3
			pass

func attack_1():
	var bullet_left: Bullet = null
	var num: int = 8
	var brond_r:float = 700
	var time_ : float = 2.0
	var duan:int = 4
	var frame: int = 6
	print(1)
	if flag_prase == 0:
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.frame = frame
				bullet_left.initialize()
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
				
	elif  flag_prase == 1:
		duan = 6
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.frame = frame
				bullet_left.initialize()
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
		pass
	elif  flag_prase == 2:
		num = 15
		duan = 6
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.frame = frame
				bullet_left.initialize()
				bullet_left.life_timer.timeout.connect(roll_it.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
		pass
	elif  flag_prase == 3:
		num = 15
		duan = 6
		time_ = 1.0
		for j in range(0,duan):
			for i in range(0,num):
				bullet_left = spawner_component.spawn(Vector2(360,640),self,0)
				bullet_left.velocity =-(brond_r/time_ - i * (brond_r/time_)/num) * Vector2.from_angle(2*PI/duan*(1+j)) 
				bullet_left.frame = frame
				bullet_left.initialize()
				bullet_left.life_timer.timeout.connect(roll_it_1.bind(bullet_left))
				bullet_left.life_timer.wait_time = time_
				bullet_left.life_timer.one_shot = true
				bullet_left.life_timer.start()
	pass

func attack_2():
	var luo: Bullet = null
	var rad: float = PI/6 
	var num: int = 6##子弹数量
	var speed: int =500 ##子弹速度
	var frame_bullet = 13 ##子弹样式
	for i in range(0,num):
		if enemy != null:
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.velocity = speed * Vector2.from_angle((player.global_position - enemy.global_position).angle()  + rad)
			rad = rad - PI/((num) * 3)
			#speed = speed + 10
			luo.frame = frame_bullet
			#luo.wait_time = 2.0
			#luo.life_timer.timeout.connect(asign_value_1.bind(luo))
			#luo.life_timer.one_shot = false
			luo.initialize()
			await get_tree().create_timer(0.01).timeout
			#luo.life_timer.start()
	for i in range(0,num):
		if enemy != null:
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.velocity = speed * Vector2.from_angle((player.global_position - enemy.global_position).angle()  + rad)
			rad = rad + PI/((num) * 3)
			luo.frame = frame_bullet
			luo.initialize()
			await get_tree().create_timer(0.01).timeout
	for i in range(0,num):
		if enemy != null:
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.velocity = speed * Vector2.from_angle((player.global_position - enemy.global_position).angle()  + rad)
			rad = rad - PI/(num * 3)
			luo.frame = frame_bullet
			luo.initialize()
			await get_tree().create_timer(0.01).timeout
	pass

func roll_it(bullet:Bullet):
	var roll_v: float = PI/8
	bullet.roll_origin_rad_1 =  bullet.velocity.angle()
	bullet.velocity = Vector2(0,0)
	bullet.roll_r_1 = (bullet.global_position - Vector2(360,640)).length()
	bullet.roll_vec_rad_1 = roll_v
	bullet.initialize()
	bullet.life_timer.timeout.disconnect(roll_it)
	bullet.life_timer.wait_time = 10
	bullet.life_timer.start()
	bullet.life_timer.timeout.connect(clear.bind(bullet))
	
	
	pass
func roll_it_1(bullet:Bullet):
	var roll_v: float = PI/5
	bullet.roll_origin_rad_1 =  bullet.velocity.angle()
	bullet.velocity = Vector2(0,0)
	bullet.roll_r_1 = (bullet.global_position - Vector2(360,640)).length()
	bullet.roll_vec_rad_1 = roll_v
	bullet.initialize()
	bullet.life_timer.timeout.disconnect(roll_it)
	bullet.life_timer.wait_time = 10
	bullet.life_timer.start()
	bullet.life_timer.timeout.connect(clear.bind(bullet))
	
	pass

func attack_3():
	var luo: Bullet = null
	var rad: float = PI/6 
	var num: int = 20##子弹数量
	#var speed: int =500 ##子弹速度
	var frame_bullet = 7 ##子弹样式
	for i in range(0,num):
		if enemy != null:
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.frame = frame_bullet
			luo.initialize()
			luo.life_timer.wait_time = randi_range(0,1)+1
			luo.life_timer.timeout.connect(asign_value_1.bind(luo))
			luo.life_timer.one_shot = true
			luo.life_timer.start()
			await get_tree().create_timer(0.5).timeout
	pass
func asign_value_1(unfold: Bullet) -> void:
	var left_bullet: Bullet = null
	var right_bullet: Bullet = null
	if unfold != null:
		unfold.velocity = Vector2(0,300+randi_range(0,100))
		unfold.initialize()

func attack_4():
	var luo: Bullet = null
	var luo_1: Bullet = null
	var luo_2: Bullet = null
	var num: int = 10##子弹数量
	var speed: int =500 ##子弹速度
	var frame_bullet = 19 ##子弹样式
	var e_2_p: Vector2 = Vector2() 
	for i in range(0,num):
		if enemy != null:
			e_2_p = (player.global_position-enemy.global_position).normalized()
			luo = spawner_component.spawn(enemy.global_position,self,0)
			luo.velocity = speed * e_2_p
			luo.frame = frame_bullet
			luo.initialize()
			luo.move_component.is_bun = true
			
			e_2_p = (-enemy.global_position + Vector2(-player.global_position.x,player.global_position.y)).normalized()
			luo_1 = spawner_component.spawn(enemy.global_position,self,0)
			luo_1.velocity = speed * e_2_p
			luo_1.frame = frame_bullet
			luo_1.initialize()
			luo_1.move_component.is_bun = true
			
			e_2_p = (-enemy.global_position + Vector2(720*2-player.global_position.x,player.global_position.y)).normalized()
			luo_2 = spawner_component.spawn(enemy.global_position,self,0)
			luo_2.velocity = speed * e_2_p
			luo_2.frame = frame_bullet
			luo_2.initialize()
			luo_2.move_component.is_bun = true
			await get_tree().create_timer(0.1).timeout
	pass


func clear(bullet:Bullet):
	bullet.queue_free()
	pass
