tool
extends MarginContainer

export var color = Color("d2205d") setget _set_color
export var corner_radius_top = 0 setget _set_radius_top
export var corner_radius_bottom = 0 setget _set_radius_bottom
export var anti_aliasing = 1
export var corner_detail = 4 setget _set_corner_detail
var style = StyleBoxFlat.new()


func _set_color(n_color):
	color = n_color
	if is_inside_tree():
		style.bg_color = color
		get_node("back_color").set("custom_styles/panel",style)
#		get_node("back_color").set_modulate(Color(color))
	
func _set_radius_top(radius):
	corner_radius_top = radius
	if is_inside_tree():
		style.corner_radius_top_left = corner_radius_top
		style.corner_radius_top_right = corner_radius_top
		get_node("back_color").set("custom_styles/panel",style)
		
		
func _set_radius_bottom(radius):
	corner_radius_bottom = radius
	if is_inside_tree():
		style.corner_radius_bottom_left = corner_radius_bottom
		style.corner_radius_bottom_right = corner_radius_bottom
		get_node("back_color").set("custom_styles/panel",style)
	
		
func _set_corner_detail(corner_d):
	corner_detail = corner_d
	if is_inside_tree():
		style.anti_aliasing = anti_aliasing
		style.corner_detail = corner_detail
		get_node("back_color").set("custom_styles/panel",style)
	
		style.anti_aliasing = anti_aliasing
	
func _ready():
	
	style.anti_aliasing = anti_aliasing
	

