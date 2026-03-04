@tool
class_name EditorSubPluginCtxResaveScene
extends EditorSubPlugin


const SLOT := EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM
var _instance: Inner = Inner.new()


func enable(plugin: EditorPlugin) -> void:
    plugin.add_context_menu_plugin(SLOT, _instance)


func disable(plugin: EditorPlugin) -> void:
    plugin.remove_context_menu_plugin(_instance)


class Inner extends EditorContextMenuPlugin:
    func _popup_menu(paths: PackedStringArray) -> void:
        var show := false
        for path in paths:
            if EditorUtil.file_is_scene(path):
                show = true
                break
        if show:
            add_context_menu_item(
                "Resave selected scene(s)",
                _resave_scenes,
                EditorIcons.by_name("Save")
            )


    func _resave_scenes(paths: Array[String]) -> void:
        EditorUtil.resave_scenes(paths.filter(EditorUtil.file_is_scene))
