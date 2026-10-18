extends Node2D

var speed = 300
var direction = Vector2(-1,0)
var screen_size = Vector2()
var window_size = Vector2(300,300)
var idle_timer = 0.0
var is_idling 

@onready var animated_sprite = $AnimatedSprite2D
func _ready():
	screen_size = Vector2(DisplayServer.screen_get_size())
	animated_sprite.play("Walk_Right") #assigns walking animation to when that thign happens

func maybe_idle():
	if randf() < 0.3:
		is_idling = true
		idle_timer = randf_range(1.0,3.0)
		var r = randi()%3
		if r==0:
			animated_sprite.play("Standing")
			speed = 0
			
func _physics_process(delta: float) -> void:
		if is_idling:
			idle_timer -= delta
			if idle_timer <=0:
				is_idling = false
				speed = 300
				animated_sprite.play("Walk_Right")
			return
		var window_position = Vector2(DisplayServer.window_get_position())
		window_position += direction * speed * delta
		print(window_position)
		window_position.x = clamp(window_position.x, 0, screen_size.x - window_size.x)
		window_position.y = clamp(window_position.y, 0, screen_size.y - window_size.y)
		
		# These if statements make it so that the srpite flips and switches direction
		
		if window_position.x <=0 or window_position.x >= screen_size.x - window_size.x:
			direction.x *=-1
			animated_sprite.flip_h = !animated_sprite.flip_h
			maybe_idle()
		if window_position.y <=0 or window_position.y >= screen_size.y - window_size.y:
			direction.y *=-1
			maybe_idle()

			 
		
		DisplayServer.window_set_position(Vector2i(window_position))
		
	
	
 
