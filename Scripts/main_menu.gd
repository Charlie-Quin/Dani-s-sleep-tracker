extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%expense.text = "$" + str(snapped(MoneyManager.getCurrentBalance(),0.01))
	pass # Replace with function body.




var pathToSettingsPage = "res://pages/settings.tscn"
func _on_settings_pressed():
	get_tree().change_scene_to_file(pathToSettingsPage)
	pass # Replace with function body.


var pathToIncomeExpensePage = "res://pages/expense_income_page.tscn"
func _on_income_pressed():
	Globals.isIncome = true
	get_tree().change_scene_to_file(pathToIncomeExpensePage)
	pass # Replace with function body.

func _on_expense_button_pressed():
	Globals.isIncome = false
	get_tree().change_scene_to_file(pathToIncomeExpensePage)
	pass # Replace with function body.


