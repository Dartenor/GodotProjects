extends Node2D

onready var ballScene = preload("res://Scenes/Ball.tscn")

func _ready():
	pass

func _clear_balls():
	for child in get_children():
		child.queue_free()

func _instance_ball(on_player):
	var ballNode = ballScene.instance()
	if (on_player):
		add_child(ballNode)
		return ballNode
	else:
		var ball1 = get_child(get_child_count()-1)
		ballNode.set_pos(ball1.get_pos())
		ballNode.set_linear_velocity(ball1.get_linear_velocity() + Vector2(10,-10))
		add_child(ballNode)
		return null