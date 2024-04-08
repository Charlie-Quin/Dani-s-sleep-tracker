extends  Node
class_name HistoryEntry

var change = 0

var balance = 0

var reason = ""

var dateTime

func _init(change :float, balance : float, reason : String):
	
	self.change = change
	self.balance = balance
	self.reason = reason
	
	dateTime = Time.get_date_string_from_system() + " Time:" + Time.get_time_string_from_system()
	
	

func save():
	var save_dict = {
		"change" : change,
		"balance" : balance,
		"reason" : reason,
		"dateTime" : dateTime,
	}
	return save_dict
