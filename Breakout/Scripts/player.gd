extends KinematicBody2D

export var speed = 200
var viewportSize
onready var halfsprite = get_node("./Sprite").get_texture().get_size().x/2

func _ready():
	viewportSize = get_viewport_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	var direction = Vector2(Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"), 0)
	var newPos = get_pos() + (speed*direction*delta)
	newPos.x = clamp(newPos.x, halfsprite, viewportSize.width - halfsprite)
	set_pos(newPos)