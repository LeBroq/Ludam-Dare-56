extends Node2D

var acorn = preload("res://Level/Objects/Scenes/acorn.tscn")

var totalCurrentAcorns = 0
var elapsedTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsedTime += delta
	if elapsedTime > 1.0 and totalCurrentAcorns < 3:
		var new_acorn = acorn.instantiate()
		new_acorn.position.x = randf_range($Foilage.position.x - 250.0/2, $Foilage.position.x + 250.0/2)
		new_acorn.position.y = randf_range($Foilage.position.y - 110.0/2, $Foilage.position.y + 110.0/2)
		elapsedTime = 0
		add_child(new_acorn)
		totalCurrentAcorns += 1
		
