class_name Bullet 
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var move_component: MoveComponent = $MoveComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var velocity: Vector2
@export var roll_velocity: Vector2 = Vector2()
@export var roll_origin_rad_1:float = 0.0;##加入旋转的初始角度 旋转弹
@export var roll_vec_rad_1:float = -PI;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转弹
@export var roll_vec_rad_2:float = 0.0;##加入旋转的角度速度,正是顺时针，负是逆时针 旋转追踪弹
@export var roll_r_1:float = 0.0;##旋转半径 旋转弹
@export var speed_trail_1:float = 0.0;##追踪子弹速度 追踪弹
@export var speed_trail_2:float = 0.0;##追踪子弹速度 直线追踪弹

@export var frame : int = 0

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	move_component.velocity = velocity
	move_component.roll_velocity = roll_velocity
	move_component.roll_vec_rad_2 = roll_vec_rad_2
	move_component.roll_r_1 = roll_r_1
	move_component.speed_trail_1 = speed_trail_1
	move_component.speed_trail_2 = speed_trail_2
	move_component.roll_origin_rad_1=roll_origin_rad_1
	sprite_2d.frame = frame
	for i in range(0,30):
		if frame == i :
			animation_player.play("bullet" + String.num_int64(i + 1))
			print(i)
func initialize(_flag: int) -> void:
	#move_component.velocity = velocity
	pass
