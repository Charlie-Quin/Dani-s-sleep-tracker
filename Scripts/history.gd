extends Control

var entryList = []

var sectionOfList = 0

var maxItemsToDisplay = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	
	entryList = MoneyManager.getAllEntries()
	entryList.reverse()
	
	#print(entryList)
	
	updateButtonStates()
	updateList()
	
	
	
	pass # Replace with function body.


var pathToHistoryEntry = "res://pages/history_entry.tscn"
func updateList():
	
	for child in %ListContainer.get_children():
		child.queue_free()
		
	
	for i in maxItemsToDisplay:
		
		if entryList.size() <= i + sectionOfList:
			#print("finished iterating")
			return
		
		
		var historyEntry = load(pathToHistoryEntry).instantiate()
		var entry : HistoryEntry = entryList[sectionOfList + i] 
		
		historyEntry.text = "Change: " + str(snapped(entry.change,0.01)) + " Balance: " + str(snapped(entry.balance,0.01)) + "\nDate: " + str(entry.dateTime) + "\nReason: " + str(entry.reason)
		
		%ListContainer.add_child(historyEntry)
		
	
	
	pass

func updateButtonStates():
	%prevButton.disabled = true if sectionOfList <= 0 else false
	%nextButton.disabled = true if  entryList.size() <= sectionOfList + maxItemsToDisplay else false
	
	var currentPage = floor(sectionOfList/maxItemsToDisplay) + 1
	var totalPages = ceil(entryList.size()/maxItemsToDisplay) + 1
	
	%pageLabel.text = "Page: " + str(currentPage) + "/" +  str(totalPages) + " (" + str(entryList.size()) + ")"
	
	pass

func _on_next_button_pressed():
	sectionOfList += maxItemsToDisplay
	updateButtonStates()
	updateList()
	pass # Replace with function body.


func _on_prev_button_pressed():
	sectionOfList -= maxItemsToDisplay
	updateButtonStates()
	updateList()
	pass # Replace with function body.

var pathToSettingsPage = "res://pages/settings.tscn"
func _on_back_pressed():
	get_tree().change_scene_to_file(pathToSettingsPage)
	pass # Replace with function body.

