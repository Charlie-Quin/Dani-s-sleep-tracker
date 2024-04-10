extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%BedtimeRewardMin.value = SettingsFile.minimumBedtimeAward
	%BedtimeRewardMax.value = SettingsFile.maximumBedtimeAward
	
	%earliestbedtimeHSlider.value = SettingsFile.earliestBedTime
	
	%latestbedtimeHSlider.value = SettingsFile.latestBedTime
	
	%insultTax.value = SettingsFile.insultTax
	
	pass # Replace with function body.



var mainMenuPath = "res://pages/main_menu.tscn"
func _on_save_and_return_pressed():
	get_tree().change_scene_to_file(mainMenuPath)
	pass # Replace with function body.

var historyPath = "res://pages/history.tscn"
func _on_expense_history_pressed():
	get_tree().change_scene_to_file(historyPath)
	pass # Replace with function body.



#Sliders

func _on_earliestbedtime_h_slider_value_changed(value):
	SettingsFile.earliestBedTime = value
	SettingsFile.save()
	
	%EarliestBedtime.text = "Earliest Bedtime: " + militaryTimeToNormalTime(value)
	pass # Replace with function body.


func _on_latestbedtime_h_slider_value_changed(value):
	SettingsFile.latestBedTime = value
	SettingsFile.save()
	
	%LastestBedtime.text = "Latest Bedtime: " + militaryTimeToNormalTime(value)
	pass # Replace with function body.



func _on_insult_tax_value_changed(value):
	SettingsFile.insultTax = value
	SettingsFile.save()
	pass # Replace with function body.

#reward min and max

func _on_bedtime_reward_max_value_changed(value):
	SettingsFile.maximumBedtimeAward = value
	SettingsFile.save()
	pass # Replace with function body.

func _on_bedtime_reward_min_value_changed(value):
	SettingsFile.minimumBedtimeAward = value
	SettingsFile.save()
	pass # Replace with function body.

"""
takes a military time number (with minutes out of 100) 
into normal people time
"""
func militaryTimeToNormalTime(militaryTime : float):
	
	var suffix = ""
	if militaryTime < 12:
		suffix = " AM"
	else:
		suffix = " PM"
		militaryTime -= 12
	
	#get the last two digits
	var minutesNum = fmod(militaryTime * 100 , 100)
	#convert it from out of 100 to out of 60
	minutesNum = round(minutesNum  * 0.6)
	#make it a string
	var minutes = str(minutesNum) if minutesNum >= 10 else "0" + str(minutesNum) 
	
	#get the hours
	var hoursNum = floor(militaryTime)
	#if it's 0 make it 12
	if hoursNum == 0:
		hoursNum = 12
	
	var hours = str(hoursNum) + ":"
	
	return hours + minutes + suffix
	
	pass
