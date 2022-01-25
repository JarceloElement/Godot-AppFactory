tool

extends Label

#var font = ""
#var font_1 = preload("res://app_core/fonts/Roboto-Ligh_20.font")
#var font_2 = preload("res://app_core/fonts/Roboto-Ligh_26.font")
#var font_3 = preload("res://app_core/fonts/Roboto-Ligth_30.font")
#var font_4 = preload("res://app_core/fonts/Roboto-Bold_30.font")
#var font_title = preload("res://app_core/fonts/Roboto-Ligth_40.font")
#var font_products = preload("res://app_core/fonts/DroidSans_25.font")
#
#export var Font_size = 3
#export var Is_product = 0
#export var Is_title = 0
export var text_from_mesasge = ""

	
func _ready():
#	set_process(1)
	
	if text_from_mesasge != "":
		self.text = str(get_node("/root/Messages").get(text_from_mesasge))
	


	var screen_x = get_viewport_rect().size.x
	

func _process(delta):

#	set_process(0)
	pass

#	print(get_line_count())
	
	
	
	
