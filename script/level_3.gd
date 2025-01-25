extends Node2D


@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var dot_matrix_file = "res://asset/dot_matrix_info.txt"
var dot_positions = []
var speed = 100  # 下落速度

func _ready():
	# 读取点阵信息文件
	var file = FileAccess.open(dot_matrix_file, FileAccess.READ)
	if file:
		var frame_index = 0
		while not file.eof_reached():
			var line = file.get_line()
			if line.begins_with("Frame"):
				frame_index = int(line.replace("Frame ", ""))
			elif line != "":
				var data = line.split(": ")
				var position = data[0].replace("(", "").replace(")", "").split(", ")
				var x = int(position[0])
				var y = int(position[1])
				var alpha = int(data[1])
				dot_positions.append({"x": x, "y": y, "alpha": alpha, "frame": frame_index})
		file.close()

	# 生成弹幕
	for dot in dot_positions:
		#var color_rect = ColorRect.new()
		#color_rect.color = Color(1, 1, 1, dot["alpha"] / 255.0)
		#color_rect.rect_size = Vector2(10, 10)
		#color_rect.position = Vector2(dot["x"] * 10, -dot["y"] * 10)
		#add_child(color_rect)
		# print(dot)
		var bullet_position: Vector2 = Vector2(dot["x"]*8, -dot["y"]*8)
		var bullet_hint: Bullet = spawner_component.spawn(bullet_position, self, 0)
		bullet_hint.modulate.a = dot["alpha"] / 255.0
		bullet_hint.frame = 0
		bullet_hint.velocity = Vector2(0, 100)
		bullet_hint.initialize()
