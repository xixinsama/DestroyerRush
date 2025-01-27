extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skill") or Input.is_action_just_pressed("roll"):
		audio_stream_player.play()
		await audio_stream_player.finished
		var InventoryScene: PackedScene = preload("res://Levels/level_2.tscn")
		Transitions.change_scene_to_instance(InventoryScene.instantiate(), 
		Transitions.FadeType.CrossFade)
#点击空格开始
