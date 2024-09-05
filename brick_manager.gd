extends Node2D

@export var brick_scene: Resource;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return

	for i in 7:
		for j in 4:
			var new_brick = brick_scene.instantiate()
			new_brick.position = Vector2(125 + (150 * i), 50 + (75 * j));
			add_child(new_brick)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
