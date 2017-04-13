extends KinematicBody2D

var speed = 120
var direction = Vector2(0,0)
var futureDirection = Vector2(0,0)
var dead = false
onready var prevPos = get_pos()
onready var sprites = get_node("./Sprites")
onready var level = get_node("../Level")
var levelBounds = Vector2(0,0)
var collisionSize = Vector2(29,29)

func _ready():
	levelBounds = level.get_horizontal_bounds()
	set_fixed_process(true)

func _fixed_process(delta):
	if (dead):
		return
	
	var pos = get_pos()
	
	var dir = Vector2(Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"),0)
	if (dir == Vector2(0,0)):
		dir = Vector2(0,Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up"))
	if (dir != Vector2(0,0)):
		futureDirection = dir
		
	if (test_move(futureDirection*3)):
		if (test_move(direction*3)):
			direction = Vector2(0,0)
	else:
		direction = futureDirection
	
	move(direction*speed*delta)
	checkBounds(pos)
	
	sprites.animateMotion(direction)

func checkBounds(pos):
	if ((pos.x + collisionSize.x/2 - 1) < levelBounds.x):
		set_pos(Vector2(levelBounds.y + collisionSize.x/2 - 1, pos.y))
	elif((pos.x - collisionSize.x/2 + 1) > levelBounds.y):
		set_pos(Vector2(levelBounds.x - collisionSize.x/2 + 1, pos.y))
		

func _on_Death_area_enter( area ):
	if(!dead):
		dead = true
		sprites.animateDie()
