extends Area2D
class_name Bullet

var total_elapsed_time = 0

const LIFETIME = 3

var Velocity : Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total_elapsed_time += delta
	if(total_elapsed_time > LIFETIME):
		self.queue_free()
	position.x += Velocity.x * delta
	position.y += Velocity.y * delta
