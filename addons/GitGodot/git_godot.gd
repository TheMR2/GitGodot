@tool
extends BoxContainer

var branch:Label
var data = []
var path = ProjectSettings.globalize_path("res://") 
var Branch
var LastCommit
@onready var Entry: LineEdit = $Push_Container/LineEdit



func _ready() -> void:
	Set_Branch()
	commit()

func Set_Branch():
	if FileAccess.file_exists("res://.git/HEAD"):
		var Branch_Name = FileAccess.open("res://.git/HEAD",FileAccess.READ)
		var line = Branch_Name.get_line()
		Branch_Name.close()
		Branch = line.split("/")[-1]
		$Push_Container2/Label2.text = Branch
	pass
func commit():
	if FileAccess.file_exists("res://.git/COMMIT_EDITMSG"):
		var lastCommit = FileAccess.open("res://.git/COMMIT_EDITMSG",FileAccess.READ)
		LastCommit = lastCommit.get_line()
		lastCommit.close()
		$Push_Container2/Label4.text = LastCommit
	pass

func Donate_Page() -> void:
	$info.popup()
	pass # Replace with function body.


func _on_info_close_requested() -> void:
	$info.hide()
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Branch != "" and Entry.text != "":
		$Push_Container/Button.disabled = false
	else:
		$Push_Container/Button.disabled = true
		pass
	pass
func Push():
	var commit = Entry.text
	var output := [] 
	var cmd = ( "cd \""+ path +"\"" 
	+ "&& git add ." 
	+ "&& git commit -m \"" + commit +"\"" 
	+ "&& git push -u origin " + Branch 
	) 
	OS.execute( "cmd.exe", ["/c", cmd], output, true ) 
	for line in output: 
		print("line",line)
	Entry.clear()
	commit()
	pass # Replace with function body.
	
func Pull():
	var output := []
	var cmd = ("cd \""+ path +"\""+"&& git reset --hard " + " && git pull")
	OS.execute("cmd.exe", ["/c", cmd], output, true)
	for line in output:
		print("line",line)
	pass
