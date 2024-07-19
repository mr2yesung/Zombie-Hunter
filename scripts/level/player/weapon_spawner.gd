extends Node


@export var weapon_parent_camera: Camera3D

var gun: Weapon

@export var machine_gun_scene: PackedScene
@export var sniper_scene: PackedScene
@export var uzi_scene: PackedScene
@export var rocket_launcher_scene: PackedScene
@export var shotgun_scene: PackedScene


func _ready() -> void:
	gun = instantiate_weapon(WeaponManager.player_main_weapon) as Weapon
	weapon_parent_camera.add_child(gun)


func instantiate_weapon(weapon_type: WeaponManager.MainWeapon) -> Node:
	match weapon_type:
		WeaponManager.MainWeapon.MACHINE_GUN:
			return machine_gun_scene.instantiate()
		WeaponManager.MainWeapon.ROCKET_LAUNCHER:
			return rocket_launcher_scene.instantiate()
		WeaponManager.MainWeapon.SHOTGUN:
			return shotgun_scene.instantiate()
		WeaponManager.MainWeapon.SNIPER:
			return sniper_scene.instantiate()
		WeaponManager.MainWeapon.UZI:
			return uzi_scene.instantiate()
		_:
			return machine_gun_scene.instantiate()
