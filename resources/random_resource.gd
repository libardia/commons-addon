class_name RandomResource
extends Resource


@export var choices: Array[Resource]


func choose(rng: RandomNumberGenerator = null) -> Resource:
    var i = rng.randi() if rng else randi()
    return choices[i % choices.size()]
