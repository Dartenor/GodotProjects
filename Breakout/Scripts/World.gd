extends Node2D

onready var level0 = preload("res://Scenes/Level0.tscn")
onready var level1 = preload("res://Scenes/Level1.tscn")
onready var level2 = preload("res://Scenes/Level2.tscn")
onready var levelContainer = get_node("./LevelContainer")
onready var player = get_node("./Player")
onready var ballContainer = get_node("./BallContainer")

func _ready():
	_instance_level(2)
	
func _instance_level(level):
	ballContainer._clear_balls()
	var levelNode
	if (level == 0):
		levelNode = level0.instance()
	elif(level == 1):
		levelNode = level1.instance()
	else:
		levelNode = level2.instance()
	levelNode.connect("level_cleared", self, "_on_level_cleared")
	levelContainer.add_child(levelNode)
	player.ballAttached = ballContainer._instance_ball(true)
	
func _on_level_cleared(level):
	levelContainer.get_child(0).queue_free()
	_instance_level(level+1)