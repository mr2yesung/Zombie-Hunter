extends Node


@export var player: Player


var magazine_capacity: int = WeaponManager.magazine_capacity.get(WeaponManager.player_main_weapon)
var current_ammo := magazine_capacity:
	set(value):
		current_ammo = clampi(value, 0, magazine_capacity)
		player.update_label()

var remainder_ammo := 2 * magazine_capacity:
	set(value):
		remainder_ammo = max(value, 0)
		player.update_label()


func use_ammo() -> bool:
	if current_ammo < 1:
		return false
	
	current_ammo -= 1
	
	return true


func get_load_amount() -> int:
	return min(remainder_ammo, magazine_capacity - current_ammo)


func reload_ammo(load_amount: int) -> void:
	current_ammo += load_amount
	remainder_ammo -= load_amount


func add_supply() -> void:
	remainder_ammo += magazine_capacity
