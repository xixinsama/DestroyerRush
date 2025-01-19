extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))

func initialize(flag: int) -> void:
	pass
