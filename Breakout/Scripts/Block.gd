extends Node2D

export var level = 1
onready var spriteNode = get_node("./Sprite")
onready var level1Text = preload("res://Sprites/Block1.png")
onready var level2Text = preload("res://Sprites/Block2.png")
onready var level3Text = preload("res://Sprites/Block3.png")

func _ready():
	level = level + 1
	_hit_by_ball()

func _hit_by_ball() :
	level = level - 1
	if (level == 1):
		spriteNode.set_texture(level1Text)
	elif(level == 2):
		spriteNode.set_texture(level2Text)
	elif(level == 2):
		spriteNode.set_texture(level3Text)
	else:
		queue_free()