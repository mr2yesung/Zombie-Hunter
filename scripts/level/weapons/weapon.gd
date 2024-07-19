class_name Weapon
extends Node3D


const RECOIL_RECOVERY_RATE := 10.0

@export var weapon_mesh: Node3D
@export var fire_rate: float
@export var recoil: float
@export var muzzle_flash: GPUParticles3D
@export var weapon_type: WeaponManager.MainWeapon
@export var cooldown_timer: Timer
@export var gun_sound_player: PackedScene
@export var gun_reload_player: PackedScene
@export var reload_time: float

var reloading := false

@onready var weapon_position := weapon_mesh.position
@onready var player := get_tree().get_first_node_in_group("player") as Player


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		if not reloading:
			var load_amount: int = player.ammo_manager.get_load_amount()
			
			if load_amount > 0:
				reloading = true
				play_reload_sound()
				var tween := create_tween()
				tween.tween_interval(reload_time)
				tween.tween_callback(reload.bind(load_amount))


func _shoot(callback: Callable) -> void:
	if reloading:
		return
		
	if not cooldown_timer.is_stopped():
		return
	
	if not player.ammo_manager.use_ammo():
		return
	
	cooldown_timer.start(1.0 / fire_rate)
	
	weapon_mesh.position.z += recoil
	
	muzzle_flash.restart()
	
	var sound = gun_sound_player.instantiate()
	add_child(sound)
	
	callback.call()


func recover_recoil(delta: float) -> void:
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * RECOIL_RECOVERY_RATE)


func reload(load_amount: int) -> void:
	play_reload_sound()
	
	player.ammo_manager.reload_ammo(load_amount)
	
	reloading = false


func play_reload_sound() -> void:
	var gun_reload_sound = gun_reload_player.instantiate()
	add_child(gun_reload_sound)
