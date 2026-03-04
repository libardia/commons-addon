@tool
class_name ButtonEditorIcon
extends Button


@export var icon_name: StringName:
    set(value):
        icon_name = value
        if is_node_ready():
            icon = EditorIcons.by_name(icon_name)
