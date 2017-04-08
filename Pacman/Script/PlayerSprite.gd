extends Sprite

var lastDirection = Vector2(0,0)
onready var animator = get_node("./Animator")

func animateMotion(direction):
	if(lastDirection == direction):
		return
	
	animator.stop(false)
	
	if (direction == Vector2(1,0)):
		animator.play("MoveRight")
	elif (direction == Vector2(-1,0)):
		animator.play("MoveLeft")
	elif (direction == Vector2(0,-1)):
		animator.play("MoveUp")
	elif (direction == Vector2(0,1)):
		animator.play("MoveDown")
	
	lastDirection = direction

func animateDie():
	animator.play("Death")

func _on_Animator_finished(test):
	get_parent().queue_free()
