extends CharacterBody2D

@export var score_label: RichTextLabel;
@export var speed: float = 3.0
@export var max_speed: float = 10.0
@export var speed_increment: float = 0.5
@export var start_label: RichTextLabel;

var current_score: int = 0;
var is_running: bool = false;

const PADDLE_WIDTH: float = 100.0

var forward = Vector2(1,1).normalized()


func _physics_process(delta: float) -> void:
	if not is_running:
		if Input.is_action_just_pressed("click_window"):
			start_label.hide();
			show();
			is_running = true;
		return
	
	var collision: KinematicCollision2D = move_and_collide(forward * speed);
	
	if collision:
		forward = forward.bounce(collision.get_normal())
		speed = clamp(speed + speed_increment, 1, max_speed)
		
		if collision.get_collider().is_in_group("Bricks"):
			collision.get_collider().queue_free()
			current_score += 10
			score_label.text = "SCORE: " + str(current_score)
		
		if collision.get_collider().is_in_group("Paddle"):
			var paddle_x = collision.get_collider().position.x - (PADDLE_WIDTH / 2.0)
			var pos_on_paddle = (position.x - paddle_x) / PADDLE_WIDTH
			print(paddle_x)
			print(pos_on_paddle)
			print("Hit paddle")
			var bounce_angle = lerp(-PI * 0.8, -PI * 0.2, pos_on_paddle)
			forward = Vector2.from_angle(bounce_angle);
			
		if collision.get_collider().is_in_group("GameOver"):
			hide()
			start_label.show()
			start_label.text = "[center]GAME OVER\n[Click To Replay][/center]"
			is_running = false
			
