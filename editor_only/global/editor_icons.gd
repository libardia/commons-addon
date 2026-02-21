@tool
class_name EditorIcons


static func by_name(name: StringName) -> Texture:
    return EditorInterface.get_base_control().get_theme_icon(name, &"EditorIcons")
