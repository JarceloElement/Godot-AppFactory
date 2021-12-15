extends VBoxContainer

var total = 100

onready var bar = get_node("bar/ProgressBar")

func _ready():
	add_to_group("loading_bar")
	hide()

func loading_bar_set_stage(stage):
	show()
#	print("stage loading_bar: ",stage)
	bar.set_max(total)
	bar.set_value(stage)
#	print(total,"-",level)
	pass
