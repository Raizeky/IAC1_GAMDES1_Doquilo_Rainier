extends CharacterBody2D

signal died

var health := 100
var speed := 45.0
var attack_range := 35.0
var attack_damage := 8
var attack_cooldown := 0.8
var attack_timer := 0.0

func _ready():
	add_to_group("zombies")
	queue_redraw()

func _process(delta):
	attack_timer -= delta

	var target = get_target()

	if target:
		var distance = global_position.distance_to(target.global_position)

		if distance > attack_range:
			velocity = global_position.direction_to(target.global_position) * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			if attack_timer <= 0:
				if target.has_method("take_damage"):
					target.take_damage(attack_damage)
				attack_timer = attack_cooldown

	queue_redraw()

func get_target():
	var nearest = null
	var nearest_distance = INF

	# Zombie chooses the closest soldier or base.
	for soldier in get_tree().get_nodes_in_group("soldiers"):
		if not is_instance_valid(soldier):
			continue
		var d = global_position.distance_to(soldier.global_position)
		if d < nearest_distance:
			nearest_distance = d
			nearest = soldier

	var base = get_tree().get_first_node_in_group("base")
	if base:
		var d = global_position.distance_to(base.global_position)
		if d < nearest_distance:
			nearest_distance = d
			nearest = base

	return nearest

func take_damage(amount):
	health -= amount
	if health <= 0:
		died.emit()
		queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 18, Color("#69a84f"))
	draw_circle(Vector2(-7, -4), 3, Color.BLACK)
	draw_circle(Vector2(7, -4), 3, Color.BLACK)
	draw_line(Vector2(-7, 7), Vector2(7, 7), Color("#202020"), 3)
