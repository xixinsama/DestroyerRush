## 进行节点移动的组件
class_name  MoveComponent
extends Node


@export var actor: Node2D ## 移动控制的目标对象
@export var velocity: Vector2 #依赖包含：玩家移动
var roll_velocity: Vector2 = Vector2() ## 这个变量给player翻滚用的
#@export var flag_cha: TYPE = 0##默认的选择类型为0，即飞机的移动，其中1为玩家子弹，2为旋转弹
var sum_velocity: Vector2 
@export var roll_origin_rad:float = 0.0;##加入旋转的初始角度
@export var roll_vec_rad:float = -PI;##加入旋转的角度速度,正是顺时针，负是逆时针
@export var roll_r:float = 50.0;##旋转半径
@export var speed_trail:float = 50;##追踪子弹速度

#enum TYPE
#{
	#NULL,
	#ROLL,
	#SPAN,
	#ROLL_SPAN
#}

#@export var roll_p:Vector2 = ;位置向量暂时未加入，初始位置的设置在spawn相关设置，和位移无关
func _ready() -> void:
	#await get_tree().create_timer(0.1).timeout
	#if flag_cha==4:
		#roll_velocity =speed_trail*(Status.player_position - actor.position).normalized();
	#if flag_cha==5:
		##roll_velocity =(Status.player_position - actor.position);
		#roll_r=(Status.player_position - actor.position).length()/2;
		##print(roll_r)
		#roll_origin_rad=(Status.player_position - actor.position).angle()-PI;
	pass

func _process(delta):
	#if flag_cha == 2:#旋转弹
		#roll_origin_rad=roll_vec_rad*delta+roll_origin_rad#当前旋转的角度
		##print(roll_origin_rad)#测试代码
		#roll_velocity=Vector2(roll_r*cos(roll_origin_rad)-roll_r*cos(roll_origin_rad-roll_vec_rad*delta),roll_r*sin(roll_origin_rad)-roll_r*sin(roll_origin_rad-roll_vec_rad*delta))#在当前旋转角度和和半径干扰下的位移向量
		#sum_velocity = velocity #原本的速度向量
		#actor.translate(sum_velocity * delta+roll_velocity)#总位移
	#if flag_cha==3:#追踪弹
		##Status.player_position;
		##actor.global_position;
		#roll_velocity =speed_trail*(Status.player_position - actor.global_position).normalized();
		#sum_velocity = (velocity +roll_velocity)
		#actor.translate(sum_velocity * delta)
	#if flag_cha==4:#直线追踪弹
		##Status.player_position;
		##actor.global_position;
		#sum_velocity = (velocity +roll_velocity)
		#actor.translate(sum_velocity * delta)
	#if flag_cha == 5:#旋转追踪弹
		#roll_origin_rad=roll_vec_rad*delta+roll_origin_rad#当前旋转的角度
		##print(roll_origin_rad)#测试代码
		#roll_velocity=Vector2(roll_r*cos(roll_origin_rad)-roll_r*cos(roll_origin_rad-roll_vec_rad*delta),roll_r*sin(roll_origin_rad)-roll_r*sin(roll_origin_rad-roll_vec_rad*delta))#在当前旋转角度和和半径干扰下的位移向量
		#sum_velocity = velocity #原本的速度向量
		#actor.translate(sum_velocity * delta+roll_velocity)#总位移
	#if flag_cha == 6:
		#rs = roll_v + span_v
	# 判断里对向量计算完成
	sum_velocity = velocity + roll_velocity
	actor.translate(sum_velocity * delta)
