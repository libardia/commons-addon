@tool
extends "res://addons/commons/editor_only/button_editor_icon.gd"


func _on_pressed() -> void:
    EditorInterface.get_editor_toaster().push_toast("This panel was added by the Commons addon.")
