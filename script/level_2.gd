extends Node2D

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var time_all: Timer = null
var timer_2: Timer = null
var timer: Timer = null
var shotgun_flag: int = 0 #散弹数量标记

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	##关于计时器
	timer = Timer.new()
	timer_2 = Timer.new()
	time_all = Timer.new()
	add_child(timer)
	add_child(timer_2)
	add_child(time_all)
	time_all.start()
	
	##关于计时器的初始话
	time_all.wait_time = 5.0
	timer.wait_time = 3.0
	timer_2.wait_time = 2.0
	timer.autostart = true
	timer_2.autostart = true
	time_all.autostart = true
	timer.one_shot = true
	timer_2.one_shot = true
	time_all.one_shot = false
	
	##将不同的计时,带入不同的函数
	time_all.timeout.connect(luoruixin_time_all)
	timer.timeout.connect(luoruixin)
	timer_2.timeout.connect(son_luoruixin)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func luoruixin_time_all() :
	var flag:int = randi_range(0,8)
	#var flag:int = 8#randi_range(0,7)
	#var flag_i: int = randf_range(8,18)
	var luo: Bullet = null
	if flag == 0:
		var num: int = 10 ##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / num) , 200 ),self,0)
			luo.velocity = Vector2(0,150)
	if flag == 1:
		var num: int = 10 ##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / num) , 200 ),self,0)
			luo.velocity = Vector2(0,speed)
	if flag == 2:
		var num: int = 10 ##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / num) , 200 ),self,0)
			luo.velocity = Vector2(0,speed + 10 * i)
	if flag == 3:
		var num: int = 10 ##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / num) , 200 ),self,0)
			luo.velocity = Vector2(0,speed)
			luo.roll_r_1 = 50
	if flag == 4:
		var num: int = 10 ##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / num) , 200 ),self,0)
			luo.velocity = Vector2(0,speed)
			if randi_range( 0 , 10 ) > 8:
				luo.queue_free()
	if flag == 5:##圆型子弹需要控制删除，因为他们不和边界接触
		var luo_roll_trail_right: Bullet = null
		var luo_roll_trail_left: Bullet = null
		luo_roll_trail_right = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right.roll_vec_rad_2 = PI/3
		luo_roll_trail_left = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(3).timeout
		
		if luo_roll_trail_right!=null:
				luo_roll_trail_right.queue_free()
		if luo_roll_trail_left!=null:
			luo_roll_trail_left.queue_free()
	if flag == 6:
		#for i in range(0,5):
		var luo_roll_trail_right: Bullet = null
		var luo_roll_trail_left: Bullet = null
		var luo_roll_trail_right_1: Bullet = null
		var luo_roll_trail_left_1: Bullet = null
		var luo_roll_trail_right_2: Bullet = null
		var luo_roll_trail_left_2: Bullet = null
		var luo_roll_trail_right_3: Bullet = null
		var luo_roll_trail_left_3: Bullet = null
		var luo_roll_trail_right_4: Bullet = null
		var luo_roll_trail_left_4: Bullet = null
		##生成节点
		await get_tree().create_timer(0.1).timeout
		luo_roll_trail_right = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right.roll_vec_rad_2 = PI/3
		luo_roll_trail_left = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(0.1).timeout
		luo_roll_trail_right_1 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right_1.roll_vec_rad_2 = PI/3
		luo_roll_trail_left_1 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left_1.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(0.1).timeout
		luo_roll_trail_right_2 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right_2.roll_vec_rad_2 = PI/3
		luo_roll_trail_left_2 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left_2.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(0.1).timeout
		luo_roll_trail_right_3 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right_3.roll_vec_rad_2 = PI/3
		luo_roll_trail_left_3 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left_3.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(0.1).timeout
		luo_roll_trail_right_4 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right_4.roll_vec_rad_2 = PI/3
		luo_roll_trail_left_4 = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left_4.roll_vec_rad_2 = -PI/3
		
		
		##删除节点
		await get_tree().create_timer(2.5).timeout
		if luo_roll_trail_right!=null:
			luo_roll_trail_right.queue_free()
		if luo_roll_trail_left!=null:
			luo_roll_trail_left.queue_free()
		await get_tree().create_timer(0.1).timeout
		if luo_roll_trail_right_1!=null:
			luo_roll_trail_right_1.queue_free()
		if luo_roll_trail_left_1!=null:
			luo_roll_trail_left_1.queue_free()
		await get_tree().create_timer(0.1).timeout
		if luo_roll_trail_right_2!=null:
			luo_roll_trail_right_2.queue_free()
		if luo_roll_trail_left_2!=null:
			luo_roll_trail_left_2.queue_free()
		await get_tree().create_timer(0.1).timeout
		if luo_roll_trail_right_3!=null:
			luo_roll_trail_right_3.queue_free()
		if luo_roll_trail_left_3!=null:
			luo_roll_trail_left_3.queue_free()
		await get_tree().create_timer(0.1).timeout
		if luo_roll_trail_right_4!=null:
			luo_roll_trail_right_4.queue_free()
		if luo_roll_trail_left_4!=null:
			luo_roll_trail_left_4.queue_free()
	if flag == 7:
		var rad: float = 0
		var num: int = 10##子弹数量
		var speed: int = 150 ##子弹速度
		for i in range(0,num):
			luo = spawner_component.spawn(Status.enemy_position,self,0)
			luo.velocity = speed * Vector2(1,0).from_angle(rad)
			rad = rad + PI/(num-1)
	if flag == 8:##霰弹尝试
		var num: int = 10##子弹数量
		var speed: int = 300 ##子弹速度
		var rad: float = 0
		for i in range(0,num):
			luo = spawner_component.spawn(Status.enemy_position,self,0)
			luo.name = "luorui" + String.num_int64(shotgun_flag)
			shotgun_flag += 1
			luo.velocity = speed * Vector2(1,0).from_angle(rad)
			rad = rad + PI/(num-1)
			timer_2.start()

	
	
	
	
	

func luoruixin() :
	#var luo: Bullet
	#var i: int = 1
	#luo = spawner_component.spawn(Vector2(160,900),self,0)
	#luo.name = "luorui" + String.num_int64(shotgun_flag)
	#shotgun_flag += 1
	#luo.velocity = Vector2(50,0)
	#timer_2.start()
	pass

func son_luoruixin():
	var luo: Bullet
	for i in range(0,10):
		luo=get_node("luorui"+String.num_int64(shotgun_flag - i) );
		if luo != null:
			var bullet_luo_son1 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son1.velocity = Vector2(-50,-50)
			var bullet_luo_son2 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son2.velocity = Vector2(0,-50)
			var bullet_luo_son3 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son3.velocity = Vector2(50,-50)
	#luo=get_node("luorui1");
	#var bullet_luo_son1 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	#bullet_luo_son1.velocity = Vector2(-50,-50)
	#var bullet_luo_son2 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	#bullet_luo_son2.velocity = Vector2(0,-50)
	#var bullet_luo_son3 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	#bullet_luo_son3.velocity = Vector2(50,-50)s
			luo.queue_free()
