extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%title.text = "Income" if Globals.isIncome else "Expense"
	%background.color = Color("7dd4fe") if Globals.isIncome else Color("e93a9a")
	
	
	pass # Replace with function body.

func _process(delta):
	%insultBedtimeButton.text = "Bedtime (" + str( calculateBedtimeReward()) + ")"  if Globals.isIncome else "Insult"


var mainMenuPath = "res://pages/main_menu.tscn"
func _on_confirm_pressed():
	MoneyManager.makeNewEntry(%amountbox.value * (1 if Globals.isIncome else -1), %reasonbox.text)
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.


func _on_cancel_pressed():
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.


func _on_insult_bedtime_button_pressed():
	
	if Globals.isIncome:
		bedTimeButton()
	else:
		insultButton()
	
	pass # Replace with function body.

func insultButton():
	MoneyManager.makeNewEntry(
		-SettingsFile.insultTax, 
		"Insult button was pressed.")
	get_tree().change_scene_to_file(mainMenuPath)
	pass

func bedTimeButton():
	
	
	MoneyManager.makeNewEntry(
		calculateBedtimeReward(), 
		"Bedtime at: " + Time.get_time_string_from_system())
	get_tree().change_scene_to_file(mainMenuPath)
	
	pass

func calculateBedtimeReward():
	
	var cost = 0;
	
	var currentTimeDict = Time.get_time_dict_from_system()
	
	var currentTime = currentTimeDict["hour"]
	currentTime += currentTimeDict["minute"] * 0.01 * 10.0/6.0
	
	#now we have to deal with if the current time is past midnight but the end bedtime is before midnight
	if currentTime < SettingsFile.earliestBedTime - 12:
		currentTime += 24
	
	#print("currenttime: ", currentTime, 
	#" ",
	#SettingsFile.earliestBedTime,
	#" ",
	#SettingsFile.latestBedTime
	#)
	
	var reward = map(
	currentTime,
	SettingsFile.minimumBedtimeAward, #output start
	SettingsFile.maximumBedtimeAward,
	SettingsFile.latestBedTime, #input start
	SettingsFile.earliestBedTime
	)
	
	reward = clamp(reward,0,SettingsFile.maximumBedtimeAward)
	
	return snapped(reward,0.01)
	
	
	

func map(input,output_start,output_end,input_start,input_end):
	return output_start + ((output_end - output_start) / (input_end - input_start)) * (input - input_start)
