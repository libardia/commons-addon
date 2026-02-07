class_name WeightedRandomResource
extends RandomResource


@export var weights: Array[float]


func choose(rng: RandomNumberGenerator = null) -> Resource:
    assert(weights.size() == choices.size(), "'choices' and 'weights' must be the same length.")
    var f = rng.randf() if rng else randf()
    var result = f * weights.reduce(func(acc, elem): return acc + elem, 0)
    var cursor = 0.0
    for i in choices.size():
        cursor += weights[i]
        if result < cursor:
            return choices[i]
    assert(false, "'choose' of WeightedRandomResource never found a choice!")
    return null
