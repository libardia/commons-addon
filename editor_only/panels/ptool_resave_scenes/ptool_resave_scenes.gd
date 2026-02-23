static var dialog: ConfirmationDialog


static func run() -> void:
    dialog = ConfirmationDialog.new()
    dialog.dialog_text = str(
        "All scenes in the project (except those in the res://addons folder)",
        " will be resaved. Continue?"
    )
    dialog.confirmed.connect(_confirm)
    dialog.canceled.connect(_cleanup)
    EditorInterface.get_base_control().add_child(dialog)
    dialog.popup_centered()


static func _confirm() -> void:
    _resave_scenes_recurse("res://")
    _cleanup()


static func _resave_scenes_recurse(dir: String) -> void:
    var da := DirAccess.open(dir)
    if dir.trim_suffix("/") == "res://addons" or da.file_exists(dir.path_join(".gdignore")):
        return
    for file in da.get_files():
        if file.ends_with(".tscn") or file.ends_with(".scn"):
            var path := dir.path_join(file)
            var already_open := path in EditorInterface.get_open_scenes()
            EditorInterface.open_scene_from_path(path)
            EditorInterface.save_scene()
            if EditorInterface.save_scene() != OK:
                push_error("Error saving scene '", path, "'!")
            if not already_open:
                EditorInterface.close_scene()
    for inner_dir in da.get_directories():
        _resave_scenes_recurse(dir.path_join(inner_dir))


static func _cleanup() -> void:
    dialog.queue_free()
