tool
extends MarginContainer
export var show_texture = bool(1)
export (StreamTexture) var texture_path
export var back_color = Color("cdcdcd") setget _set_color


func _set_color(n_color):
	back_color = n_color
	if is_inside_tree():
		$ColorRect.color = back_color
	
func _ready():
	if show_texture == true:
		get_node("TextureFrame").set_texture(texture_path)
	VisualServer.set_default_clear_color(Color(back_color)) # color de fondo si no hay textura
	$ColorRect.color = back_color
#	$ColorRect.hide()
	pass

