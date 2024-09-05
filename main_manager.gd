extends Camera2D

@export var shake_speed = 10.0;
@export var noise: Noise
@export var shake_strength: float = 50.0;

var curr_shake_strength: float = 0.0;

var noise_i: float = 0.0

func shake(time: float) -> void :
	curr_shake_strength = shake_strength;
	var tween: Tween = create_tween()
	tween.tween_property(self, "curr_shake_strength", 0.0, time).set_ease(Tween.EASE_OUT)
	
func _process(delta: float) -> void:
	offset = get_noise_offset(delta)

func get_noise_offset(delta: float):
	noise_i += shake_speed;
	
	return Vector2(
		noise.get_noise_2d(1, noise_i) * curr_shake_strength, 
		noise.get_noise_2d(100, noise_i) * curr_shake_strength
	)
	
func _on_brick_spawn() -> void:
	shake(3.0)
