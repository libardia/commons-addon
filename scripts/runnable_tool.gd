@tool
@abstract class_name RunnableTool
extends Node


@export_tool_button("Run") var run_callable := run


@abstract func run() -> void
