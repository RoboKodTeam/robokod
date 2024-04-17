extends CharacterBody2D

@export var speed = 50

@export var tile_size: int = 32
var tile_center = Vector2(int(tile_size / 2), tile_size / 2)

@onready var position_grid = coord_to_grid(position)
@onready var target = position

var active = false

@onready var sprite = $AnimatedSprite2D


func _get_direction():
	var direction = Vector2.ZERO

	if active:
		return direction

	if Input.is_action_just_pressed("up"):
		direction.y -= 1
	if Input.is_action_just_pressed("down"):
		direction.y += 1
	if Input.is_action_just_pressed("left"):
		direction.x -= 1
	if Input.is_action_just_pressed("right"):
		direction.x += 1

	return direction


func _physics_process(_delta: float):
	var direction = _get_direction()

	if direction != Vector2.ZERO:
		position_grid += direction
		target = grid_to_coord(position_grid)
		print("Moving from ", position, " to ", target)

		sprite.play("walk")
		velocity = position.direction_to(target) * speed

	if position.distance_to(target) > 1:
		active = true
		move_and_slide()
	else:
		active = false
		sprite.play("idle")


func coord_to_grid(coord: Vector2):
	return (coord - tile_center) / tile_size


func grid_to_coord(grid: Vector2):
	return grid * tile_size + tile_center
