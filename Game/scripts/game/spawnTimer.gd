extends Timer

var spawntime = 0
var spawnIntervalHalf = false
var spawnIntervalQuarter = false
var spawnIntervalEight = false

func _process(delta):
		self.start(spawntime / 1000)
		set_process(false)

func _on_spawnTimer_timeout():
	var modifiedSpawntime = spawntime
	
	if spawnIntervalHalf or spawnIntervalQuarter or spawnIntervalEight:
		randomize()
		if randi()%2 == 1:
			var spawnIntervals = [ spawnIntervalHalf, spawnIntervalQuarter, spawnIntervalEight ]
			var trueIntervalsIndexes = []
			for index in range(len(spawnIntervals)):
				if spawnIntervals[index]:
					trueIntervalsIndexes.append(index)
			if len(spawnIntervals) == 1:
				modifiedSpawntime = change_spawntime_with_interval(trueIntervalsIndexes[0])
			else:
				modifiedSpawntime = change_spawntime_with_interval(trueIntervalsIndexes[randi()%len(trueIntervalsIndexes) - 1])
	self.wait_time = modifiedSpawntime / 1000

func change_spawntime_with_interval(index):
	var value
	if index == 0:
		value = spawntime / 2
	elif index == 1:
		value = spawntime / 4
	elif index == 2:
		value = spawntime / 8
	
	if randi()%2 == 1:
		return spawntime - value
	else:
		return value


func _on_spawntime_value_changed(value):
	spawntime = value
	self.wait_time = spawntime / 1000

func _on_spawnIntervalHalf_toggled(button_pressed):
	spawnIntervalHalf = button_pressed


func _on_spawnIntervalQuarter_toggled(button_pressed):
	spawnIntervalQuarter = button_pressed


func _on_spawnIntervalEight_toggled(button_pressed):
	spawnIntervalEight = button_pressed
