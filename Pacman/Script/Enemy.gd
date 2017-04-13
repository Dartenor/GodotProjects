extends KinematicBody2D

export var id = '0'
export var diff = 1.0
var speed = 120
var direction = Vector2(0,0)
var futureDirections = []
var timeElapsed = 1
onready var sprites = get_node("./Sprites")
onready var level = get_node("../Level")
onready var player = get_node("../Player")
var levelBounds = Vector2(0,0)
var collisionSize = Vector2(29,29)
onready var playerPath = player.get_path()

func _ready():
	sprites.selectFirstSprite(id)
	show()
	levelBounds = level.get_horizontal_bounds()
	set_fixed_process(true)

func _fixed_process(delta):
	timeElapsed = timeElapsed + delta
	var pos = get_pos()
	
	if (timeElapsed >= diff):
		timeElapsed = 0
		futureDirections = getDirectionToPlayer(pos)
	
	for futureDir in futureDirections:
		if (!test_move(futureDir*3)):
			if (futureDir != direction*-1):
				direction = futureDir
				break
	
	move(direction*speed*delta)
	checkBounds(pos)
	
	sprites.animateMotion(direction)
	
func checkBounds(pos):
	if ((pos.x + collisionSize.x/2 - 1) < levelBounds.x):
		futureDirections.invert()
		set_pos(Vector2(levelBounds.y + collisionSize.x/2 - 1, pos.y))
	elif((pos.x - collisionSize.x/2 + 1) > levelBounds.y):
		futureDirections.invert()
		set_pos(Vector2(levelBounds.x - collisionSize.x/2 + 1, pos.y))

func getDirectionToPlayer(pos):
	var playerPos = Vector2(0,0)
	if (get_tree().get_root().has_node(playerPath)):
		playerPos = player.get_pos()
	else:
		randomize()
		playerPos = Vector2(randi() % 400 + 40, randi() % 450 + 120)
	
	var distH = abs(pos.x - playerPos.x)
	var distV = abs(pos.y - playerPos.y)
	
	var result = []
	if (distH >= distV):
		if (pos.x > playerPos.x):
			result.append(Vector2(-1,0))
		else:
			result.append(Vector2(1,0))
		
		if (pos.y > playerPos.y):
			result.append(Vector2(0,-1))
		else:
			result.append(Vector2(0,1))
	else:
		if (pos.y > playerPos.y):
			result.append(Vector2(0,-1))
		else:
			result.append(Vector2(0,1))
			
		if (pos.x > playerPos.x):
			result.append(Vector2(-1,0))
		else:
			result.append(Vector2(1,0))
	result.append(result[1] * -1)
	result.append(result[0] * -1)
	return result