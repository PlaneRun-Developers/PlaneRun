extends Control

func _ready():
	$HighScore.text = "High Score: " + str(Global.load_file("highscore.dat")) 
	$Label/AnimationPlayer.play("Main")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_QuitButton_pressed():
	if OS.get_executable_path() == "tmp_js_export" || OS.get_executable_path() == "index" || OS.get_executable_path() == "game":
		JavaScript.eval("window.history.go(-1)")
	else:
		get_tree().quit()
