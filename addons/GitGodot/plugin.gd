@tool
extends EditorPlugin

var path = ProjectSettings.globalize_path("res://") 
var dock:EditorDock

func _enter_tree() -> void:
	dock = EditorDock.new()
	dock.name = "GitGodot 3"
	dock.default_slot = EditorDock.DOCK_SLOT_BOTTOM
	if Check_Git():
		var dock_content = preload("res://addons/GitGodot/GitGodot.tscn").instantiate()
		dock.add_child(dock_content)
	else:
		var dock_content = preload("res://addons/GitGodot/No_Git.tscn").instantiate()
		dock.add_child(dock_content)
	add_dock(dock)

func _exit_tree() -> void:
	remove_dock(dock)
	dock.queue_free()
	
func Check_Git() -> bool:
	return DirAccess.dir_exists_absolute("res://.git")
	pass
