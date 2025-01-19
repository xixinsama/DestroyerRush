## 进行节点移动的组件
class_name  MoveComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2
@export var roll_velocity: Vector2 = Vector2()
@export var flag_cha:int = 1
var sum_velocity: Vector2 
@export var roll_origin_rad:float = 0.0;##加入旋转的初始角度
@export var roll_r:float = 1.0;##旋转半径
#@export var roll_p:Vector2 = ;位置向量暂时未加入，初始位置的设置在spawn相关设置，和位移无关
func _ready() -> void:
	pass

func _process(delta):
	if flag_cha == 1:
		var roll_velocity_r : Vector2 = Vector2();#旋转的初始向量
		roll_origin_rad=3.1415926*delta+roll_origin_rad#当前旋转的角度
		#print(roll_origin_rad)#测试代码
		roll_velocity_r=Vector2(roll_r*cos(roll_origin_rad),roll_r*sin(roll_origin_rad))#在当前旋转角度和和半径干扰下的位移向量
		sum_velocity = velocity +roll_velocity#原本的速度向量
		actor.translate(sum_velocity * delta+roll_velocity_r)#总位移
	if flag_cha !=1:
		sum_velocity = velocity +roll_velocity
		actor.translate(sum_velocity * delta)
