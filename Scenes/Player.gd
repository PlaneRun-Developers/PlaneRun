extends Area2D

signal died
export var speed = 400
var allowed_to_shoot = true
var timer = Timer.new()
var debug_count = 0

func _process(delta):
	var lr_i = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var ud_i = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var new_position = position.x + lr_i * delta * speed
	var up_down = position.y + ud_i * delta * speed
	
	var half_width = $Sprite.texture.get_width() / 2
	var half_height = $Sprite.texture.get_height() / 2
	
	position.x = clamp(new_position, half_width, 1024 - half_width)
	position.y = clamp(up_down, half_height, 576 - half_height)

	if(Input.is_action_pressed("shoot") && allowed_to_shoot):
		self.allowed_to_shoot = false
		start_timer()
		var b = load("res://Scenes/Bullet.tscn").instance()
		b.position = self.position
		b.position.y -= 50
		get_tree().current_scene.add_child(b)
		$AudioStreamPlayer2D.play()
		
func start_timer() -> void:
	self.debug_count += 1
	print(debug_count)
	self.timer = Timer.new()
	print("Started Timer!")
	self.add_child(timer)
	timer.start(1)
	timer.connect("timeout", self, "allow_shoot")
	
func allow_shoot() -> void:
	print("Timer ended!")
	self.allowed_to_shoot = true
	timer.queue_free()
	
func _on_Player_area_entered(_area):
	if(_area.name == "Bullet"): return
	emit_signal("died")
	queue_free()
	
