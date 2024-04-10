extends Node


"""Makes and saves a new entry"""
func makeNewEntry(change,reason):
	_AddEntry(HistoryEntry.new(change,getCurrentBalance() + change,reason))
	pass

"""
Returns a list of every change ever
"""
func getAllEntries():
	return _LoadAllEntries()
	pass

"""
Returns the balance of the most recent entry
"""
func getCurrentBalance():
	return _LoadAllEntries().back().balance
	pass


# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# take entry and ask it to return a
# dict of relevant variables.
"""
takes a file entry and saves it
"""
func _AddEntry(_entry : HistoryEntry):
	
	var entries = _LoadAllEntries()
	
	entries.append(_entry)
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	for entry in entries:
		
		
		
		# Call the node's save function.
		var node_data = entry.save()
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)

# Note: This can be called from anywhere inside the tree. This function
# is path independent.

'''
returns all the entries ever
'''
func _LoadAllEntries():
	
	var entries = []
	
	if not FileAccess.file_exists("user://savegame.save"):
		
		return [HistoryEntry.new(0,0,"NoEntries")];
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save.get_position() < save.get_length():
		var json_string = save.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = HistoryEntry.new(0,0,"");
		
		# Now we set the remaining variables.
		for i in node_data.keys():
			new_object.set(i, node_data[i])
		
		entries.append(new_object)
		
		#print("save position",save.get_position())
		
	
	#print(entries.size())
	if entries.size() > 0:
		return entries
	else:
		
		return [HistoryEntry.new(0,0,"Default Entry")]
	

