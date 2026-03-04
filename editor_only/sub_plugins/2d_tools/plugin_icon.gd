@tool
extends ButtonEditorIcon


func _ready() -> void:
    pressed.connect(_on_pressed)


func _on_pressed() -> void:
    EditorInterface.get_editor_toaster().push_toast("This panel was added by the Commons addon.")
