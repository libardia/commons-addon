## Tracks a resource the parent node has, such as health or stamina.
class_name ResourceComponent
extends Component


signal depleted
signal changed(amount: float, actual_change: float)

## The current value of this resource.
@export var current: int
## The maximum value of this resource. If [member capped] is [code]true[/code],
## [member current] will be clamped to this value.
@export var max_value: int
## If [member current] should be clamped to [member max_value].
@export var capped: bool = true
## When [code]true[/code], the value of this resource cannot be changed.
@export var locked: bool = false
@export_group("When Depleted", "when_depleted_")
## If this resource should automatically lock when depleted, preventing changes.
## If necessary, it can be unlocked by setting [member locked] to [code]false[/code].
@export var when_depleted_lock: bool = false
## If the node should be freed when this resource is depleted. Specifically,
## [code]get_parent().queue_free()[/code] will be called.
@export var when_depleted_free_parent: bool = false


func _init() -> void:
    depleted.connect(_on_depleted)


func damage(amount: int) -> void:
    adjust(-amount)


func heal(amount: int) -> void:
    adjust(amount)


func adjust(amount: int) -> void:
    if not locked:
        var before := current
        current += amount
        if capped and current > max_value:
            current = max_value
        if current < 0:
            current = 0
        changed.emit(amount, current - before)
        if before > 0 and current == 0:
            depleted.emit()


func is_full() -> bool:
    return current == max_value


func is_empty() -> bool:
    return current == 0


func _on_depleted() -> void:
    if when_depleted_lock:
        locked = true
    if when_depleted_free_parent:
        get_parent().queue_free()
