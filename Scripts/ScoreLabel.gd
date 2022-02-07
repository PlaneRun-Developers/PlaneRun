extends Label

var score = 0
var count = 0

func add_score():
	if count < 3:
		count += 1
	elif count == 3:
		score += 1
		text = str(score)
		count = 0
