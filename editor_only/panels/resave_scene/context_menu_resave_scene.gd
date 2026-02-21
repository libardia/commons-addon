extends EditorContextMenuPlugin


func _popup_menu(paths: PackedStringArray) -> void:
    var show := false
    for path in paths:
        if _path_is_scene(path):
            show = true
            break
    if show:
        add_context_menu_item(
            "Resave selected scene(s)", resave_scenes, EditorIcons.by_name("Save")
        )


func _path_is_scene(path: String) -> bool:
    return path.ends_with(".tscn") or path.ends_with(".scn")


func resave_scenes(paths: PackedStringArray) -> void:
    for path in paths:
        if _path_is_scene(path):
            EditorInterface.open_scene_from_path(path)
            if EditorInterface.save_scene() != OK:
                push_error("Error saving scene '", path, "'!")
            EditorInterface.close_scene()
