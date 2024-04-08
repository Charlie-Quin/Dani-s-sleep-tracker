extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%title.text = "Income" if Globals.isIncome else "Expense"
	%background.color = Color("7dd4fe") if Globals.isIncome else Color("e93a9a")
	pass # Replace with function body.



var mainMenuPath = "res://pages/main_menu.tscn"
func _on_confirm_pressed():
	MoneyManager.makeNewEntry(%amountbox.value * (1 if Globals.isIncome else -1), %reasonbox.text)
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.


func _on_cancel_pressed():
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.
