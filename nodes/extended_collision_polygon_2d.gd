@tool
class_name ExtendedCollisionPolygon2D
extends CollisionPolygon2D


@export_tool_button("Move origin to center of mass") var calc_center := calculate_com

func calculate_com():
    # Ignore this entirely if running ingame
    if Engine.is_editor_hint():
        # Get the editor's undo redo manager
        var undo_redo = EditorInterface.get_editor_undo_redo()
        # Calculate center of mass
        var com = PolygonUtil.polygon_center_of_mass(polygon)
        # New undo-able action
        undo_redo.create_action("Move origin to center of mass")
        # Set these properties on do
        undo_redo.add_do_property(self, "position", position + com)
        undo_redo.add_do_property(self, "polygon", PolygonUtil.offset_polygon(polygon, -com))
        # Set these properties on undo
        undo_redo.add_undo_property(self, "position", position)
        undo_redo.add_undo_property(self, "polygon", polygon)
        # Execute the action
        undo_redo.commit_action()
