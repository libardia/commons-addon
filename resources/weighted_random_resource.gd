class_name WeightedRandomResource
extends RandomResource


@export var weights: Array[float]


func _init() -> void:
    _check_config.call_deferred()


## Choose one of the options at random, weighted corresponding to the weights array.
func choose_once(rng: RandomNumberGenerator = null) -> Resource:
    _check_config()
    var f := rng.randf() if rng else randf()
    var result := f * _total_weight()
    var cursor := 0.0
    for i in choices.size():
        cursor += weights[i]
        if result <= cursor:
            return choices[i]
    assert(false, "'choose' of WeightedRandomResource never found a choice!")
    return null


func _total_weight() -> float:
    var total_weight := 0.0
    for w: float in weights:
        total_weight += w
    return total_weight



func _check_config() -> void:
    assert(
        weights.size() == choices.size(),
        "'choices' and 'weights' must be the same length."
    )
