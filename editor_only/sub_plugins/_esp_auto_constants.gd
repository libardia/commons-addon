@tool
class_name EditorSubPluginAutoConstants
extends EditorSubPlugin


const GROUPS_SECTION := "[global_group]"
const GROUPS_SETTING := "global_group/"
const ACTIONS_SETTING := "input/"
const GEN_SCRIPTS_PATH := "res://_generated_scripts"
const GROUP_SCRIPT := "_groups_generated.gd"
const ACTION_SCRIPT := "_actions_generated.gd"

static var _const_regex := RegEx.create_from_string("[A-Z1-9_]")
static var _digit_regex := RegEx.create_from_string("[1-9]")

var _rfs: EditorFileSystem
var group_defs: Dictionary[String, String]
var action_defs: Dictionary[String, String]


func enable(_plugin: EditorPlugin) -> void:
    ProjectSettings.settings_changed.connect(_on_settings_changed)
    _rfs = EditorInterface.get_resource_filesystem()
    _parse_global_groups()
    _parse_actions()
    _generate_constants_script(GROUP_SCRIPT, "Groups", group_defs)
    _generate_constants_script(ACTION_SCRIPT, "Actions", action_defs)
    #BUG: Removing an input action DOES NOT EMIT settings_changed. I don't know
    #     what I can possibly do about that.


func disable(_plugin: EditorPlugin) -> void:
    ProjectSettings.settings_changed.disconnect(_on_settings_changed)
    group_defs = {}
    action_defs = {}


func _on_settings_changed() -> void:
    var changed_groups := false
    var changed_actions := false
    for setting in ProjectSettings.get_changed_settings():
        print(setting)
        if setting.begins_with(GROUPS_SETTING):
            changed_groups = true
            var group_raw := setting.trim_prefix(GROUPS_SETTING)
            var group_value := _escape_quote_string(group_raw, "&")
            var group_const := _string_to_const_name(group_raw)
            if ProjectSettings.has_setting(setting):
                group_defs[group_const] = group_value
            else:
                group_defs.erase(group_const)
        elif setting.begins_with(ACTIONS_SETTING):
            changed_actions = true
            var action_raw := setting.trim_prefix(ACTIONS_SETTING)
            var action_value := _escape_quote_string(action_raw, "&")
            var action_const := _string_to_const_name(action_raw)
            if ProjectSettings.has_setting(setting):
                action_defs[action_const] = action_value
            else:
                action_defs.erase(action_const)
        if changed_groups:
            _generate_constants_script(GROUP_SCRIPT, "Groups", group_defs)
        if changed_actions:
            _generate_constants_script(ACTION_SCRIPT, "Actions", action_defs)
        if changed_groups or changed_actions:
            _rfs.scan()


func _get_scripts_dir() -> DirAccess:
    if not DirAccess.dir_exists_absolute(GEN_SCRIPTS_PATH):
        DirAccess.make_dir_recursive_absolute(GEN_SCRIPTS_PATH)
    return DirAccess.open(GEN_SCRIPTS_PATH)


func _parse_actions() -> void:
    InputMap.load_from_project_settings()
    for action in InputMap.get_actions():
        var action_const := _string_to_const_name(action)
        var action_value := _escape_quote_string(action, "&")
        action_defs[action_const] = action_value

func _parse_global_groups() -> void:
    group_defs = {}

    var root_files := DirAccess.get_files_at("res://")
    var project_file_path: String
    for f in root_files:
        if f.ends_with(".godot"):
            project_file_path = "res://".path_join(f)
            break
    if project_file_path.is_empty():
        push_error(
            "Couldn't find project file! Global groups couldn't be",
            " parsed, but something worse is probably happening."
        )
        return
    var project_file := FileAccess.open(project_file_path, FileAccess.READ)

    var found_groups: bool = false
    var line: String = ""
    while project_file.get_position() < project_file.get_length():
        line = project_file.get_line()
        if line == GROUPS_SECTION:
            found_groups = true
            break
    while found_groups and project_file.get_position() < project_file.get_length():
        line = project_file.get_line()
        if line.begins_with("["):
            break
        elif not line.is_empty():
            var group := _unescape_unquote_string(line.get_slice("=", 0))
            var group_const := _string_to_const_name(group)
            group_defs[group_const] = group


func _generate_constants_script(
            filename: String,
            classname: String,
            defs: Dictionary[String, String],
        ) -> void:
    var dir := _get_scripts_dir()
    var sc_path := dir.get_current_dir().path_join(filename)
    var sorted_keys: Array[String] = defs.keys()
    sorted_keys.sort()
    var sc := FileAccess.open(sc_path, FileAccess.WRITE)
    var success := sc.store_string(str("class_name ", classname, "\n\n\n"))
    for k in sorted_keys:
        var line := str("const ", k, " := ", defs[k], "\n")
        success = success and sc.store_string(line)
        if not success: break
    sc.close()
    if success:
        print("Constants script generated: ", filename)
    else:
        push_error("Constants script failed to generate: ", filename)


func _unescape_unquote_string(string: String, prefix: String = "") -> String:
    var result := string
    if result.begins_with(prefix + "\""):
        result = result.substr(prefix.length() + 1).rstrip("\"")
    result = result.c_unescape()
    return result


func _escape_quote_string(string: String, prefix: String = "") -> String:
    return str(prefix, "\"", string.c_escape(), "\"")


func _string_to_const_name(string: String) -> String:
    string = string.to_upper()
    var result := ""
    if _digit_regex.search(string[0]) != null:
        result += "_"
    for c in string:
        result += c if _const_regex.search(c) != null else "_"
    return result
