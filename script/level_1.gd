extends Node2D


@onready var player: Node2D = $player
@onready var enemy: Node2D = $enemy
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var path_2d: Path2D = $Path2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
