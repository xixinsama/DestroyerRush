class_name Bullet 
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var move_component: MoveComponent = $MoveComponent
@onready var follow_path_component: FollowPathComponent = $FollowPathComponent

@export var frame : int = 0

@export var velocity: Vector2
@export var roll_velocity: Vector2 = Vector2()
@export var roll_origin_rad_1:float = 0.0;##加入旋转的初始角度 旋转弹
@export var roll_vec_rad_1:float = -PI;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转弹
@export var roll_vec_rad_2:float = 0.0;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转追踪弹
@export var roll_r_1:float = 0.0;##旋转半径 旋转弹
@export var speed_trail_1:float = 0.0;##追踪子弹速度 追踪弹
@export var speed_trail_2:float = 0.0;##追踪子弹速度 直线追踪弹

@export var path_points: Curve2D = null ##绘制曲线，将节点按曲线轨迹移动
@export var auto_start: bool = false ##是否自动开启（立即），建议使用方法start_follow()
@export var is_around: bool = false ##是否来回移动，周期为到终点后原路返回起点。若is_loop为false，则只来回一次。在终点会原路返回。
@export var is_loop: bool = true ##是否循环。若曲线未闭合，则会直接跳到起点。
@export var speed: int = 0 ##节点移动的速度

func _ready() -> void:
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	initialize()

func initialize(flag: int = 0) -> void:
	move_component.velocity = velocity
	move_component.roll_velocity = roll_velocity
	move_component.roll_vec_rad_2 = roll_vec_rad_2
	move_component.roll_r_1 = roll_r_1
	move_component.speed_trail_1 = speed_trail_1
	move_component.speed_trail_2 = speed_trail_2
	move_component.roll_origin_rad_1=roll_origin_rad_1
	
	sprite_2d.frame = frame
	
	follow_path_component.path_points = path_points
	follow_path_component.is_around = is_around
	follow_path_component.auto_start = auto_start
	follow_path_component.is_loop = is_loop
	follow_path_component.speed = speed
	animation_player.play("bullet" + String.num_int64(sprite_2d.frame + 1))
