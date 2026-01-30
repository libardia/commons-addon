@tool
extends EditorPlugin


const INPUT_DETECTOR := "InputDetector"


func _enable_plugin() -> void:
    add_autoload_singleton(INPUT_DETECTOR, "res://addons/commons/globals/input_detector.gd")


func _disable_plugin() -> void:
    remove_autoload_singleton(INPUT_DETECTOR)


func _enter_tree() -> void:
    # Initialization of the plugin goes here.
    pass


func _exit_tree() -> void:
    # Clean-up of the plugin goes here.
    pass
