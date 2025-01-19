## 进行节点移动的组件
class_name  MoveComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2
@export var roll_velocity: Vector2 = Vector2()
var sum_velocity: Vector2 

func _ready() -> void:
	pass

func _process(delta):
	sum_velocity = velocity + roll_velocity
	actor.translate(sum_velocity * delta)
