@tool
extends BoxContainer


@onready var tools := get_tree().get_nodes_in_group(&"commons_2d_tool_node_specific")


func _ready() -> void:
    for tool in tools:
        EditorInterface.get_selection().selection_changed.connect(tool._on_selection_changed)
