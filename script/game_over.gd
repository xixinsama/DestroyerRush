extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skill"):
		get_tree().change_scene_to_file("res://scene/menu.tscn")
#点击空格结束
