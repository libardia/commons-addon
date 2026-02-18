@tool
extends Button


@export var icon_name: StringName:
    set(value):
        icon_name = value
        icon = EditorIcons.by_name(icon_name)
