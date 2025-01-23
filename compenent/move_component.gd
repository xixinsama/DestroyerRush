## 进行节点移动的组件
class_name  MoveComponent
extends Node


@export var path_points: Curve2D = null ##绘制曲线，将节点按曲线轨迹移动
@export var is_following: bool = false ##是否跟随曲线运动，如果没有curve，则会修改成false 
@export var is_loop: bool = true ##按曲线移动是否循环，如果没有curve，则会修改成false 
@export var speed: int = 0 ##节点移动的速度
var distance_along_path: float = 0.0
signal finish_oneloop

@export var actor: Node2D
@export var velocity: Vector2
@export var roll_velocity: Vector2 = Vector2()
var sum_velocity: Vector2 
@export var roll_origin_rad_1:float = 0.0;##加入旋转的初始角度 旋转弹
var roll_origin_rad_2:float = 0.0;##加入旋转的初始角度 旋转追踪弹
@export var roll_vec_rad_1:float = -PI;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转弹
@export var roll_vec_rad_2:float = 0.0;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转追踪弹
@export var roll_r_1:float = 0.0;##旋转半径 旋转弹
var roll_r_2:float = 0.0;##旋转半径 旋转追踪弹
@export var speed_trail_1:float = 0.0;##追踪子弹速度 追踪弹
@export var speed_trail_2:float = 0.0;##追踪子弹速度 直线追踪弹

var roll_v:Vector2 #旋转弹
var trail_v:Vector2#追踪弹
var trail_stright_v:Vector2 #直线追踪弹
var roll_trail_v:Vector2 #旋转追踪弹
var trail_pos = Status.player_position ##追踪谁
@export var trail_who:int = 0


func _ready() -> void:
	# 判定节点状态
	actor.tree_exiting.connect(stop_process)
	if path_points == null:
		is_following = false
		is_loop == false
		#print(path_points.get_baked_points())
		#print(path_points.point_count)
		#print(path_points.get_point_position(3))
		#print(path_points.get_point_in(7))
		#print(path_points.get_point_out(3))
		#print(path_points.sample(2,0.5))
		
	if trail_who == 0:
		trail_pos = Status.player_position
	else:
		trail_pos = Status.enemy_position
	await get_tree().create_timer(0.1).timeout
	##代码 #直线追踪弹
	trail_stright_v =speed_trail_2*(trail_pos - actor.position).normalized();
	#roll_velocity =(Status.player_position - actor.position);
	##代码 #旋转追踪弹
	roll_r_2=(trail_pos - actor.position).length()/2;
	#print(roll_r)
	roll_origin_rad_2=(trail_pos - actor.position).angle()-PI;


func _process(delta):
	if is_following and actor != null:
		distance_along_path += speed * delta
		var path_length = path_points.get_baked_length()
		if distance_along_path > path_length:
			if is_loop:
				distance_along_path -= path_length
				emit_signal("finish_oneloop")
			else:
				distance_along_path = path_length ## 如果到达路径末端，停止移动
				
		var new_position = path_points.sample_baked(distance_along_path)
		# print(new_position)
		actor.global_position = new_position
		
##代码 旋转弹
	if trail_who == 0:
		trail_pos = Status.player_position
	else:
		trail_pos = Status.enemy_position
	roll_origin_rad_1=roll_vec_rad_1*delta+roll_origin_rad_1#当前旋转的角度
	roll_v=Vector2(roll_r_1*cos(roll_origin_rad_1)-roll_r_1*cos(roll_origin_rad_1-roll_vec_rad_1*delta),roll_r_1*sin(roll_origin_rad_1)-roll_r_1*sin(roll_origin_rad_1-roll_vec_rad_1*delta))#在当前旋转角度和和半径干扰下的位移向量
##代码 #追踪弹
	#Status.player_position;
	#actor.global_position;
	trail_v =speed_trail_1*(trail_pos - actor.global_position ).normalized()# + speed_trail_1*Vector2(randfn(0,1),randfn(0,1));
	
##代码 #旋转追踪弹
	roll_origin_rad_2=roll_vec_rad_2*delta+roll_origin_rad_2#当前旋转的角度
	roll_trail_v=Vector2(roll_r_2*cos(roll_origin_rad_2)-roll_r_2*cos(roll_origin_rad_2-roll_vec_rad_2*delta),roll_r_2*sin(roll_origin_rad_2)-roll_r_2*sin(roll_origin_rad_2-roll_vec_rad_2*delta))#在当前旋转角度和和半径干扰下的位移向量
##代码 向量求和
	sum_velocity = (velocity + roll_velocity) * delta + roll_v + trail_v * delta + trail_stright_v * delta + roll_trail_v #总位移向量
	actor.translate(sum_velocity)

# 停止每帧运动
func stop_process() -> void:
	set_process(false)
