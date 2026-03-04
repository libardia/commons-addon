@tool
class_name EditorSubPlugin2DTools
extends EditorSubPlugin


const PANEL_2D_TOOLS = preload("uid://cepebcwn18u6m")
const CONTAINER := EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT
static var _instance: Node


func enable(plugin: EditorPlugin) -> void:
    _instance = PANEL_2D_TOOLS.instantiate()
    plugin.add_control_to_container(CONTAINER, _instance)


func disable(plugin: EditorPlugin) -> void:
    plugin.remove_control_from_container(CONTAINER, _instance)
    _instance.free()
