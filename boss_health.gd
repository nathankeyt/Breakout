extends ProgressBar

func _ready() -> void:
	visible = false

func connect_boss(boss: Node2D):
	boss.connect("health_update", health_update)
	
func health_update(health: int):
	value = health
