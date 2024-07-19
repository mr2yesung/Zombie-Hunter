extends Area3D


const SUPPLY_COOLDOWN_TIME := 10.0

@export var ammo_machine_gun: PackedScene
@export var ammo_rocket_launcher: PackedScene
@export var ammo_sniper: PackedScene
@export var ammo_shotgun: PackedScene
@export var ammo_uzi: PackedScene

var charged := false

@onready var supply_cooldown_timer: Timer = $SupplyCooldownTimer
@onready var ammo_mesh: Node3D = $AmmoMesh
@onready var pickup_sound_player: AudioStreamPlayer3D = $PickupSoundPlayer


func _ready() -> void:
	ammo_mesh.add_child(get_ammo_mesh().instantiate())
	ammo_mesh.visible = false
	
	supply_cooldown_timer.start(SUPPLY_COOLDOWN_TIME)


func _on_supply_cooldown_timer_timeout() -> void:
	ammo_mesh.visible = true
	charged = true


func _on_body_entered(body: Node3D) -> void:
	if charged and body is Player:
		body.ammo_manager.add_supply()
		
		pickup_sound_player.play(0.0)
		
		charged = false
		ammo_mesh.visible = false
		supply_cooldown_timer.start(SUPPLY_COOLDOWN_TIME)


func get_ammo_mesh() -> PackedScene:
	match WeaponManager.player_main_weapon:
		WeaponManager.MainWeapon.MACHINE_GUN:
			return ammo_machine_gun
		WeaponManager.MainWeapon.ROCKET_LAUNCHER:
			return ammo_rocket_launcher
		WeaponManager.MainWeapon.SHOTGUN:
			return ammo_shotgun
		WeaponManager.MainWeapon.SNIPER:
			return ammo_sniper
		WeaponManager.MainWeapon.UZI:
			return ammo_uzi
		_:
			return ammo_machine_gun
