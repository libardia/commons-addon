@tool
class_name ExtendedCollisionPolygon2D
extends CollisionPolygon2D


@export_tool_button("Move origin to center of mass") var calc_center := calculate_com

static var undo_redo: EditorUndoRedoManager

func calculate_com():
    var com = PolygonUtil.polygon_center_of_mass(polygon)

    var new_polygon: PackedVector2Array = []
    for p in polygon:
        new_polygon.append(p - com)

    undo_redo.create_action("Move origin to center of mass")

    undo_redo.add_do_property(self, "position", position + com)
    undo_redo.add_do_property(self, "polygon", new_polygon)

    undo_redo.add_undo_property(self, "position", position)
    undo_redo.add_undo_property(self, "polygon", polygon)

    undo_redo.commit_action()
