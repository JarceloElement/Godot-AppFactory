extends Camera2D

export var left_in = -120
export var up_in = 0



func _ready():
	set_process(true)

func _process(delta):

	if up_in < 0:
		up_in += 20
		pass

	if left_in < 0:
		left_in += 20
		pass
	set_offset(Vector2( left_in, up_in))




