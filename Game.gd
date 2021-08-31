extends Node2D

signal send_lead(close_percent)

var counter = 1000

var Card = preload("res://Card.tscn")
var Stack = preload("res://Stack.tscn")

onready var Count = $Background/Count

func _ready():
	randomize()

func _on_CallButton_pressed():
	var deck = Stack.instance()                                                                                                                                                                                                                                                                          
	var first_card = Card.instance()
	var second_card = Card.instance()
	var third_card = Card.instance()
	first_card.set_value("Queen of Hearts")
	second_card.set_value("King of Diamonds")
	third_card.set_value("2 of Clubs")
	
	deck.add_card(first_card)
	deck.add_card(second_card)
	deck.add_card(third_card)

	deck.shuffle()

	deck.list_cards()
	#dial()
	#refresh_view()

#func send_leads():
#	if leads >= agents:
#		leads -= agents
#		emit_signal("send_lead", base_close_percent + managers)
#
#func refresh_view():
#	Count.text = String(counter)
#	Leads.text = String(leads)
#	Agents.text = String(agents)
#	Quarter.text = String(quarter)
#	Year.text = String(year)	
#	Multiplier.text = String(multiplier)
#	Wages.text = String(wages)
#	Managers.text = String(managers)
#	Close.text = String(base_close_percent + managers)
