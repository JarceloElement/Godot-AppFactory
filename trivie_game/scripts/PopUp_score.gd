extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	add_to_group("click_awesome")

	set_process(1)


func click_awesome(id_mensaje,param):

	if id_mensaje == "popup_close":
		get_node("/root/FuncApp").popup_active = 0
		queue_free()

func _process(delta):
	if get_node("/root/FuncApp").responsive_size != Vector2(0,0):
		get_node("MarginContainer").set_size(Vector2(get_node("/root/FuncApp").responsive_size.x,get_node("/root/FuncApp").screen_size.y))
		get_node("MarginContainer").set_position(Vector2(get_node("/root/FuncApp").responsive_pos.x,0)) 


