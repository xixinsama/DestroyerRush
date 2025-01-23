## 控制节点按照路径移动
class_name FollowPathComponent
extends Node

@export var actor: Node2D
@export var path_points: Curve2D = null ##绘制曲线，将节点按曲线轨迹移动
@export var is_around: bool = false ##是否来回移动，周期为到终点后原路返回起点。若is_loop为false，则只来回一次。在终点会原路返回。如果没有curve，则会修改成false 
@export var is_loop: bool = true ##是否循环。若曲线未闭合，则会直接跳到起点。如果没有curve，则会修改成false 
@export var speed: int = 0 ##节点移动的速度

var distance_along_path: float = 0.0
signal finish_oneloop ##循环结束后发送信号

func _ready() -> void:
	actor.tree_exiting.connect(stop_process)
	if path_points == null:
		is_around = false
		is_loop == false


func _process(delta: float) -> void:
	pass

# 停止运动
func stop_process() -> void:
	set_process(false)
