extends CharacterBody2D

var health = 100
var defense = 50
var speed = 35
var player_name = "Kuya Ben"

func _ready():
	print(player_name, " has entered the scene with ", health, " HP.")
	print(player_name, " has ", defense, " defense.")
	print(player_name, " has ", speed, " speed.")
	
	position.x = 700
	position.y = 500
	print()

	take_damage(30)
	break_defense(15)
	slow_debuff(20)
	
func take_damage(amount):
	health-=amount
	print(player_name, " receive ", amount, " damage!")
	print("Ouch! Health is now: ", health)
	
func break_defense(amount):
	defense-=amount
	print(player_name, " receive ", amount, " armor damage!")
	print("Hit! Defense is now: ", defense)
	
func slow_debuff(amount):
	speed -=amount
	print(player_name, " receive ", amount, " slow defuff!")
	print("Speed is now: ", speed)
