extends KinematicBody2D

var speed = 120
var direction = Vector2(0,0)
var futureDirection = Vector2(0,0)
var newDir = Vector2(0,0)

func _ready():
	set_process(true)

func _process(delta):
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
	
	#var space_state = get_world_2d().get_direct_space_state()
	#var posToCheck = pos + (direction * Vector2(50,50))
	#var result = space_state.intersect_ray( pos, posToCheck, [self])
	#if (not result.empty()):
	#	if (result.collider.get_name() == "Path"):
	#		set_pos(pos + (delta * direction * speed))