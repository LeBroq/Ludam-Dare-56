extends CharacterBody2D
class_name Chipmunk

var acornBullet = preload("res://Level/Objects/Scenes/acorn_bullet.tscn")


const SPEED = 300.0
const BULLETSPEED = 500.0
const JUMP_VELOCITY = -400.0
var acornTotal = 3
var collidingWithTree = false

enum ChipmunkState{STATIONARY,MOVING,CLIMBING}
var state : ChipmunkState

enum ForwardState{LEFT,RIGHT,DOWN,UP}
var direction = ForwardState.RIGHT

func _physics_process(delta: float) -> void:
	if get_parent().processing:
		# Add the gravity.
		if not is_on_floor() and not collidingWithTree:
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if collidingWithTree:
			if Input.is_action_pressed("ui_down"):
				velocity.y = 300
			else:
				velocity.y = 0

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		checkShoot()
		
		checkClimbVersusJump()
		
		getDirection()

		move_and_slide()

func checkShoot() -> void:
	if Input.is_action_just_pressed("Shoot"):
		if acornTotal > 0:
			removeAcorn()
			var bullet = acornBullet.instantiate()
			bullet.position = Vector2(position.x, position.y)
			match direction:
				ForwardState.LEFT:
					bullet.Velocity.x = BULLETSPEED * -1
				ForwardState.RIGHT:
					bullet.Velocity.x = BULLETSPEED
				ForwardState.UP:
					bullet.Velocity.y = BULLETSPEED * -1
				ForwardState.DOWN:
					bullet.Velocity.y = BULLETSPEED
			get_parent().add_child(bullet)
			
func checkClimbVersusJump() -> void:
	if Input.is_action_pressed("ui_up"):
		if collidingWithTree:
			velocity.y = -300
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY
			
func getDirection():
	if Input.is_action_pressed("ui_up"):
		$Sprite2D.texture = load("res://Chipmunk-Up.png")
		direction = ForwardState.UP
	if Input.is_action_pressed("ui_down"):
		$Sprite2D.texture = load("res://Chipmunk-Down.png")
		direction = ForwardState.DOWN
	if Input.is_action_pressed("ui_left"):
		$Sprite2D.texture = load("res://Chipmunk-Left.png")
		direction = ForwardState.LEFT
	if Input.is_action_pressed("ui_right"):
		$Sprite2D.texture = load("res://Chipmunk-Right.png")
		direction = ForwardState.RIGHT

func removeAcorn() -> void:
	acornTotal -= 1
	var mainScene = get_parent()
	if mainScene.get_node("TextureRect").get_child(0).is_visible():
		mainScene.get_node("TextureRect").get_child(0).hide()
	elif mainScene.get_node("TextureRect2").get_child(0).is_visible():
		mainScene.get_node("TextureRect2").get_child(0).hide()
	else:
		mainScene.get_node("TextureRect3").get_child(0).hide()
