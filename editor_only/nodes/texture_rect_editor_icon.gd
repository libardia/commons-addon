@tool
class_name TextureRectEditorIcon
extends TextureRect


@export var icon_name: StringName:
    set(value):
        icon_name = value
        if is_node_ready():
            texture = EditorIcons.by_name(icon_name)
