extends KinematicBody2D

export var speed = 200
var viewportSize
onready var halfsprite = get_node("./Sprite").get_texture().get_size().x/2
onready var ballContainer = get_node("/root/World/BallContainer")
var ballAttached = null

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
	if (ballAttached != null):
		ballAttached.set_pos(newPos + Vector2(0,-11))
		if(Input.is_action_pressed("ui_up")):
			ballAttached.set_linear_velocity(Vector2(200,-200))
			ballAttached = null
	
func _on_bonus_malus_hit(bonusmalus):
	itemTime = 5
	if (bonusmalus.type == 0):
		speed = 100
	elif(bonusmalus.type == 1):
		speed = 300
	else:
		ballContainer._instance_ball(false)
		ballContainer._instance_ball(false)
	bonusmalus.queue_free() 