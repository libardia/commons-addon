@tool
class_name UILayer
extends CanvasLayer


@export var ui_scene: PackedScene:
    set(value):
        ui_scene = value
        _refresh()

@export var show_in_editor: bool = false:
    set(value):
        show_in_editor = value
        _refresh()

var _ui_instance: Node


func _enter_tree() -> void:
    _refresh()


func _refresh() -> void:
    # not (e and not s) = not e or s
    var should_show := not Engine.is_editor_hint() or show_in_editor
    if should_show:
        if _ui_instance:
            _ui_instance.queue_free()
        if ui_scene:
            _ui_instance = ui_scene.instantiate()
            add_child(_ui_instance)
    elif not should_show and _ui_instance:
        _ui_instance.queue_free()
