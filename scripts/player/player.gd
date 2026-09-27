extends CharacterBody2D


const SPEED = 700.0
const RUN_SPEED = 1100.0
const JUMP_VELOCITY = -520.0
const GRAVITY_SCALE = 1.5

var animation_type = "init"

# Used to smooth the movement slightly
var target_vel = Vector2(0, 0)
# How fast the player can accelerate, not actually pixels per second squared
var player_acceleration = 5
# If the player is moving at less than this speed, they are stopped
var stopping_speed = 0.1

func _physics_process(delta: float) -> void:
	await move(delta)
	_update_animation()
	move_and_slide()

func _update_animation() -> void:
	var animated_sprite: AnimatedSprite2D = $PlayerSprite
	
	turn_player(animated_sprite)
	
	animation_type = get_animation_type()

	if animated_sprite.animation != animation_type:
		animated_sprite.play(animation_type)

func get_animation_type() -> String:
	if not is_on_floor():
		if velocity.y > stopping_speed:
			return "fall"
		return "jump"

	if abs(velocity.x) > stopping_speed:
		return "run" if Input.is_action_pressed("sprint") else "move"

	return "idle"


func move(delta):
	if GameState.input_locked:
		velocity = Vector2.ZERO
		return

	target_vel = Vector2.ZERO
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
		# If the player just landed
		if animation_type == "fall":
			$FallSound.play()
		elif animation_type == "move" and !$WalkSound.playing:
			$WalkSound.play()
	else:
		velocity += get_gravity() * delta * GRAVITY_SCALE

	var movement_speed := RUN_SPEED if Input.is_action_pressed("sprint") else SPEED
	if Input.is_action_pressed("move_left"):
		target_vel[0] -= movement_speed
	if Input.is_action_pressed("move_right"):
		target_vel[0] += movement_speed

	velocity.x += (target_vel.x - velocity.x) / player_acceleration

# Update the players direction
func turn_player(animated_sprite):
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

