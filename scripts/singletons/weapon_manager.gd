extends Node


enum MainWeapon {
	MACHINE_GUN,
	ROCKET_LAUNCHER,
	SHOTGUN,
	SNIPER,
	UZI,
}

const MAGAZINE_CAPACITY := {
	MainWeapon.MACHINE_GUN: 30,
	MainWeapon.ROCKET_LAUNCHER: 3,
	MainWeapon.SHOTGUN: 10,
	MainWeapon.SNIPER: 7,
	MainWeapon.UZI: 50,
}

const AIM_MULTIPLIER := {
	MainWeapon.MACHINE_GUN: 0.6,
	MainWeapon.ROCKET_LAUNCHER: 0.8,
	MainWeapon.SHOTGUN: 0.8,
	MainWeapon.SNIPER: 0.4,
	MainWeapon.UZI: 0.7,
}

var player_main_weapon := MainWeapon.MACHINE_GUN
