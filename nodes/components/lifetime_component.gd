## Represents a node's lifetime. When that lifetime is up, the node can optionally
## be freed automatically.
class_name LifetimeComponent
extends Component


## Emitted when this node's lifetime is up.
signal timeout

## Amount of time, in seconds, for this node to live.
@export_custom(PROPERTY_HINT_RANGE, "0,60,or_greater,suffix:sec") var lifetime: float
## If the node should be freed when its lifetime is up. To use a custom function for
## end of life (i.e., an animation), set this to [code]false[/code] and connect to the [signal timeout] signal.
@export var free_on_timeout: bool = true

func _enter_tree() -> void:
    get_tree().create_timer(lifetime).timeout.connect(timeout.emit)
    timeout.connect(_on_timeout)


func _on_timeout() -> void:
    if free_on_timeout:
        get_parent().queue_free()
