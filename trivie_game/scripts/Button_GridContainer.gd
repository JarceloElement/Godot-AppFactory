extends MarginContainer

export var type = "word"
var active_word = ""
var active_word_string = ""
var grid_high = null


func _ready():
	add_to_group("button_grid_container")
	set_process(1)

func _process(delta):
	grid_high = get_node("ScrollContainer/GridContainer").get_children().size()
	if grid_high < 4:
		grid_high = 1
		set_custom_minimum_size(Vector2(0,grid_high*50))
		return
	if grid_high >= 4 and grid_high < 9:
		grid_high = 2
	if grid_high >= 8:
		grid_high = 3
	set_custom_minimum_size(Vector2(0,grid_high*53))
	set_process(0)
	
#	print(grid_high)

func _rectify(new_word): # lo envia el boton de opciones
	
	if type == "word":
		for button in get_tree().get_nodes_in_group("word_button"):
			if button.get_name() == active_word and button.type == "word":
				button.set_text(new_word)
				button.set_pressed(0)
				active_word = ""
#				active_word_string = ""
#				print(active_word)





func add_option(text):
	for message in get_tree().get_nodes_in_group("click_awesome"):
		message.click_awesome("add_option",text)
	
	if type == "word": # define el set_custom_minimum_size segun cantidad de palabras en el grid
		set_process(1)

