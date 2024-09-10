extends PathFollow2D

signal health_update;

@export var speed: float = 100.00
@export var brick_scene: Resource

var brick_arr: Array

@onready var sprite: Sprite2D = $AnimatableBody2D/BossBrick
@onready var collision_shape: CollisionShape2D = $AnimatableBody2D/CollisionShape2D;

var direction: int = 1;
var health = 100.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.disabled = true;
	sprite.modulate = Color.TRANSPARENT
	var tween: Tween = create_tween()
	progress_ratio = 0.5;
	direction = 0;
	tween.tween_property(sprite, "modulate", Color.WHITE, 4.0).set_custom_interpolator(tween_curve)
	tween.tween_callback(start)

func tween_curve(input: float):
	return abs(sin(input * ((5 * PI) / 2)))
	
func hit():
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
	print("health")
	health -= 10
	emit_signal("health_update", health)
	
	if health <= 0:
		queue_free();
		for brick in brick_arr:
			if is_instance_valid(brick):
				brick.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress_ratio >= 1.0:
		direction = -1
	elif progress_ratio <= 0.0:
		direction = 1
	
	progress += delta * speed * direction;
	
func spawn_brick_wall():
	for i in 7:
		var new_brick : CharacterBody2D = brick_scene.instantiate()
		new_brick.position = Vector2(125 + (150 * i), 325)
		var brick_sprite: Sprite2D = new_brick.get_node("Brick")
		var brick_collision: CollisionShape2D = new_brick.get_node("CollisionShape2D")
		get_tree().root.add_child(new_brick)
		brick_arr.append(new_brick)
		
		var tween: Tween = create_tween()
		brick_collision.disabled = true;
		brick_sprite.modulate = Color.TRANSPARENT
		tween.tween_property(brick_sprite, "modulate", Color.WHITE, 0.5).set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(func(): brick_collision.disabled = false)

func start():
	spawn_brick_wall()
	collision_shape.disabled = false;
	direction = 1;
