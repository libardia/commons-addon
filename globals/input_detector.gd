extends Node


enum Source { KEYBOARD_MOUSE, CONTROLLER }
enum Controller { NONE, XBOX, PLAYSTATION, SWITCH, GENERIC }

var current_source := Source.KEYBOARD_MOUSE
var current_controller_type := Controller.NONE
var deadzone_filter := 0.2

signal source_changed()


func _input(event: InputEvent) -> void:
    # Translate event to device type
    var source: Source = current_source
    var controller_type: Controller = current_controller_type
    if (
        (event is InputEventMouse and not event.relative.is_zero_approx()) or
        event is InputEventKey
    ):
        source = Source.KEYBOARD_MOUSE
        controller_type = Controller.NONE
    elif (
        (event is InputEventJoypadMotion and abs(event.axis_value) > deadzone_filter) or
        event is InputEventJoypadButton
    ):
        source = Source.CONTROLLER
        var device_name := Input.get_joy_name(event.device).to_lower()
        if device_name.contains("xbox"):
            controller_type = Controller.XBOX
        elif device_name.contains("dualsense"):
            controller_type = Controller.PLAYSTATION
        else:
            controller_type = Controller.GENERIC
    if source != current_source or controller_type != current_controller_type:
        current_source = source
        current_controller_type = controller_type
        source_changed.emit()
