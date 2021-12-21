extends MarginContainer

var total = 100
var level = 40

onready var bar = get_node("VBoxContainer/HBoxContainer/MarginContainer2/ProgressBar")

func _ready():
	add_to_group("progres_bar_game")


func bar_next_level():
	bar.set_max(total)
	bar.set_value(level)
	get_node("VBoxContainer/HBoxContainer/MarginContainer/Label").set_text(str(level)+"/"+str(total))
#	print(total,"-",level)
	pass
