extends Node2D
# 游戏主循环
# 将游戏的一切在此管理

@onready var status: Node = $status # 游戏全局变量
@onready var path_2d: Path2D = $Path2D # 更改路径资源
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var killzone: HurtboxComponent = $killzone
@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy

@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var move_component: MoveComponent = $MoveComponent

@onready var bomm_sprite_2d: AnimatedSprite2D = $enemy/bommSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var time_all: Timer = null
var timer_2: Timer = null
var timer: Timer = null
var timer_prase: Timer = null

var shotgun_flag: int = 0 #散弹数量标记
## signal signal_prase_flag
var prase_flag = 0


func _ready() -> void:
	
		##关于计时器
	timer = Timer.new()
	timer_2 = Timer.new()
	time_all = Timer.new()
	timer_prase = Timer.new()
	add_child(timer)
	add_child(timer_2)
	add_child(time_all)
	add_child(timer_prase)
	time_all.start()
	timer.start()
	timer_prase.start()
	
	##关于计时器的初始话
	time_all.wait_time = 0.2
	timer.wait_time = 1
	timer_2.wait_time = 3.0
	timer_prase.wait_time = 1
	
	timer.autostart = true
	timer_2.autostart = true
	time_all.autostart = true
	timer_prase.autostart = true
	
	timer.one_shot = false
	timer_2.one_shot = true
	time_all.one_shot = false
	timer_prase.one_shot = false
	
	##将不同的计时,带入不同的函数
	time_all.timeout.connect(luoruixin_time_all)
	timer.timeout.connect(luoruixin)
	timer_2.timeout.connect(son_luoruixin)
	timer_prase.timeout.connect(prase_des)
	
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
			
			var InventoryScene: PackedScene = preload("res://Levels/level_1.tscn")
			Transitions.change_scene_to_instance(InventoryScene.instantiate(), 
			Transitions.FadeType.CrossFade)
			
			#FancyFade.swirl(InventoryScene.instantiate())
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func luoruixin_time_all() :
	var flag:int =3#randi_range(3,4)#randi_range(0,5) + prase_flag
	#var flag:int = 8#randi_range(0,7)
	#var flag_i: int = randf_range(8,18)
	var luo: Bullet = null
	if flag == 3:
		var num: int = 45 ##子弹数量
		var speed: int = 375 ##子弹速度
		var frame_bullet =3 ##子弹样式
		for i in range(0,num/2):
			luo = spawner_component.spawn(Vector2( round(i * 720.0 / num)  , 300  ),self,0)
			luo.frame = frame_bullet
			luo.velocity = Vector2(0,speed)
			luo.roll_origin_rad_1 = -PI/2
			luo.roll_r_1=100
			luo.initialize()
		for i in range(0,num/2):
			luo = spawner_component.spawn(Vector2(720 - round(i * 720.0 / num)  , 300  ),self,0)
			#print(round(i * 720.0 / num))
			luo.frame = frame_bullet
			luo.velocity = Vector2(0,speed)
			luo.roll_vec_rad_1 = PI
			luo.roll_origin_rad_1 = -PI/2
			luo.roll_r_1=100
			luo.initialize()
			#print(Vector2( 30+ i * round(720 / num) +randi_range(-20,20) , 200 + randi_range(-50,50) ))
			
			#
	#if flag == 3:
		#var num: int = 45 ##子弹数量
		#var speed: int = 700 ##子弹速度
		#var frame_bullet = 5 ##子弹样式
		#for i in range(0,num):
			#luo = spawner_component.spawn(Vector2(30 ,  250 + round(i *  (1080-250) / num)   ),self,0)
			#luo.frame = frame_bullet
			#luo.velocity = Vector2(speed,0)
			#luo.roll_r_1=10
			#luo.initialize()
		#for i in range(0,num):
			#luo = spawner_component.spawn(Vector2(720 - 30 , 250 + round(i * (1080-250) / num)  ),self,0)
			#luo.frame = frame_bullet
			#luo.velocity = Vector2(-speed,0)
			#luo.roll_r_1=10
			#luo.initialize()
			


	if flag == 7:
		var rad: float = 0
		var num: int = 100##子弹数量
		var speed: int = 150 ##子弹速度
		var frame_bullet = flag+5 ##子弹样式
		for i in range(0,num):
			luo = spawner_component.spawn(Status.enemy_position,self,0)
			luo.velocity = speed * Vector2(1,0).from_angle(rad)
			rad = rad + PI/(num-1)
			speed = speed + 10
			luo.frame = frame_bullet

	if flag == 8:##霰弹尝试
		var num: int = 15##子弹数量
		var speed: int = 300 ##子弹速度
		var rad: float = 0
		var frame_bullet = flag+5 ##子弹样式
		
		for i in range(0,num):
			luo = spawner_component.spawn(Status.enemy_position,self,0)
			luo.name = "luorui" + String.num_int64(shotgun_flag)
			shotgun_flag += 1
			luo.velocity = speed * Vector2(1,0).from_angle(rad)
			luo.frame = frame_bullet
			rad = rad + PI/(num-1)
			luo.initialize()
			timer_2.start()

func luoruixin():

	var num: int = 20 ##子弹数量
	var speed: int = randi_range(190,210) ##子弹速度
	var frame_bullet = 20 ##子弹样式
	var random_h: int = randi_range(-50,50)
	var luo: Bullet = null
	var luo_1: Bullet = null
	for i in range(0,num):
		luo = spawner_component.spawn(Vector2(round(i * 280 / num) , 200 ),self,0)
		luo.velocity = Vector2(speed,0)
		luo.speed_trail_2 = 500
		luo.speed_trail_1 = 500
		luo.roll_r_1 = 3
		luo.roll_origin_rad_1 = PI/2
		luo.frame = frame_bullet
		luo.initialize()
		luo_1 = spawner_component.spawn(Vector2(round(720 - 280 +(num- i) * 280 / num) , 200 ),self,0)
		luo_1.velocity = Vector2(-speed,0)
		luo_1.speed_trail_2 = 500
		luo_1.speed_trail_1 = 500
		luo_1.roll_r_1 = 3
		luo_1.roll_origin_rad_1 = PI/2
		luo_1.frame = frame_bullet
		luo_1.initialize()
		await get_tree().create_timer(0.05).timeout
		#await get_tree().create_timer(0.05).timeout
	#var num: int = 45 ##子弹数量
	#var speed: int = -randi_range(15,18) ##子弹速度
	#var frame_bullet = flag+5 ##子弹样式
	#var random_h: int = randi_range(-50,50)
	#num= 45 ##子弹数量
	#speed= -randi_range(15,18) ##子弹速度
	#frame_bullet = 8 ##子弹样式
	#random_h= randi_range(-50,50)
	#for i in range(0,num):
		#luo_1 = spawner_component.spawn(Vector2(round(720 - 280 + i * 280 / num) , 200 ),self,0)
		#luo_1.velocity = Vector2(speed,0)
		#luo_1.speed_trail_2 = 300
		#luo_1.roll_r_1 = 5
		#luo_1.roll_origin_rad_1 = PI/2
		#luo_1.frame = frame_bullet
		#luo_1.initialize()
		#await get_tree().create_timer(0.05).timeout
		##return
	
func son_luoruixin():
	var luo: Bullet
	for i in range(0,10):
		luo=get_node("luorui"+String.num_int64(shotgun_flag - i) );
		if luo != null:
			var bullet_luo_son1 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son1.velocity = Vector2(-50,-50)
			bullet_luo_son1.frame = 12
			var bullet_luo_son2 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son2.velocity = Vector2(0,-50)
			bullet_luo_son2.frame = 12
			var bullet_luo_son3 : Bullet = spawner_component.spawn(luo.global_position,self,0)
			bullet_luo_son3.velocity = Vector2(50,-50)
			bullet_luo_son3.frame = 12
			luo.queue_free()
			
			
func prase_des():
	#if enemy !=null:
		#if enemy.get_node("StatsComponent").health < enemy.enemy_health_max / 2 :
			#prase_flag = 4
			#time_all.wait_time = 2
			#bomm_sprite_2d.play("boom")
			#animation_player.play("big_small")
	pass
		#else : ##如果有血量恢复添加代码
			#prase_flag = 0
			#time_all.wait_time = 2
