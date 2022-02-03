tool
extends CanvasLayer

export var show_title = 1
export var title_size = 30 setget _set_title_size
export var Title_color = Color("ffffff") setget _set_color
export  (DynamicFontData) var font setget _set_font

func _set_title_size(size):
	title_size = size
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		$elements/MarginContainer_top/HBoxContainer/Title_bar/Label.set("custom_fonts/font", title_font)

	
func _set_color(n_color):
	Title_color = n_color
	if is_inside_tree():
		$elements/MarginContainer_top/HBoxContainer/Title_bar/Label.set("custom_colors/font_color",Title_color)
		

func _set_font(n_font):
	font = n_font
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		get_node("elements/MarginContainer_top/HBoxContainer/Title_bar/Label").set("custom_fonts/font", title_font)
		
		
func _ready():
	add_to_group("set_title_from_categ")
	add_to_group("click_awesome")
	
	get_node("elements/MarginContainer_top/HBoxContainer/Title_bar/Label").set("custom_colors/font_color",Title_color)

	if show_title == 0:
		get_node("elements/MarginContainer_top/HBoxContainer/Title_bar/Label").hide()



func set_title_from_categ(Titulo):
	if show_title == 1:
		get_node("elements/MarginContainer_top/HBoxContainer/Title_bar/Label").set_text(Titulo)

	
	
func click_awesome(id_message,message_param):
	if id_message == "title":
		if show_title == 1:
			get_node("elements/MarginContainer_top/HBoxContainer/Title_bar/Label").set_text(message_param[0])
		
#	if id_message == "top_bar_volver" and mensaje_text[0] == "0":
#		get_node("CanvasLayer/MarginContainer_top/HBoxContainer/menu").hide()
#
#	if id_message == "no_menu":
#		get_node("CanvasLayer/MarginContainer_top/HBoxContainer/menu").hide()
#
#	if id_message == "preview_camera" and mensaje_text[0] == "hide":
#		get_node("CanvasLayer").hide()
#
#	if id_message == "preview_camera" and mensaje_text[0] == "show":
#		get_node("CanvasLayer").show()
#
#	if id_message == "add_popup" and mensaje_text[0] == "hide":
#		get_node("CanvasLayer").hide()
#
#	if id_message == "add_popup" and mensaje_text[0] == "show":
#		get_node("CanvasLayer").show()

#	print(id_message,mensaje_text)
