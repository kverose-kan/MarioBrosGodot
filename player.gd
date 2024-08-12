extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D


const MIN_WALK = 4
const ACCEL_MOVE = 10
const MAX_WALK = 60
const DECEL_SKID = 6
const DECEL_RELEASE = 6
const MAX_RUN = 90
const SKID_TURN = 32
var SPEED
const JUMP_VELOCITY = -300.0


var gravity = 800

var isSkidding = false
var isRunning = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("A") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("B"):
		SPEED = MAX_RUN
		isRunning = true
	else:
		SPEED = MAX_WALK
		isRunning = false
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		if isSkidding == true:
			velocity.x = move_toward(velocity.x, 0, DECEL_SKID)
		
		if sign(direction) == -sign(velocity.x) and abs(velocity.x) > MIN_WALK and is_on_floor():
			isSkidding = true
		
		else:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCEL_MOVE)
			isSkidding = false
	else:
		if isSkidding:
			velocity.x = SKID_TURN * -sign(velocity.x)
		if abs(velocity.x) > 0:
			velocity.x = move_toward(velocity.x, 0, DECEL_RELEASE)
			isSkidding = false
		
	
	
	

	move_and_slide()
	_update_animations()

func _update_animations():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
	
	if isSkidding and is_on_floor():
		animated_sprite_2d.play("skid")
	elif velocity.y != 0 and not is_on_floor():
		animated_sprite_2d.play("jump")
	elif velocity.x != 0 and is_on_floor():
		if isRunning:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.speed_scale = 2
		else:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.speed_scale = 1
	else:
		animated_sprite_2d.play("idle")
	
	
		
