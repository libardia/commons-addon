@abstract class_name Component
extends Node


## The entity this component belongs to. If [code]null[/code], this is assumed to
## be this node's parent.
@export var belongs_to: Node

func _enter_tree() -> void:
    unique_name_in_owner = true
    if not belongs_to:
        belongs_to = get_parent()
