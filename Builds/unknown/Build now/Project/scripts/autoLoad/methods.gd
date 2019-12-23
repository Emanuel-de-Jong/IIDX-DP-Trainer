extends Node

func return_file_names_in_directory(filesPath:String, formats:Array):
	var fileNames = []
	var directory = Directory.new()
	directory.open(filesPath)
	directory.list_dir_begin()
	while true:
		var fileName = directory.get_next()
		if fileName == "":
			break
		if not fileName.begins_with(".") and not fileName.ends_with(".import"):
			var formatValid = true
			if len(formats) != 0:
				formatValid = false
				for format in formats:
					if fileName.ends_with("." + format):
						formatValid = true
						break
			if formatValid:
				fileNames.append(fileName)
	return fileNames

func wait(seconds:float):
	var timer = Timer.new()
	timer.set_wait_time(seconds)
	add_child(timer)
	timer.start()
	yield(timer, "timeout")