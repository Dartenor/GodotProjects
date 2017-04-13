extends Sprite

var id = ''
var lastDirection = Vector2(0,0)
onready var animator = get_node("./Animator")

func selectFirstSprite(ID):
	id = ID
	set_frame(int(id)*4)

func animateMotion(direction):
	if(lastDirection == direction):
		return
	
	animator.stop(false)
	
	if (direction == Vector2(1,0)):
		animator.play("MoveRight"+id)
	elif (direction == Vector2(-1,0)):
		animator.play("MoveLeft"+id)
	elif (direction == Vector2(0,-1)):
		animator.play("MoveUp"+id)
	elif (direction == Vector2(0,1)):
		animator.play("MoveDown"+id)
	
	lastDirection = direction

func animateDie():
	animator.play("Death")

func _on_Animator_finished(test):
	get_parent().queue_free()
