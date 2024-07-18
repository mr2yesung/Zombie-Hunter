class_name Weapon
extends Node3D


const RECOIL_RECOVERY_RATE := 10.0

@export var weapon_mesh: Node3D
@export var damage: int
@export var magazine_capacity: int
@export var fire_rate: float
@export var recoil: float
@export var muzzle_flash: GPUParticles3D
@export var weapon_type: WeaponManager.MainWeapon

@onready var weapon_position := weapon_mesh.position


func _shoot() -> void:
	pass
