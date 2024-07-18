class_name Weapon
extends Node3D


const RECOIL_RECOVERY_RATE := 10.0

@export var weapon_mesh: Node3D
@export var magazine_capacity: int
@export var fire_rate: float
@export var recoil: float
@export var muzzle_flash: GPUParticles3D
@export var weapon_type: WeaponManager.MainWeapon
@export var cooldown_timer: Timer

@onready var weapon_position := weapon_mesh.position


func _shoot() -> void:
	pass


func fire() -> void:
	cooldown_timer.start(1.0 / fire_rate)
	
	weapon_mesh.position.z += recoil
	
	muzzle_flash.restart()


func recover_recoil(delta: float) -> void:
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * RECOIL_RECOVERY_RATE)
