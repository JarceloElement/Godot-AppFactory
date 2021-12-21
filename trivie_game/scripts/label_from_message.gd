tool

extends Label

var font = ""
var font_1 = preload("res://app_core/fonts/Roboto-Ligh_20.font")
var font_2 = preload("res://app_core/fonts/Roboto-Ligh_26.font")
var font_3 = preload("res://app_core/fonts/Roboto-Ligth_30.font")
var font_4 = preload("res://app_core/fonts/Roboto-Bold_30.font")
var font_title = preload("res://app_core/fonts/Roboto-Ligth_40.font")
var font_products = preload("res://app_core/fonts/DroidSans_25.font")

export var Font_size = 3
export var Is_product = 0
export var Is_title = 0
export var text_from_mesasge = ""

	
func _ready():
#	set_process(1)
	
	if text_from_mesasge != "":
		self.text = str(get_node("/root/Messages").get(text_from_mesasge))
	
	if Font_size == 1:
		font = font_1
	if Font_size == 2:
		font = font_2
	if Font_size == 3:
		font = font_3
	if Font_size == 4:
		font = font_4
		

	var screen_x = get_viewport_rect().size.x
	
	if Is_product == 0:
		if Is_title == 0:
			var alto = int(get_line_count()*(font.get_string_size("A").y+10))
			set_custom_minimum_size(Vector2(screen_x/4,alto))
			set("custom_fonts/font",font)
			set_process(0)
			
		else:
			var alto = int(get_line_count()*(font_title.get_string_size("A").y+50))
			set_custom_minimum_size(Vector2(screen_x/4,alto))
			set("custom_fonts/font",font_title)
			set_process(0)
			
	if Is_product == 1:
		var alto = int(get_line_count()*(font_products.get_string_size("A").y))
		set_custom_minimum_size(Vector2(screen_x/4,alto))
		set("custom_fonts/font",font_products)
		set_process(0)
		
	
func _process(delta):

#	set_process(0)
	pass

#	print(get_line_count())
	
	
	
	
