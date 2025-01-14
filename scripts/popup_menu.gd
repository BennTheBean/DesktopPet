extends Node2D

enum PopupIds {
	CHANGE_ANIMATION,
}

@onready var toggle_button = get_parent().get_node("Button")  # Reference the button
@onready var menu = $Menu  # Reference the PopupMenu
signal toggle_movement

func _ready():
	# Connect the button's signal to this script
	toggle_button.connect("pressed", Callable(self, "_on_Button_pressed"))
	menu.add_item("Move", PopupIds.CHANGE_ANIMATION)

func _on_Button_pressed():
	# Toggle the visibility of the menu
	if menu.is_visible():
		menu.hide()
	else:
		# Show the popup near the mouse position
		menu.popup()


func _on_menu_id_pressed(id):
	match id:
		PopupIds.CHANGE_ANIMATION:
			emit_signal("toggle_movement")

func _on_menu_index_pressed(index):
	pass # Replace with function body.
