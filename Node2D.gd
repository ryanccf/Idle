extends Node2D

signal sale(money)

var close_percent = 30

func _ready():
	var game = get_tree().get_root()
	print(game)
	game.connect("sale", self, "_on_Agent_sale")

func _process(_delta):
	randomize()
	var random_number = int(rand_range(1.0, 100.0))
	if random_number <= close_percent:
		emit_signal("sale", 1)
