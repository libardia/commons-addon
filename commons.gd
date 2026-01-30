@tool
extends EditorPlugin


const INPUT_DETECTOR := "InputDetector"


func _enable_plugin() -> void:
    var addon_path: String = get_script().get_path().get_base_dir()
    add_autoload_singleton(INPUT_DETECTOR, addon_path.path_join("globals/input_detector.gd"))


func _disable_plugin() -> void:
    remove_autoload_singleton(INPUT_DETECTOR)


func _enter_tree() -> void:
    # Initialization of the plugin goes here.
    pass


func _exit_tree() -> void:
    # Clean-up of the plugin goes here.
    pass
