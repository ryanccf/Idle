extends Node2D


func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_ExitButton_pressed():
	get_tree().quit()
