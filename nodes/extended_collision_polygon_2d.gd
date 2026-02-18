@tool
class_name ExtendedCollisionPolygon2D
extends CollisionPolygon2D


# This is a Variant because EditorUndoRedoManager isn't available when the game is built
static var _undo_redo: Variant

@export_tool_button("Move origin to center of mass") var calc_center := calculate_com


func calculate_com() -> void:
    # Ignore this entirely if running ingame
    if Engine.is_editor_hint():
        # Calculate center of mass
        var com := PolygonUtil.polygon_center_of_mass(polygon)
        # New undo-able action
        _undo_redo.create_action("Move origin to center of mass")
        # Set these properties on do
        _undo_redo.add_do_property(self, "position", position + com)
        _undo_redo.add_do_property(self, "polygon", PolygonUtil.offset_polygon(polygon, -com))
        # Set these properties on undo
        _undo_redo.add_undo_property(self, "position", position)
        _undo_redo.add_undo_property(self, "polygon", polygon)
        # Execute the action
        _undo_redo.commit_action()
