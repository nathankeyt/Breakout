extends CharacterBody2D

signal spawn

@export var boss_scene : Resource
@export var boss_path : Path2D
@export var health_bar: ProgressBar
@export var ball: CharacterBody2D

func _notification(what: int) -> void:
	if (what == NOTIFICATION_PREDELETE):
		print("awakening")
		emit_signal("spawn")
		var boss: PathFollow2D = boss_scene.instantiate()
		var viewport_size: Vector2 = get_viewport_rect().size
		boss_path.add_child(boss)
		health_bar.call("connect_boss", boss)
		ball.connect("hit", boss.hit)
		
