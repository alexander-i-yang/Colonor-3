extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	_velocity.x = -speed.x
	set_physics_process(false)

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y or body.get_name() != "Player":
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	if is_on_wall():
		_velocity.x *= -1.0
	._physics_process(delta)
	
