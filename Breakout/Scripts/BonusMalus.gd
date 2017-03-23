extends Area2D
signal bonus_malus_hit(bonusmalus)

var velocity = Vector2(0,100)
var type = 0
onready var Player = get_node("/root/World/Player")
onready var spriteNode = get_node("./Sprite")
onready var type0 = preload("res://Sprites/Malus.png")
onready var type1 = preload("res://Sprites/Bonus.png")
onready var type2 = preload("res://Sprites/Multi.png")

func _ready():
	self.connect("bonus_malus_hit", Player, "_on_bonus_malus_hit")
	_set_texture()
	set_fixed_process(true)

func _set_texture() :
	if (type == 1):
		spriteNode.set_texture(type1)
	elif(type == 2):
		spriteNode.set_texture(type2)
	else:
		spriteNode.set_texture(type0)

func _fixed_process(delta):
	set_pos(get_pos() + (velocity * delta))

func _on_BonusMalus_body_enter( body ):
	if (body.get_name() == "Player"):
		emit_signal("bonus_malus_hit", self)