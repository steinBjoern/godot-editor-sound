tool
extends EditorPlugin

var asp : AudioStreamPlayer = null

var sounds : Dictionary = {}

func _enter_tree():
	connect( 'resource_saved', self, 'on_resource_saved')
	load_sounds()
	ini_AudioStreamPlayer()
	


func _exit_tree():
	pass
	


func _process(delta):
	pass
	


func on_resource_saved( resource):
	if resource is GDScript:
		if asp != null:
			play( 'save_script')
		
	


func ini_AudioStreamPlayer():
	print( 'initialize editor-sounds plugin AudioStreamPlayer')
	var new_asp = AudioStreamPlayer.new()
	add_child( new_asp)
	new_asp.set_volume_db( -40.0)
	asp = new_asp
	play( 'welcome')
	
	


func load_sounds():
	print( 'initialize editor-sounds plugin sounds')
#	sounds[ 'save_script'] = load( 'res://addons/editor-sounds/sounds/save_script.wav')
	var path = 'res://addons/editor-sounds/sounds/'
	var dir = Directory.new()
	if dir.open( path) == OK:
		dir.list_dir_begin( 1)
		var file_name = dir.get_next()
		while file_name != "":
			print( file_name)
			if file_name.ends_with( '.wav'):
				var sound_key = file_name.get_basename()
				print( sound_key)
				sounds[ sound_key] = load( str( path, file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	


func play( key : String):
	if asp:
		asp.set_stream( sounds[ key])
		asp.play()
	else:
		print( 'AudioStreamPlayer not initialized')
