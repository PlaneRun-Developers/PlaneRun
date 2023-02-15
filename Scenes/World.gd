extends Node

export var EnemyScene: PackedScene

func _on_SpawnTimer_timeout():
	for i in 3:
		var enemy = EnemyScene.instance()
		add_child(enemy)
		enemy.position = Vector2(rand_range(20, 1024 - 20), 0)
		enemy.connect("screen_exited", self, "_on_enemy_exited")

func _on_enemy_exited():
	$CanvasLayer/ScoreLabel.add_score()

func _on_Player_died():
	$Particles2D.position = $Player.position
	$Particles2D.emitting = true
	$ExplosionSound.play()
	if int($CanvasLayer/ScoreLabel.score) > int(Global.load_file("highscore.dat")):
		Global.save_file("highscore.dat", str($CanvasLayer/ScoreLabel.score))


func _on_ExplosionSound_finished():
	var loading = get_tree().change_scene("res://Scenes/Menu.tscn")
	if(loading != OK):
		print("Critical error")
	
func _process(delta):
	if $ParallaxBackground/ParallaxLayer/Sprite.position.y >= 0:
		$ParallaxBackground/ParallaxLayer/Sprite.position.y = -576
	$ParallaxBackground/ParallaxLayer/Sprite.position.y += 250 * delta
