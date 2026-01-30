@tool
extends EditorPlugin

var path = ProjectSettings.globalize_path("res://") 
var dock:EditorDock

func _enter_tree() -> void:
	dock = EditorDock.new()
	dock.name = "GitGodot 2.0"
	dock.default_slot = EditorDock.DOCK_SLOT_BOTTOM
	var dock_content = preload("res://addons/GitGodot/GitGodot.tscn").instantiate()
	dock.add_child(dock_content)
	add_dock(dock)

func _exit_tree() -> void:
	remove_dock(dock)
	dock.queue_free()
