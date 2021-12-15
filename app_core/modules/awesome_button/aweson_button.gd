tool
extends Label

export(int, 0, 1000, 1) var size = 16 setget _set_size
export var icon = "" setget _set_icon
export var filter = true setget _set_filter

const ttf = preload("res://addons/FontAwesome/fontawesome-webfont.ttf")
const Cheatsheet = preload("res://addons/FontAwesome/Cheatsheet.gd").Cheatsheet
var _font = DynamicFont.new()

func _init():

	
	self.filter = filter
	_font.set_font_data(ttf)
	set("custom_fonts/font", _font)
	

func _set_size(p_size):
	size = p_size #get_owner().get_node(".").icono_size
	if is_inside_tree():
		_font.set_size(p_size)

func _set_icon(p_icon):
	icon = p_icon #get_owner().get_node(".").icono
	if is_inside_tree():
		var iconcode = ""
		if p_icon in Cheatsheet:
			iconcode = Cheatsheet[p_icon]
		set_text(iconcode)

func _set_filter(f):
	filter = f
	if is_inside_tree():
		_font.set_use_filter(f)





func _ready():

#	set_process(1)
#	add_to_group("flecha")
#	self.size = get_owner().get_node(".").icon_size
#	self.size = get_node("../../../").icon_size
	self.size = size
#	self.icon = get_owner().get_node(".").icon_2
#	self.icon = get_node("../../../").icon

	if get_owner().has_node("MarginContainer/Iconos/VBoxContainer/titulo/Label_ver"):
		get_owner().get_node("MarginContainer/Iconos/VBoxContainer/titulo/Label_ver").set_text(get_owner().get_node(".").title)
	
	if get_owner().has_node("MarginContainer/Iconos/VBoxContainer/descripcion/descripcion"):
		get_owner().get_node("MarginContainer/Iconos/VBoxContainer/descripcion/descripcion").set_text(get_owner().get_node(".").description)
	
	if get_owner().has_node("HBoxContainer/MarginContainer/Label"):
		get_owner().get_node("HBoxContainer/MarginContainer/Label").set_text(get_owner().get_node(".").title)
	
	
	if get_owner().has_node("HBoxContainer/MarginContainer/Button_icon"):
		get_owner().get_node("HBoxContainer/MarginContainer/Button_icon").set_text(self.get_text())
		get_owner().get_node("HBoxContainer/title").set_text(get_parent().title)

func _process(delta):
	pass

