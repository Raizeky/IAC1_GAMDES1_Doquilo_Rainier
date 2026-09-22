extends Node2D

var score := 0
var money := 0
var game_finished := false

var soldier_scene = preload("res://Soldier.gd")
var zombie_scene = preload("res://Zombie.gd")

@onready var base = $Base
@onready var soldiers = $Soldiers
@onready var zombies = $Zombies
@onready var spawn_timer = $SpawnTimer
@onready var soldier_timer = $SoldierTimer
@onready var score_label = $UI/ScoreLabel
@onready var money_label = $UI/MoneyLabel
@onready var health_label = $UI/BaseHealthLabel
@onready var message_label = $UI/MessageLabel
@onready var game_over_label = $UI/GameOverLabel

func _ready():
	spawn_timer.timeout.connect(spawn_zombie)
	soldier_timer.timeout.connect(spawn_soldier)
	base.died.connect(end_game)
	spawn_soldier()
	update_ui()
	queue_redraw()

func _process(_delta):
	update_ui()
	queue_redraw()

func _draw():
	# Background
	draw_rect(Rect2(0, 0, 1000, 650), Color("#202b32"))
	# Play field
	draw_rect(Rect2(10, 95, 980, 480), Color("#344b3d"))
	# Road / ground line
	draw_rect(Rect2(10, 315, 980, 20), Color("#4e6650"))
	# Base area
	draw_rect(Rect2(790, 110, 180, 450), Color("#263c4c"), false, 4)

func spawn_zombie():
	if game_finished:
		return
	var zombie = CharacterBody2D.new()
	zombie.set_script(zombie_scene)
	zombie.position = Vector2(randf_range(40, 650), randf_range(140, 540))
	zombies.add_child(zombie)
	zombie.died.connect(zombie_killed)

func spawn_soldier():
	if game_finished:
		return
	var soldier = CharacterBody2D.new()
	soldier.set_script(soldier_scene)
	soldier.position = Vector2(690, randf_range(180, 500))
	soldiers.add_child(soldier)

func zombie_killed():
	score += 1
	money += 2

func update_ui():
	score_label.text = "Score: %d" % score
	money_label.text = "Money: $%d" % money
	health_label.text = "Base HP: %d / %d" % [base.health, base.max_health]
	if not game_finished:
		message_label.text = "Defend the Base!"

func end_game():
	game_finished = true
	spawn_timer.stop()
	soldier_timer.stop()
	message_label.text = ""
	game_over_label.text = "BASE DESTROYED!\nScore: %d\nPress R to Restart" % score
	game_over_label.visible = true

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R and game_finished:
			get_tree().reload_current_scene()
