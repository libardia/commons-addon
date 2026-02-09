class_name OwnedArea2D
extends Area2D


## The node to which this Area2D belongs. If null, this will be assumed to be its parent.
@export var owned_by: Node


func _enter_tree() -> void:
    if not owned_by:
        owned_by = get_parent()
