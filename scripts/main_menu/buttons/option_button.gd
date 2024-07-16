extends OptionButton


func _ready() -> void:
	pressed.connect(_on_button_pressed)


# button press sound play when the button is pressed
# i.e, pressed and displays the dropdown menu
func _on_button_pressed():
	AudioPlayer.play_click()
