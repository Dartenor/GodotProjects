extends StaticBody2D


func get_horizontal_bounds():
	var posPar = get_pos()
	var size = get_node("./Sprite").get_texture().get_size()
	return Vector2(posPar.x - size.x/2, posPar.x + size.x/2)