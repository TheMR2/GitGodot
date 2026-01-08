@tool
extends EditorPlugin

var path = ProjectSettings.globalize_path("res://") 
var dock
var button:Button
var label:LineEdit

func _enter_tree() -> void:
	button = Button.new()
	button.text = "Push"
	button.pressed.connect(_on_button_pressed)
	add_control_to_container(CONTAINER_INSPECTOR_BOTTOM,button)


	label = LineEdit.new()
	add_control_to_container(CONTAINER_INSPECTOR_BOTTOM,label)


func _exit_tree() -> void:
	remove_control_from_container(CONTAINER_INSPECTOR_BOTTOM,button)
	button.queue_free()

	label.queue_free()
	remove_control_from_container(CONTAINER_INSPECTOR_BOTTOM,label)


func _on_button_pressed():
	var commit = label.text
	var output := [] 
	var cmd = ( "cd \""+ path +"\"" 
	+ "&& git add ." 
	+ "&& git commit -m \"" + commit +"\"" 
	+ "&& git push -u origin main" 
	) 
	OS.execute( "cmd.exe", ["/c", cmd], output, true ) 
	for line in output: 
		print("line",line)
	pass # Replace with function body.
