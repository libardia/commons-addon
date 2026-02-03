extends Node


enum Source { KEYBOARD_MOUSE, CONTROLLER }
enum Controller { NONE, XBOX, PLAYSTATION, SWITCH, GENERIC }

var current_source := Source.KEYBOARD_MOUSE
var current_controller_type := Controller.NONE
var deadzone_filter := 0.2

signal source_changed()


func _ready() -> void:
    # Emit event once as the first scene is ready
    get_tree().current_scene.ready.connect(log_and_emit)
    # Emit event once whenever the scene is changed (happens after ready)
    get_tree().scene_changed.connect(log_and_emit)


func _input(event: InputEvent) -> void:
    # Translate event to device type
    var source: Source = current_source
    var controller_type: Controller = current_controller_type
    if (
        (event is InputEventMouseMotion and not event.relative.is_zero_approx()) or
        event is InputEventMouseButton or
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
        log_and_emit()


func is_mkb() -> bool:
    return current_source == Source.KEYBOARD_MOUSE


func is_controller() -> bool:
    return not is_mkb()


func log_and_emit():
    print(
        "InputDetector: ",
        "Input source changed: ",
        "source ", Source.keys()[current_source], ", ",
        "controller ", Controller.keys()[current_controller_type],
    )
    source_changed.emit()
