@tool
extends PopupMenu


static var urm := EditorInterface.get_editor_undo_redo()


func _on_id_pressed(id: int) -> void:
    match id:
        0: _adjust_origin_com()


func _adjust_origin_com() -> void:
    urm.create_action("Adjust polygon's origin for CollisionPolygon2D node(s)")
    _do_for_each_in_selection(func(cp: CollisionPolygon2D) -> void:
        var com := PolygonUtil.polygon_center_of_mass(cp.polygon)
        urm.add_undo_property(cp, "position", cp.position)
        urm.add_undo_property(cp, "polygon", cp.polygon)
        urm.add_do_property(cp, "position", cp.position + com)
        urm.add_do_property(cp, "polygon", PolygonUtil.offset_polygon(cp.polygon, -com))
    )
    urm.commit_action()


func _do_for_each_in_selection(action: Callable) -> void:
    for node in EditorInterface.get_selection().get_selected_nodes():
        if node is CollisionPolygon2D:
            action.call(node)
