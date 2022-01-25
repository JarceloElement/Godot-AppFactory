tool
extends MarginContainer

export var ID = "name"
export(int, 0, 1000, 1) var icon_size = 40 setget _set_size
export var icon = "warning" setget _set_icon
export var icon_color = Color("737373") setget _set_color
export var title_color = Color("ffffff") setget _set_title_color
export var btn_title = "Title" setget _set_title
var color_icon_activo ="ed1a73"

export var ID_message = "title"
export var message_param = ["click"]
export var path_scn = ""

var set_id_btn = 0
var tower_title = ""


func _set_icon(n_icon):
	icon = n_icon
	if is_inside_tree():
		$VBoxContainer/icon._set_icon(icon)

func _set_size(n_size):
	icon_size = n_size
	if is_inside_tree():
		$VBoxContainer/icon._set_size(icon_size)
		
func _set_color(n_color):
	icon_color = n_color
	if is_inside_tree():
		$VBoxContainer/icon.set("custom_colors/font_color",icon_color)
				
func _set_title_color(n_color):
	title_color = n_color
	if is_inside_tree():
		if has_node("VBoxContainer/Label"):
			$VBoxContainer/Label.set("custom_colors/font_color",title_color)
		
func _set_title(n_title):
	btn_title = n_title
	if is_inside_tree():
		if has_node("VBoxContainer/Label"):
			$VBoxContainer/Label.text = btn_title




func _ready():
	add_to_group("button_icon")
	add_to_group("click_awesome")
	
	connect("gui_input",self,"_on_FontAwesome_gui_input")
#	$icon.connect("gui_input",self,"_on_FontAwesome_gui_input")


	$VBoxContainer/icon.set("custom_colors/font_color",icon_color)
	$VBoxContainer/icon.icon = icon
	$VBoxContainer/icon.size = icon_size

	if is_inside_tree():
		if $"/root/Messages".get(btn_title):
			$VBoxContainer/Label.text = $"/root/Messages".get(btn_title)
		else:
			$VBoxContainer/Label.text = btn_title


func _on_FontAwesome_gui_input( ev ):
	if ev is InputEventMouseButton:

		if !ev.pressed:
			var slider_pos_global = get_node("/root/SliderControl").slider_pos_global
				
			if slider_pos_global < 5:
				
				if ID_message == "scn":
					Loading.goto_scene(path_scn,"in")

				else:
					for i in get_tree().get_nodes_in_group("click_awesome"):
						i.click_awesome(ID_message,message_param)
#					print("Click_icon")
			OS.hide_virtual_keyboard()
			
#					print("Click: ",ID_message)




func click_awesome(ID_message,message_param):

#	print(ID_message,message_param)
	if ID_message == "color_icon_activo":
		color_icon_activo = message_param
		$VBoxContainer/icon.set("custom_colors/font_color",color_icon_activo)

#	if ID_message == "paginacion" and ID == int(2):
#		if get_name() == str(message_param):
#			$icon.set("custom_colors/font_color",color_icon_activo)
#		else:
#			$icon.set("custom_colors/font_color",icon_color)


