@tool
extends BoxContainer

var branch:Label
var data = []
var path = ProjectSettings.globalize_path("res://") 
@onready var label: LineEdit = $Push_Container/LineEdit
var Branch

func _ready() -> void:
	load_data()
	$Push_Container2/OptionButton.select(1)
	Set_Branch(0)
	
func Set_Branch(index:int):
	Branch = $Push_Container2/OptionButton.get_item_text(index)
	pass
func _on_window_close_requested() -> void:
	$Window.hide()
	save_data()
	options_add()
	Branch = $Push_Container2/OptionButton.get_item_text(0)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	$Window.popup()
	pass # Replace with function body.


func _on_buttond_pressed() -> void:
	branch = Label.new()
	branch.text = $Window/HBoxContainer/LineEdit.text
	$Window/ScrollContainer/VBoxContainer.add_child(branch)
	pass # Replace with function body.


func save_data():
	data.clear()
	for child in $Window/ScrollContainer/VBoxContainer.get_children():
		var children_info = {
			"text": child.text
		}
		data.append(children_info)
	var file = FileAccess.open("res://addons/GitGodot/Save_Data/save.json",FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()




func load_data():
	if not FileAccess.file_exists("res://addons/GitGodot/Save_Data/save.json"):
		return
	var file = FileAccess.open("res://addons/GitGodot/Save_Data/save.json",FileAccess.READ)
	var json = file.get_as_text()
	var new_data = JSON.parse_string(json)
	for child in new_data:
		var label = Label.new()
		label.text = child.get("text")
		$Window/ScrollContainer/VBoxContainer.add_child(label)
		$Push_Container2/OptionButton.add_item(label.text)
func options_add():
	$Push_Container2/OptionButton.clear()
	if not FileAccess.file_exists("res://addons/GitGodot/Save_Data/save.json"):
		return
	var file = FileAccess.open("res://addons/GitGodot/Save_Data/save.json",FileAccess.READ)
	var json = file.get_as_text()
	var new_data = JSON.parse_string(json)
	for child in new_data:
		var label = Label.new()
		label.text = child.get("text")
		$Push_Container2/OptionButton.add_item(label.text)
	pass

func delete() -> void:
	for child in $Window/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
		Branch = ""
		pass
	pass # Replace with function body.


func _on_option_button_pressed() -> void:
	
	pass # Replace with function body.


func Donate_Page() -> void:
	$info.popup()
	pass # Replace with function body.


func _on_info_close_requested() -> void:
	$info.hide()
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if Branch != "" and $Push_Container/LineEdit.text != "":
		$Push_Container/Button.disabled = false
	else:
		$Push_Container/Button.disabled = true
		pass
	pass
func Push():
	var commit = label.text
	var output := [] 
	var cmd = ( "cd \""+ path +"\"" 
	+ "&& git add ." 
	+ "&& git commit -m \"" + commit +"\"" 
	+ "&& git push -u origin " + Branch 
	) 
	OS.execute( "cmd.exe", ["/c", cmd], output, true ) 
	for line in output: 
		print(cmd)
		print("line",line)
	pass # Replace with function body.
	
	
func Pull():
	var output := []
	var cmd = ("cd \""+ path +"\""+"&& git reset --hard" + "git pull")
	OS.execute("cmd.exe", ["/c", cmd], output, true)
	for line in output:
		print("line",line)
	pass
