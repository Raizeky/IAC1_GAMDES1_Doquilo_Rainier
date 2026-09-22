# Zombie Base Defense - Godot 4

## How to run
1. Open Godot 4.
2. Choose **Import**.
3. Select this folder or `project.godot`.
4. Press F6/F5 to run.

## Controls
- Left-click directly on a soldier and drag it to move it.
- Soldiers automatically attack nearby zombies.
- Zombies automatically attack the closest soldier or the base.
- Press R after game over to restart.

## Game rules
- A zombie spawns every 2.5 seconds.
- A soldier is produced every 5 seconds.
- Killing a zombie gives +1 score and +$10.
- Base starts with 200 HP.
- Soldiers deal 20 damage every 0.7 seconds.
- Zombies have 50 HP and deal 8 damage every 0.8 seconds.

## Project structure
Main.tscn
├── Main
├── Base
├── Soldiers
├── Zombies
├── SpawnTimer
├── SoldierTimer
└── UI

Scripts:
- Main.gd
- Base.gd
- Soldier.gd
- Zombie.gd

The game intentionally uses simple code and placeholder shapes, so you can replace the drawings later with sprites.


Fixed parser errors: Main.gd now uses game_finished/end_game consistently.
