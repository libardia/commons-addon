@tool
extends EditorPlugin

const INPUT_DETECTOR := "InputDetector"

const _2D_TOOLS_PANEL: PackedScene = preload("uid://cepebcwn18u6m")
var _2d_tools_panel: Control

const ContextMenuResaveScene = preload("uid://c4u1otp7tjot3")
var context_resave_scene: ContextMenuResaveScene

var _addon_path: String


func _enable_plugin() -> void:
    _addon_path = get_script().get_path().get_base_dir()
    add_autoload_singleton(INPUT_DETECTOR, _addon_path.path_join("globals/input_detector.gd"))


func _disable_plugin() -> void:
    remove_autoload_singleton(INPUT_DETECTOR)


func _enter_tree() -> void:
    _2d_tools_panel = _2D_TOOLS_PANEL.instantiate()
    add_control_to_container(CONTAINER_CANVAS_EDITOR_SIDE_LEFT, _2d_tools_panel)
    context_resave_scene = ContextMenuResaveScene.new()
    add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, context_resave_scene)


func _exit_tree() -> void:
    remove_control_from_container(CONTAINER_CANVAS_EDITOR_SIDE_LEFT, _2d_tools_panel)
    remove_context_menu_plugin(context_resave_scene)
