class_name OwnedArea2D
extends Area2D


## The node to which this Area2D belongs. If null, this will be assumed to be its parent.
@export var owned_by: Node2D:
    get: return owned_by if owned_by else get_parent()
