extends Node2D

signal sale(money)

var agent_skill = 0
var sale_value = 25

func _ready():
	get_parent().connect("send_lead", self, "on_send_lead")
	randomize()

func on_send_lead(close_percent):
	call_lead(close_percent)

func call_lead(close_percent):
	var random_number = int(rand_range(1.0, 100.0))
	if random_number <= close_percent + agent_skill:
		emit_signal("sale", sale_value)
