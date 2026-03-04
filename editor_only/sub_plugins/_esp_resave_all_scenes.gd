@tool
class_name EditorSubPluginResaveAllScenes
extends EditorSubPlugin


const NAME := "Commons: Resave all scenes"

var dialog: ConfirmationDialog


func enable(plugin: EditorPlugin) -> void:
    plugin.add_tool_menu_item(NAME, run)


func disable(plugin: EditorPlugin) -> void:
    plugin.remove_tool_menu_item(NAME)


func run() -> void:
    dialog = ConfirmationDialog.new()
    dialog.dialog_text = str(
        "All scenes in the project (except those in the res://addons folder)",
        " will be resaved. Continue?"
    )
    dialog.confirmed.connect(_confirm)
    dialog.canceled.connect(_cleanup)
    EditorInterface.get_base_control().add_child(dialog)
    dialog.popup_centered()


func _confirm() -> void:
    var scene_paths: Array[String] = []
    _find_all_scenes("res://", scene_paths)
    EditorUtil.resave_scenes(scene_paths)
    _cleanup()


func _find_all_scenes(dir: String, acc: Array[String]) -> void:
    var da := DirAccess.open(dir)
    if dir.trim_suffix("/") == "res://addons" or da.file_exists(dir.path_join(".gdignore")):
        return
    for file in da.get_files():
        if EditorUtil.file_is_scene(file):
            acc.append(dir.path_join(file))
    for inner_dir in da.get_directories():
        _find_all_scenes(dir.path_join(inner_dir), acc)


func _cleanup() -> void:
    dialog.queue_free()
