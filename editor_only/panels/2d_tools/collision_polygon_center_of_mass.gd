@tool
extends BoxContainer


var _act_on: CollisionPolygon2D
@onready var button: Button = $Button


func _enter_tree() -> void:
    #self.icon = get_theme_icon(&"CurveCenter", &"EditorIcons")
    pass


func _on_selection_changed() -> void:
    var selected := EditorInterface.get_selection().get_selected_nodes()
    var applicable := selected.size() == 1 and selected[0] is CollisionPolygon2D
    if applicable:
        _act_on = selected[0]
    else:
        _act_on = null
    visible = applicable


func _do() -> void:
    var coll_poly: CollisionPolygon2D = EditorInterface.get_selection().get_selected_nodes()[0]
