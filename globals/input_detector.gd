extends Node


enum InputSource { KEYBOARD_MOUSE, CONTROLLER }
enum ControllerType { NONE, XBOX, PLAYSTATION, SWITCH, GENERIC }

var current_source := InputSource.KEYBOARD_MOUSE
var current_controller_type := ControllerType.NONE

signal source_changed()


func _input(event: InputEvent) -> void:
    # Translate event to device type
    var source: InputSource = current_source
    var controller_type: ControllerType = current_controller_type
    if event is InputEventMouse or event is InputEventKey:
        source = InputSource.KEYBOARD_MOUSE
        controller_type = ControllerType.NONE
    elif (
        (event is InputEventJoypadMotion and abs(event.axis_value) > 0.2) or
        event is InputEventJoypadButton
    ):
        source = InputSource.CONTROLLER
        var device_name := Input.get_joy_name(event.device).to_lower()
        if device_name.contains("xbox"):
            controller_type = ControllerType.XBOX
        elif device_name.contains("dualsense"):
            controller_type = ControllerType.PLAYSTATION
        else:
            controller_type = ControllerType.GENERIC
    if source != current_source or controller_type != controller_type:
        current_source = source
        current_controller_type = controller_type
        source_changed.emit()
