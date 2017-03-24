extends Node2D

signal level_cleared(level)

export var levelNr = 0
onready var childs = get_child_count()

func _on_child_freed():
	childs = childs - 1
	if (childs <= 0):
		emit_signal("level_cleared", levelNr)