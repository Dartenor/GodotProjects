extends KinematicBody2D

var speed = 120
var direction = Vector2(0,0)
var futureDirection = Vector2(0,0)
var newDir = Vector2(0,0)
var dead = false
var firstTime = true
var tempElapsed = 0
onready var sprites = get_node("./Sprites")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
		
	if (dead):
		return
	
	if (Input.is_action_pressed("ui_page_down")):
		dead = true
		sprites.animateDie()
		return
	
	var pos = get_pos()
	
	var dir = Vector2(Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"),0)
	if (dir == Vector2(0,0)):
		dir = Vector2(0,Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up"))
	if (dir != Vector2(0,0)):
		futureDirection = dir
	
	if (test_move(futureDirection*speed*delta)):
		if (test_move(direction*speed*delta)):
			direction = Vector2(0,0)
	else:
		direction = futureDirection
	move(direction*speed*delta)
	
	sprites.animateMotion(direction)