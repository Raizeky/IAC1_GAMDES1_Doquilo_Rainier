extends Node2D

signal died

var max_health := 200
var health := 200

func _ready():
	add_to_group("base")
	queue_redraw()

func _process(_delta):
	queue_redraw()

func take_damage(amount):
	health -= amount
	if health <= 0:
		health = 0
		died.emit()

func _draw():
	# Simple base
	draw_rect(Rect2(-65, -90, 130, 180), Color("#6f7780"))
	draw_rect(Rect2(-45, -70, 90, 140), Color("#89929a"))
	draw_rect(Rect2(-20, 15, 40, 55), Color("#30363b"))
	draw_rect(Rect2(-55, -105, 110, 18), Color("#4b5258"))
	draw_string(ThemeDB.fallback_font, Vector2(-50, 120), "BASE", HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.WHITE)
