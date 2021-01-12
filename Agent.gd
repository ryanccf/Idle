extends Node2D

signal sale(money)

var close_percent = 25
var sale_value = 25

func _ready():
	get_parent().connect("send_lead", self, "on_send_lead")

func on_send_lead():
	call_lead()

func call_lead():
	randomize()
	var random_number = int(rand_range(1.0, 100.0))
	if random_number <= close_percent:
		emit_signal("sale", sale_value)
