# DestroyerRush
 STG, Boss Rush

# 关卡设计
 暂时这样
## 第一关
 简单的弹幕对射
## 第二关
 有攻击模式的弹幕对射
## 第三关
 双BOSS，左右各一边，攻击方式不同。当其中一名敌人血量远低于另一名敌人血量时，会互换位置。当
## 第四关
 奖励关，手速小游戏
 动态难度具体为：

	if 70 > progress and progress > 50:
		enemy_count = randi_range(1, 4)
	elif  90 > progress and progress >= 70:
		enemy_count = randi_range(2, 4)
	elif  100 > progress and progress >= 90:
		enemy_count = randi_range(2, 3)
	elif  50 >= progress and progress >= 0:
		enemy_count = randi_range(0, 6)
## 第五关
 阶段性BOSS关
## 第六关
 不要动挑战
