class_name RandomResource
extends Resource


@export var choices: Array[Resource]


## Choose one of the options at random, but if the result is also a RandomResource, choose again,
## and continue until a non-RandomResource is found.
func choose(rng: RandomNumberGenerator = null) -> Resource:
    var r = choose_once(rng)
    while r is RandomResource:
        r = r.choose_once(rng)
    return r


## Choose one of the options at random, with equal probability.
func choose_once(rng: RandomNumberGenerator = null) -> Resource:
    var i = rng.randi() if rng else randi()
    return choices[i % choices.size()]


static func with(...choices: Array) -> RandomResource:
    var rr = RandomResource.new()
    rr.choices.assign(choices)
    return rr
