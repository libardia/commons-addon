@tool
extends PopupMenu


static var urm := EditorInterface.get_editor_undo_redo()


func _on_id_pressed(id: int) -> void:
    match id:
        0: _adjust_origin_com()


func _adjust_origin_com() -> void:
    urm.create_action("Adjust polygon's origin for CollisionPolygon2D node(s)")
    for node in EditorInterface.get_selection().get_selected_nodes():
        if node is CollisionPolygon2D:
            var com := PolygonUtil.polygon_center_of_mass(node.polygon)
            urm.add_undo_property(node, "position", node.position)
            urm.add_undo_property(node, "polygon", node.polygon)
            urm.add_do_property(node, "position", node.position + com)
            urm.add_do_property(node, "polygon", PolygonUtil.offset_polygon(node.polygon, -com))
    urm.commit_action()
