tool
extends Label


export var title_size = 30 setget _set_title_size
export var Title_color = Color("ffffff") setget _set_color
export  (DynamicFontData) var font setget _set_font


func _set_title_size(size):
	title_size = size
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		set("custom_fonts/font", title_font)

func _set_color(n_color):
	Title_color = n_color
	if is_inside_tree():
		set("custom_colors/font_color",Title_color)
		
func _set_font(n_font):
	font = n_font
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		set("custom_fonts/font", title_font)
		

func _ready():
	
	if $"/root/Messages".get(text):
		text = $"/root/Messages".get(text)
