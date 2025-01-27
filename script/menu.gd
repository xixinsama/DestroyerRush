extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var h_box_container: HBoxContainer = $HBoxContainer

var text = "跳动的字幕"
var max_jump_height = 20  # 跳动的最大高度
var 	tween: Tween = create_tween().set_loops() ##无限循环

func _ready():
	var x_offset = 0
	for i in range(text.length()):
		var char = text[i]

		# 创建一个Label节点显示每个字母
		var label = Label.new()
		label.name = "jumping" + str(i)
		label.text = char
		label.position = Vector2(x_offset, 0)
		add_child(label)

		# 设置一个随机的跳动时间
		var jump_time = randf_range(0.3, 0.6)

		# 添加跳动动画
		tween.tween_property(label, "scale", Vector2(1.2, 1.2), jump_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(label, "position", label.position + Vector2(0, max_jump_height), jump_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(jump.bind(label))
		tween.tween_interval(0.5)

		x_offset += label.size.x + 5  # 字母之间的间隔

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skill") or Input.is_action_just_pressed("roll"):
		audio_stream_player.play()
		await audio_stream_player.finished
		get_tree().change_scene_to_file("res://Levels/level_0.tscn")
#点击空格开始

func jump(label: Label) -> void:
	var jump_time = randf_range(0.3, 0.6)
	var tween_label = create_tween()
	tween_label.tween_property(label, "scale", Vector2(1.2, 1.2), jump_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	tween_label.tween_property(label, "position", label.position + Vector2(0, max_jump_height), jump_time).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
