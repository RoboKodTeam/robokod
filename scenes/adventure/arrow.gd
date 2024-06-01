@tool
extends Path2D

@onready var line = $Line2D
@onready var cap_sprite = $Sprite2D

@export var color = Color(1, 1, 1, 1):
	set(value):
		color = value
		queue_redraw()


func _draw():
	# Duplicate curve to allow external modifications
	curve = curve.duplicate()
	line.points = curve.get_baked_points()

	# Update colors
	line.default_color = color
	cap_sprite.modulate = color

	# Finally draw the arrow cap
	_place_arrow_cap()


func _place_arrow_cap():
	# Require min 2 points
	if curve.point_count < 2:
		return

	# Get last point of the curve
	var last_i = curve.point_count - 1

	# Set cap position
	var last_pos = curve.get_point_position(last_i)
	cap_sprite.position = last_pos

	# Calculate cap rotation by converting delta to the rotation coord
	var last_in = curve.get_point_in(last_i)
	var first_pos = curve.get_point_position(0)
	var direction = (first_pos - last_pos) if last_in.is_zero_approx() else last_in

	var angle_tan = direction.y / direction.x
	var angle = atan(angle_tan)
	# Correct angle based on the direction.x coordinate to leverage the
	# codomain limitation of the atan function
	angle += PI if direction.x > 0 else 0.0
	cap_sprite.rotation = angle
