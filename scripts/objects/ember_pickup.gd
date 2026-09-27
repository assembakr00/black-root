extends Area2D

signal ember_collected

var collected := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if collected or not body.is_in_group("player"):
		return

	collected = true
	GameState.has_ember = true
	ember_collected.emit()

	var animation_player := get_node_or_null("AnimationPlayer") as AnimationPlayer
	if animation_player:
		animation_player.play("pickup")

	var particles := get_node_or_null("GPUParticles2D") as GPUParticles2D
	if particles:
		particles.emitting = true

	queue_free()
