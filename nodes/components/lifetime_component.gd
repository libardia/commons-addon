class_name LifetimeComponent
extends Component


@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var lifetime: float


func _enter_tree() -> void:
    get_tree().create_timer(lifetime).timeout.connect(belongs_to.queue_free)
