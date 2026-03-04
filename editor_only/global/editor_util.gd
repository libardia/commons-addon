@tool
class_name EditorUtil


static func file_is_scene(file: String) -> bool:
    return file.ends_with(".tscn") or file.ends_with(".scn")


static func resave_scene(path: String) -> void:
    var open_scenes := EditorInterface.get_open_scenes()
    _resave_one_scene_internal(path)
    if path not in open_scenes:
        EditorInterface.close_scene()


static func resave_scenes(paths: PackedStringArray) -> void:
    var open_scenes := EditorInterface.get_open_scenes()
    for path in paths:
        _resave_one_scene_internal(path)
        if path not in open_scenes:
            EditorInterface.close_scene()


static func _resave_one_scene_internal(path: String) -> void:
    EditorInterface.open_scene_from_path(path)
    if EditorInterface.save_scene() != OK:
        push_error("Error saving scene '", path, "'!")
