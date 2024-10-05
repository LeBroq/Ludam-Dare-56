extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_body_entered(body: Node2D) -> void:
	if body is Chipmunk and body.acornTotal < 3:
		body.acornTotal += 1
		get_parent().totalCurrentAcorns -= 1
		self.queue_free()
