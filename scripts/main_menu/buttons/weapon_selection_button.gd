class_name WeaponSelectionButton
extends Button


## Weapon mesh that will be displayed on the SubViewport node
@export var weapon_mesh: PackedScene
## Weapon type that will be selected when clicking the button
@export var weapon_type: WeaponManager.MainWeapon

func render_weapon(weapon_displayer: Node3D) -> void:
	var mesh := weapon_mesh.instantiate()
	weapon_displayer.add_child(mesh)
