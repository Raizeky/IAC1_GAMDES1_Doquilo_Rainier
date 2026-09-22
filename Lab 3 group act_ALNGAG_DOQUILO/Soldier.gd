extends CharacterBody2D

var speed := 250.0
var attack_range := 180.0
var attack_damage := 15

var attack_cooldown := 0.7
var attack_timer := 0.0

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	add_to_group("soldiers")
	queue_redraw()

func _process(delta):
	attack_timer -= delta

	if dragging:
		global_position = get_global_mouse_position() + drag_offset
		global_position.x = clamp(global_position.x, 60.0, 760.0)
		global_position.y = clamp(global_position.y, 120.0, 550.0)

	var target = get_nearest_zombie()
	if target and attack_timer <= 0:
		if global_position.distance_to(target.global_position) <= attack_range:
			target.take_damage(attack_damage)
			attack_timer = attack_cooldown

	queue_redraw()

func get_nearest_zombie():
	var nearest = null
	var nearest_distance = INF
	for zombie in get_tree().get_nodes_in_group("zombies"):
		if not is_instance_valid(zombie):
			continue
		var d = global_position.distance_to(zombie.global_position)
		if d < nearest_distance:
			nearest_distance = d
			nearest = zombie
	return nearest

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Only start dragging if the mouse is close to this soldier.
			if global_position.distance_to(get_global_mouse_position()) <= 30:
				dragging = true
				drag_offset = global_position - get_global_mouse_position()
		else:
			dragging = false

func _draw():
	# Body
	draw_circle(Vector2.ZERO, 20, Color("#4e8bd0"))
	draw_circle(Vector2(0, -22), 10, Color("#f0c7a0"))
	draw_line(Vector2(12, 0), Vector2(32, -8), Color("#202020"), 5)
	draw_arc(Vector2.ZERO, 25, 0, TAU, 24, Color.WHITE, 2)
