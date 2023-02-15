extends Area2D

signal screen_exited
export var speed = 400
var type = "Enemey"

func _process(delta):
	position.y = position.y + speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	#emit_signal("screen_exited")
	queue_free()


func _on_Enemy_area_entered(area):
	if(area.get("type") == null): return
	if(area.type == "Bullet"):
		emit_signal("screen_exited")
		queue_free()
		area.queue_free()
