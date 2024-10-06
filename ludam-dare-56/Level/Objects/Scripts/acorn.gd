extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_body_entered(body: Node2D) -> void:
	if body is Chipmunk and body.acornTotal < 3:
		addAcorn(body)
		get_parent().totalCurrentAcorns -= 1
		self.queue_free()

func addAcorn(body : Node2D) -> void:
	body.acornTotal += 1
	var mainScene = get_parent()
	if not mainScene.get_node("TextureRect3").get_child(0).is_visible():
		mainScene.get_node("TextureRect3").get_child(0).show()
	elif not mainScene.get_node("TextureRect2").get_child(0).is_visible():
		mainScene.get_node("TextureRect2").get_child(0).show()
	else:
		mainScene.get_node("TextureRect").get_child(0).show()
