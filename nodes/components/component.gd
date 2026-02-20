@abstract class_name Component
extends Node


## The entity this component belongs to.
@export var belongs_to: Node
## If non-empty, will automatically add [member belongs_to] to this group in [code]_enter_tree()[/code]
@export var add_owner_to_group: StringName

func _enter_tree() -> void:
    unique_name_in_owner = true
    if not belongs_to:
        belongs_to = get_parent()
    if add_owner_to_group != &"":
        belongs_to.add_to_group(add_owner_to_group)
