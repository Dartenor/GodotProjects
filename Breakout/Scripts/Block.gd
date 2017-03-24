extends Node2D

export var level = 1
export var has_item = false
export var item_type = 2

onready var item = preload("res://Scenes/BonusMalus.tscn")
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
	elif(level == 3):
		spriteNode.set_texture(level3Text)
	else:
		if (has_item):
			var itemNode = item.instance()
			itemNode.type = item_type
			itemNode.set_pos(get_pos())
			get_parent().add_child(itemNode)
		queue_free()
		if (get_parent() != null):
			get_parent()._on_child_freed()