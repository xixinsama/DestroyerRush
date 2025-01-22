extends Node2D
var time_all: Timer = null
var timer_2: Timer = null
var timer: Timer = null
@onready var spawner_component: SpawnerComponent = $SpawnerComponent



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
	timer_2.wait_time = 1.0
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
	var flag:int = randi_range(0,5)
	var flag_i: int = randf_range(8,18)
	var luo: Bullet = null
	if flag == 0:
		for i in range(0,flag_i):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / flag_i) , 200 ),self,0)
			luo.velocity = Vector2(0,150)
	if flag == 1:
		for i in range(0,flag_i):
			await get_tree().create_timer(0.1).timeout
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / flag_i) , 200 ),self,0)
			luo.velocity = Vector2(0,150)
	if flag == 2:
		for i in range(0,flag_i):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / flag_i) , 200 ),self,0)
			luo.velocity = Vector2(0,150 + 10 * i)
	if flag == 3:
		for i in range(0,flag_i):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / flag_i) + 50 , 200 ),self,0)
			luo.velocity = Vector2(0,150)
			luo.roll_r_1 = 50
	if flag == 4:
		for i in range(0,flag_i):
			luo = spawner_component.spawn(Vector2(30 + i * round(720 / flag_i) , 200 ),self,0)
			luo.velocity = Vector2(0,150)
			if randi_range( 0 , 10 ) > 8:
				luo.queue_free()
	if flag == 5:
		var luo_roll_trail_right: Bullet = null
		var luo_roll_trail_left: Bullet = null
		luo_roll_trail_right = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_right.roll_vec_rad_2 = PI/3
		luo_roll_trail_left = spawner_component.spawn(Status.enemy_position,self,0)
		luo_roll_trail_left.roll_vec_rad_2 = -PI/3
		await get_tree().create_timer(3).timeout
		luo_roll_trail_right.queue_free()
		luo_roll_trail_left.queue_free()
	pass
	

func luoruixin() :
	var luo: Bullet
	var i: int = 1
	luo = spawner_component.spawn(Vector2(160,900),self,0)
	luo.name = "luorui" + String.num_int64(i)
	luo.velocity = Vector2(50,0)
	timer_2.start()

func son_luoruixin():
	var luo: Bullet
	luo=get_node("luorui1");
	var bullet_luo_son1 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	bullet_luo_son1.velocity = Vector2(-50,-50)
	var bullet_luo_son2 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	bullet_luo_son2.velocity = Vector2(0,-50)
	var bullet_luo_son3 : Bullet = spawner_component.spawn(luo.global_position,self,0)
	bullet_luo_son3.velocity = Vector2(50,-50)
	luo.queue_free()
