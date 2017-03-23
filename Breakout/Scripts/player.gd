extends KinematicBody2D

export var speed = 200
var viewportSize
onready var halfsprite = get_node("./Sprite").get_texture().get_size().x/2
onready var ball = preload("res://Scenes/Ball.tscn")

var itemTime = 0

func _ready():
	viewportSize = get_viewport_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	if (itemTime > 0):
		itemTime = itemTime - delta
	else:
		speed = 200
	
	var direction = Vector2(Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"), 0)
	var newPos = get_pos() + (speed*direction*delta)
	newPos.x = clamp(newPos.x, halfsprite, viewportSize.width - halfsprite)
	set_pos(newPos)
	
func _on_bonus_malus_hit(bonusmalus):
	itemTime = 5
	if (bonusmalus.type == 0):
		speed = 100
	elif(bonusmalus.type == 1):
		speed = 300
	else:
		var ballNode = ball.instance()
		ballNode.set_linear_velocity(ballNode.get_linear_velocity() + Vector2(10,-10))
		get_parent().add_child(ballNode)
		
		ballNode = ball.instance()
		ballNode.set_linear_velocity(ballNode.get_linear_velocity() + Vector2(20,-20))
		get_parent().add_child(ballNode)
	bonusmalus.queue_free() 