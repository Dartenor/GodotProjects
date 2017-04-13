extends Area2D

export var bigGem = false
onready var spriteNode = get_node("./Sprite")
onready var bigGemTexture = preload("res://Sprites/Gem2.png")

func _ready():
	if (bigGem):
		spriteNode.set_texture(bigGemTexture)

func _on_Gem_body_enter( body ):
	get_parent().gem_caught()
	self.queue_free()
