class_name NodeUtil


static func absolute_z(node: Node2D) -> int:
    var working := node
    var z_index := 0
    while working and working is Node2D:
        z_index += working.z_index
        if not working.z_as_relative:
            break
        working = working.get_parent()
    return z_index
