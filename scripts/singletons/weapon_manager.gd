extends Node


enum MainWeapon {
	MACHINE_GUN,
	ROCKET_LAUNCHER,
	SHOTGUN,
	SNIPER,
	UZI,
}

const magazine_capacity := {
	MainWeapon.MACHINE_GUN: 30,
	MainWeapon.ROCKET_LAUNCHER: 3,
	MainWeapon.SHOTGUN: 10,
	MainWeapon.SNIPER: 7,
	MainWeapon.UZI: 50,
}

var player_main_weapon := MainWeapon.MACHINE_GUN
