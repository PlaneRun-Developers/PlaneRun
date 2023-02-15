extends Area2D

var type = "Bullet"
signal enemey_shot

func _physics_process(delta):
	self.position.y -= 500*delta

