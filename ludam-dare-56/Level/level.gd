extends Node2D

var acorn = preload("res://Level/Objects/Scenes/acorn.tscn")

var enemy = preload("res://Enemy/Scenes/Enemy.tscn")

var spawnPoint1 = Vector2i(-246, 472)
var spawnPoint2 = Vector2i(1338, 472)

var totalCurrentAcorns = 1
var elapsedTime = 0

var processing = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if processing:
		elapsedTime += delta
		if elapsedTime > 1.0 and totalCurrentAcorns < 3:
			var new_acorn = acorn.instantiate()
			new_acorn.position.x = randf_range($Foilage.position.x - 230.0/2, $Foilage.position.x + 230.0/2)
			new_acorn.position.y = randf_range($Foilage.position.y - 90.0/2, $Foilage.position.y + 90.0/2)
			elapsedTime = 0
			add_child(new_acorn)
			totalCurrentAcorns += 1
		
		if elapsedTime >= 1:
			var lumberjack = enemy.instantiate()
			var ran = randi_range(0, 1)
			add_child(lumberjack)
			move_child(lumberjack, 4)
			match ran:
				0:
					lumberjack.changePosition(spawnPoint1.x, spawnPoint1.y)
				1:
					lumberjack.scale.x *= -1
					lumberjack.changePosition(spawnPoint2.x, spawnPoint2.y)
			elapsedTime = 0
		if $TreeHealth.value == 0:
			processing = false
			$Timer.stop()
			$"You Lose!!!".show()
			$Button.show()

var seconds = 0
var minutes = 2
var Dseconds = 30
var Dminutes = 1
func _on_timer_timeout() -> void:
	if seconds == 0 and minutes > 0:
		minutes -= 1
		seconds = 60
	seconds -= 1
	
	$Time.text = ("%d:%d" % [minutes, seconds])
	if minutes < 0:
		$Time.text = ("%d:%d%d" % [minutes, 0, seconds])
	
	if seconds == 0 and minutes == 0:
		win()

func win() -> void:
	$Timer.stop()
	$"You Win!!!".show()
	processing = false
	$Button.show()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
