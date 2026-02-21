@tool
extends TextureRect


@export var icon_name: StringName:
    set(value):
        icon_name = value
        texture = EditorIcons.by_name(icon_name)
