@tool
class_name EditorSubPluginQuickExternalEditor
extends EditorSubPlugin


const CONTAINER := EditorPlugin.CONTAINER_TOOLBAR
const EXT_EDITOR_SETTING := "text_editor/external/use_external_editor"

var settings := EditorInterface.get_editor_settings()
var checkbox: CheckBox


func enable(plugin: EditorPlugin) -> void:
    # Set up the checkbox
    checkbox = CheckBox.new()
    checkbox.text = "Use External Editor"
    checkbox.toggled.connect(_on_toggled)
    settings.settings_changed.connect(_on_setting_changed)
    _on_setting_changed()

    # Add the control to the editor
    plugin.add_control_to_container(CONTAINER, checkbox)


func disable(plugin: EditorPlugin) -> void:
    plugin.remove_control_from_container(CONTAINER, checkbox)
    checkbox.free()


func _on_setting_changed() -> void:
    checkbox.set_pressed(settings.get(EXT_EDITOR_SETTING))


func _on_toggled(is_toggled: bool) -> void:
    settings.set(EXT_EDITOR_SETTING, is_toggled)
