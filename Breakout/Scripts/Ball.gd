extends RigidBody2D

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Blocks"):
			body._hit_by_ball()