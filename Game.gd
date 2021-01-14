extends Node2D

signal send_lead

var counter = 0
var leads = 30
var lead_price = 1
var agents = 0
var agent_price = 100
var ticks = 0
var year = 1969
var quarter = 1
var multiplier = 1
var base_multiplier = 1.0
var max_multiplier = 10
var call_value = 25
var wages = 0

var Agent = preload("res://Agent.tscn")

onready var Count = $Background/Count
onready var Leads = $Background/Leads
onready var Agents = $Background/Agents
onready var Year = $Background/Year
onready var Quarter = $Background/Quarter
onready var Multiplier = $Background/Multiplier
onready var Wages = $Background/Wages

const TICKS_PER_QUARTER = 90
const VICTORY_CONDITION = 400000

func _ready():
	refresh_view()

func _on_CallButton_pressed():
	dial()
	refresh_view()

func _on_BuyLeadsButton_pressed():
	get_node("RideSound").play()
	if counter >= 10:
		leads += 100
		counter -= 10
	refresh_view()

func _on_BuyAgentButton_pressed():
	if counter >= agent_price:
		get_node("CrashSound").play()
		counter -= agent_price
		agents += 1
		update_wages()
		add_agent()
	refresh_view()

func _on_Agent_sale(money):
	add_money(stepify(money * multiplier, 0.01))

func _on_AdvertiseButton_pressed():
	if multiplier <= max_multiplier:
		counter -= lead_price
		get_node("StickSound").play()
		multiplier += 0.1
		refresh_view()

func _on_Tick_timeout():
	ticks += 1
	check_quarter()
	check_win()
	send_leads()
	calc_multiplier()
	refresh_view()

func update_wages():
	wages = (agents * agent_price)

func pay_payroll():
	counter -= wages

func send_leads():
	if leads >= agents:
		leads -= agents
		emit_signal("send_lead")

func refresh_view():
	Count.text = String(counter)
	Leads.text = String(leads)
	Agents.text = String(agents)
	Quarter.text = String(quarter)
	Year.text = String(year)	
	Multiplier.text = String(multiplier)
	Wages.text = String(wages)

func dial():
	get_node("FloorTomSound").play()
	if leads > 0:
		leads -= 1
		randomize()
		var random_number = int(rand_range(1.0, 6.0))
		if random_number == 1:
			get_node("SpinnerSound").play()
			counter += stepify(call_value * multiplier, 0.01)

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

func calc_multiplier():
	if multiplier > base_multiplier:
		multiplier -= 0.01

func check_quarter():
	if ticks > TICKS_PER_QUARTER:
		ticks = 0
		quarter += 1
		pay_payroll()
		if quarter > 4:
			quarter = 1
			year += 1
