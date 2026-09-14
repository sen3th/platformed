extends Area2D

@export var coin_value = 5;

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("add_coins"):
			body.add_coins(coin_value)
		queue_free()
