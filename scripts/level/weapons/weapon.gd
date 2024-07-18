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

# export variables cannot be used before onready
@onready var current_ammo := magazine_capacity:
	set(value):
		current_ammo = clampi(value, 0, magazine_capacity)
@onready var weapon_position := weapon_mesh.position


func _shoot(callback: Callable) -> void:
	if not cooldown_timer.is_stopped():
		return
	
	if not use_ammo():
		return
	
	cooldown_timer.start(1.0 / fire_rate)
	
	weapon_mesh.position.z += recoil
	
	muzzle_flash.restart()
	
	callback.call()


func recover_recoil(delta: float) -> void:
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * RECOIL_RECOVERY_RATE)


func use_ammo() -> bool:
	if current_ammo < 1:
		return false
	
	current_ammo -= 1
	return true
