class_name Set


var _backing_dict: Dictionary[Variant, bool] = {}


func add(item: Variant) -> bool:
    if has(item):
        return false
    else:
        _backing_dict[item] = true
        return true


func add_all(items: Array):
    for i in items:
        add(i)


func remove(item: Variant) -> bool:
    if has(item):
        _backing_dict.erase(item)
        return true
    else:
        return false


func has(item: Variant) -> bool:
    return _backing_dict.has(item)


func items() -> Array[Variant]:
    return _backing_dict.keys()
