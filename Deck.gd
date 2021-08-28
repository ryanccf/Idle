extends Node2D

var deckName = "defaultDeck"
var cards = []

func add_card(card):
	self.cards.push_front(card)

func shuffle():
	self.cards.shuffle();

func set_name(name):
	self.deckName = name

func get_name():
	return self.deckName

func list_cards():
	for card in cards:
		print(card.get_value())
