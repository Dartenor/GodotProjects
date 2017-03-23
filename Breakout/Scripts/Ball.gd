extends RigidBody2D

var viewport_size = Vector2(0,0)

func _ready():
	viewport_size = get_viewport_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	var pos = get_pos()
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Blocks"):
			body._hit_by_ball()
	
	if (pos.y > viewport_size.height):
		self.queue_free()