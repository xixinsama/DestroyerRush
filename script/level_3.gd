extends Node2D


@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var dot_matrix_file = "res://asset/dot_matrix_info.txt"
var dot_positions = []
var speed: int = 100  # 下落速度
var current_frame: int = 1
#func _ready():
	## 读取点阵信息文件
	#var file = FileAccess.open(dot_matrix_file, FileAccess.READ)
	#if file:
		#var frame_index = 0
		#while not file.eof_reached():
			#var line = file.get_line()
			#if line.begins_with("Frame"):
				#frame_index = int(line.replace("Frame ", ""))
			#elif line != "":
				#var data = line.split(": ")
				#var position = data[0].replace("(", "").replace(")", "").split(", ")
				#var x = int(position[0])
				#var y = int(position[1])
				#var alpha = int(data[1])
				#dot_positions.append({"x": x, "y": y, "alpha": alpha, "frame": frame_index})
		#file.close()
#
	## 生成弹幕
	#for dot in dot_positions:
		#var bullet_position: Vector2 = Vector2(dot["x"]*8, -dot["y"]*8)
		#var bullet_hint: Bullet = spawner_component.spawn(bullet_position, self, 0)
		#bullet_hint.modulate.a = dot["alpha"] / 255.0
		#bullet_hint.frame = 0
		#bullet_hint.velocity = Vector2(0, 100)
		#bullet_hint.initialize()

func _ready():
	# 读取点阵信息文件
	var file = FileAccess.open(dot_matrix_file, FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			if line.begins_with("Frame"):
				current_frame = int(line.replace("Frame ", ""))
				dot_positions.append([])
			elif line != "":
				var data = line.split(": ")
				var position = data[0].replace("(", "").replace(")", "").split(", ")
				var x = int(position[0])
				var y = int(position[1])
				var rgba = data[1].split(" ")
				var r = int(rgba[0])
				var g = int(rgba[1])
				var b = int(rgba[2])
				var a = int(rgba[3])
				dot_positions[-1].append({"x": x, "y": y, "color": Color(r / 255.0, g / 255.0, b / 255.0, a / 255.0)})
		file.close()
	# 播放计时
	var play_gif: Timer = Timer.new()
	add_child(play_gif)
	play_gif.wait_time = 2.0
	play_gif.timeout.connect(play_gif_frame)
	play_gif.start()
	current_frame = 0

# 按帧生成
func play_gif_frame() -> void:
	if current_frame < len(dot_positions):
		for dot in dot_positions[current_frame]:
			spawn_bullet(dot)
		current_frame += 1

# 生成弹幕
func spawn_bullet(dot):
	var bullet_position: Vector2 = Vector2(480-dot["x"] * 8, dot["y"] * 8)
	var bullet_hint: Bullet = spawner_component.spawn(bullet_position, self, 0)
	bullet_hint.modulate = dot["color"]
	bullet_hint.velocity = Vector2(0, 200)
	bullet_hint.initialize()
