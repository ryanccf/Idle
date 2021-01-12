extends Node2D

signal send_lead

var counter = 0
var leads = 30
var agents = 0
var ticks = 0
var year = 1969
var quarter = 1

var Agent = preload("res://Agent.tscn")

onready var Count = $Background/Count
onready var Leads = $Background/Leads
onready var Agents = $Background/Agents
onready var Year = $Background/Year
onready var Quarter = $Background/Quarter

const TICKS_PER_QUARTER = 90
const VICTORY_CONDITION = 400000

func _ready():
	refresh_view()

func _on_CallButton_pressed():
	dial()
	refresh_view()

func _on_BuyLeadsButton_pressed():
	if counter > 9:
		leads += 100
		counter -= 10
	refresh_view()

func _on_BuyAgentButton_pressed():
	if counter > 99:
		counter -= 100
		agents += 1
		add_agent()

func _on_Agent_sale(money):
	add_money(money)
	get_node("SpinnerSound").play()

func _on_Tick_timeout():
	ticks += 1
	refresh_view()
	check_quarter()
	check_win()
	send_leads()

func send_leads():
	leads -= agents
	emit_signal("send_lead")

func refresh_view():
	Count.text = String(counter)
	Leads.text = String(leads)
	Agents.text = String(agents)
	Quarter.text = String(quarter)
	Year.text = String(year)

func dial():
	if leads > 0:
		leads -= 1
		randomize()
		var random_number = int(rand_range(1.0, 6.0))
		if random_number == 1:
			get_node("SpinnerSound").play()
			counter += 25
	refresh_view()

func add_money(money):
	counter += money

func add_agent():
	var agent = Agent.instance()
	add_child(agent)
	agent.connect("sale", self, "_on_Agent_sale")
	agent.connect("call", self, "_on_Agent_call")
	
func check_win():
	if counter >= VICTORY_CONDITION:
		get_tree().change_scene("res://VictoryScreen.tscn")

func check_quarter():
	if ticks > TICKS_PER_QUARTER:
		ticks = 0
		quarter += 1
		if quarter > 4:
			quarter = 1
			year += 1
