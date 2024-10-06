extends CharacterBody2D
class_name Enemy

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var level = preload("res://Level/level.tscn")
var tr = preload("res://Level/Objects/Scenes/tree.tscn")

enum EnemyState{MOVING,DYING,CHOPPING}

var tree : Log

var state : EnemyState

var elapsedChoppingTime = 0

func _ready() -> void:
	tree = get_parent().get_node("Tree")
	if self.get_global_transform().x < tree.get_global_transform().x:
		velocity.x = 25
	else:
		velocity.x = -25


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if get_parent().processing:
		if not is_on_floor():
			velocity += get_gravity() * delta
		match state:
			EnemyState.MOVING:
				moveTowardsTree()
			EnemyState.DYING:
				enemyDeath()
			EnemyState.CHOPPING:
				chopping(delta)

func moveTowardsTree() -> void:
	move_and_slide()
	
func enemyDeath() -> void:
	$AnimationPlayer.play("die")
	await $AnimationPlayer.animation_finished
	self.queue_free()
	
func chopping(delta : float) -> void:
	elapsedChoppingTime += delta
	if elapsedChoppingTime >= 2:
		get_parent().get_node("TreeHealth").value -= 5
		elapsedChoppingTime = 0
		
func changePosition(x : float, y : float) -> void:
	position.x = x
	position.y = y
	if position.x < tree.position.x:
		print("yarlo")
		velocity.x = 25
	else:
		velocity.x = -25
