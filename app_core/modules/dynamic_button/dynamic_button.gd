tool
extends HBoxContainer
export var Title_message = "Title" setget _set_title
export var title_size = 25 setget _set_title_size

export  (DynamicFontData) var font setget _set_font
export var back_color = Color("ffffff") setget _set_back_color
export var hover_color = Color("ff0078")
export var border_color = Color("ff0078") setget _set_border_color
export var font_color = Color("ff0078") setget _set_font_color
export var font_color_hover = Color("ffffff")
export var corner_radius_lefttop = 5
export var corner_radius_rigthtop = 5
export var corner_radius_leftbottom = 5
export var corner_radius_rigthbottom = 5
export var anti_aliasing = 1
export var corner_detail = 4
export var border_width = 1 setget _set_border_width
export var ID_message = "title"
export var message_param = Array(["click_btn"])
export var scn_path = ""

var normal_style = StyleBoxFlat.new() setget _set_style
var hover_style = StyleBoxFlat.new()
var focus_style = StyleBoxFlat.new()



func _set_title(n_title):
	Title_message = n_title
	if is_inside_tree():
		$Button.set_text("  "+str(Title_message)+"  ")
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		$Button.set("custom_fonts/font", title_font)


func _set_style(style):
	normal_style = style
	if is_inside_tree():
		normal_style.corner_radius_bottom_left = corner_radius_leftbottom
		normal_style.corner_radius_bottom_right = corner_radius_rigthbottom
		normal_style.corner_radius_top_left = corner_radius_lefttop
		normal_style.corner_radius_top_right = corner_radius_rigthtop
		normal_style.anti_aliasing = anti_aliasing
		normal_style.corner_detail = corner_detail
		normal_style.bg_color = back_color

		$Button.set("custom_styles/normal",normal_style)
		$Button.set("custom_styles/focus",normal_style)
		$Button.set("custom_styles/pressed",normal_style)
		$Button.set("custom_styles/hover",hover_style)

func _set_back_color(color):
	back_color = color
	if is_inside_tree():
		normal_style.bg_color = back_color
		$Button.set("custom_styles/normal",normal_style)
		$Button.set("custom_styles/focus",normal_style)
		$Button.set("custom_styles/pressed",normal_style)
		$Button.set("custom_styles/hover",hover_style)

func _set_border_color(color):
	border_color = color
	if is_inside_tree():
#		normal_style.bg_color = back_color
		normal_style.border_width_bottom = border_width
		normal_style.border_width_left = border_width
		normal_style.border_width_right = border_width
		normal_style.border_width_top = border_width
		normal_style.border_color = border_color
	
		$Button.set("custom_styles/normal",normal_style)
		$Button.set("custom_styles/focus",normal_style)
		$Button.set("custom_styles/pressed",normal_style)
		$Button.set("custom_styles/hover",hover_style)
		
func _set_border_width(width):
	border_width = width
	if is_inside_tree():
		normal_style.border_width_bottom = border_width
		normal_style.border_width_left = border_width
		normal_style.border_width_right = border_width
		normal_style.border_width_top = border_width
	
		$Button.set("custom_styles/normal",normal_style)
		$Button.set("custom_styles/focus",normal_style)
		$Button.set("custom_styles/pressed",normal_style)
		$Button.set("custom_styles/hover",hover_style)

func _set_font_color(color):
	font_color = color
	if is_inside_tree():
		$Button.set("custom_fonts/font",font)
		$Button.set("custom_colors/font_color",font_color)
		$Button.set("custom_colors/font_color_hover",font_color)
		$Button.set("custom_colors/font_color_pressed",font_color)


func _set_font(n_font):
	font = n_font
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		$Button.set("custom_fonts/font", title_font)


func _set_title_size(size):
	title_size = size
	if is_inside_tree():
		var title_font = DynamicFont.new()
		title_font.font_data = font #load("res://app_core/fonts_preload/DroidSans.ttf")
		title_font.size = title_size
		$Button.set("custom_fonts/font", title_font)
		
		
		
		
func _ready():
	$Button.connect("pressed",self,"_pressed")
	
	normal_style.corner_radius_bottom_left = corner_radius_leftbottom
	normal_style.corner_radius_bottom_right = corner_radius_rigthbottom
	normal_style.corner_radius_top_left = corner_radius_lefttop
	normal_style.corner_radius_top_right = corner_radius_rigthtop
	normal_style.anti_aliasing = anti_aliasing
	normal_style.corner_detail = corner_detail
	normal_style.bg_color = back_color
	
	hover_style.corner_radius_bottom_left = corner_radius_leftbottom
	hover_style.corner_radius_bottom_right = corner_radius_rigthbottom
	hover_style.corner_radius_top_left = corner_radius_lefttop
	hover_style.corner_radius_top_right = corner_radius_rigthtop
	hover_style.anti_aliasing = anti_aliasing
	hover_style.corner_detail = corner_detail
	hover_style.bg_color = hover_color
	focus_style.draw_center = false
	
	normal_style.border_width_bottom = border_width
	normal_style.border_width_left = border_width
	normal_style.border_width_right = border_width
	normal_style.border_width_top = border_width
	normal_style.border_color = border_color
	
	hover_style.border_width_bottom = border_width
	hover_style.border_width_left = border_width
	hover_style.border_width_right = border_width
	hover_style.border_width_top = border_width
	hover_style.border_color = border_color
#
	$Button.set("custom_styles/normal",normal_style)
	$Button.set("custom_styles/focus",focus_style)
	$Button.set("custom_styles/pressed",normal_style)
	$Button.set("custom_styles/hover",hover_style)
#	
	var title_font = DynamicFont.new()
	title_font.font_data = font
	title_font.size = title_size
	$Button.set("custom_fonts/font", title_font)
		
	$Button.set("custom_colors/font_color",font_color)
	$Button.set("custom_colors/font_color_hover",font_color_hover)
	$Button.set("custom_colors/font_color_pressed",font_color)
	
	
	var title = get_node("/root/Messages").get(Title_message)
	if title != null:
		$Button.set_text("  "+str(title)+"  ")
	else:
		$Button.set_text("  "+str(Title_message)+"  ")


		
func _pressed():
#	print(ID_message,message_param)
	if scn_path != "":
		Loading.goto_scene(scn_path,"in")
		
	for i in get_tree().get_nodes_in_group("click_awesome"):
		i.click_awesome(ID_message,message_param)
