extends KinematicBody2D

var speed = 100
var direction = Vector2(0,0)
var newDir = Vector2(0,0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var space_state = get_world_2d().get_direct_space_state()
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(get_pos(), get_pos()+Vector2(-20,0), [self])
	if (not result.empty()):
		print("Hit at point: ",result.position)
		print("Hit at name: ",result.collider.get_name())


#	var pos = get_pos()
#	var dir = Vector2(Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"),0)
#	if (dir == Vector2(0,0)):
#		dir = Vector2(0,Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up"))
#	if (dir != Vector2(0,0)):
#		newDir = dir
#		if (move_to(pos + (delta * newDir * speed)) > Vector2(0,0)):
#			direction = newDir
#			newDir = Vector2(0,0)
#			return
#	
#	move_to(pos + (delta * direction * speed))