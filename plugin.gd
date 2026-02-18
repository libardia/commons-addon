@tool
extends EditorPlugin

const INPUT_DETECTOR := "InputDetector"
const _2D_TOOLS_PANEL = preload("uid://cepebcwn18u6m")

var _addon_path: String
var _2d_tools_panel: Control


func _enable_plugin() -> void:
    _addon_path = get_script().get_path().get_base_dir()
    add_autoload_singleton(INPUT_DETECTOR, _addon_path.path_join("globals/input_detector.gd"))


func _disable_plugin() -> void:
    remove_autoload_singleton(INPUT_DETECTOR)


func _enter_tree() -> void:
    _2d_tools_panel = _2D_TOOLS_PANEL.instantiate()
    add_control_to_container(CONTAINER_CANVAS_EDITOR_SIDE_LEFT, _2d_tools_panel)


func _exit_tree() -> void:
    remove_control_from_container(CONTAINER_CANVAS_EDITOR_SIDE_LEFT, _2d_tools_panel)
