class_name UILayer
extends CanvasLayer


@export var ui_scene: PackedScene


func _enter_tree() -> void:
    if ui_scene:
        add_child(ui_scene.instantiate())
