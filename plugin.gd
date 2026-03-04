@tool
extends EditorPlugin


const AUTOLOADS: Dictionary[String, String] = {
    "InputDetector": "globals/input_detector.gd"
}

static var _sub_plugins: Array[EditorSubPlugin] = [
    EditorSubPluginQuickExternalEditor.new(),
    EditorSubPlugin2DTools.new(),
    EditorSubPluginResaveAllScenes.new(),
    EditorSubPluginCtxResaveScene.new(),
]

var _addon_path: String


func _enable_plugin() -> void:
    _addon_path = get_script().get_path().get_base_dir()
    for autoload_name in AUTOLOADS:
        add_autoload_singleton(
            autoload_name,
            _addon_path.path_join(AUTOLOADS[autoload_name])
        )


func _disable_plugin() -> void:
    for autoload_name in AUTOLOADS:
        remove_autoload_singleton(autoload_name)


func _enter_tree() -> void:
    for esp in _sub_plugins:
        esp.enable(self)


func _exit_tree() -> void:
    for esp in _sub_plugins:
        esp.disable(self)
