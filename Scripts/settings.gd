extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



var mainMenuPath = "res://pages/main_menu.tscn"
func _on_save_and_return_pressed():
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.

var historyPath = "res://pages/history.tscn"
func _on_expense_history_pressed():
	get_tree().change_scene_to_file(historyPath)
	pass # Replace with function body.


func _on_bedtime_reward_min_value_changed(value):
	SettingsFile.maximumBedtimeAward = value
	SettingsFile.save()
	pass # Replace with function body.


func _on_earliestbedtime_h_slider_value_changed(value):
	SettingsFile.earliestBedTime = value
	SettingsFile.save()
	pass # Replace with function body.


func _on_latestbedtime_h_slider_value_changed(value):
	SettingsFile.latestBedTime = value
	SettingsFile.save()
	pass # Replace with function body.


func _on_insult_tax_value_changed(value):
	SettingsFile.insultTax = value
	SettingsFile.save()
	pass # Replace with function body.


func _on_bedtime_reward_max_value_changed(value):
	SettingsFile.maximumBedtimeAward = value
	SettingsFile.save()
	pass # Replace with function body.
