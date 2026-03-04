@tool
extends ButtonEditorIcon


@onready var popup_menu: PopupMenu = $PopupMenu


func _ready() -> void:
    pressed.connect(_on_pressed)
    EditorInterface.get_selection().selection_changed.connect(_on_selection_changed)


func _on_selection_changed() -> void:
    var selection := EditorInterface.get_selection().get_selected_nodes()
    for node in selection:
        if node is CollisionPolygon2D:
            show()
            return
    hide()

func _on_pressed() -> void:
    popup_menu.popup(Rect2i(DisplayServer.mouse_get_position(), Vector2i.ZERO))
