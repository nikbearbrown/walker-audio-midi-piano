extends SceneTree
var failures := 0
var checks := 0
func _initialize():
	call_deferred("run")
func check(ok: bool, label: String):
	checks += 1
	if not ok: failures += 1
	print("PASS " if ok else "FAIL ",label)
func send(message: int, pitch: int, velocity: int):
	var e := InputEventMIDI.new()
	e.message = message
	e.pitch = pitch
	e.velocity = velocity
	Input.parse_input_event(e)
func voices(k: Node) -> int:
	return k.get_children().filter(func(n): return n is AudioStreamPlayer).size()
func run():
	var piano: Node = load("res://piano.tscn").instantiate()
	root.add_child(piano)
	await process_frame
	var k: Node = piano.piano_key_dict[69]
	send(MIDI_MESSAGE_NOTE_ON,69,100)
	await process_frame
	check(k.key.color != k.start_color and voices(k) == 1,"note-on activates")
	send(0xA,69,50) # Polyphonic key pressure message.
	await process_frame
	check(k.key.color != k.start_color,"aftertouch does not release key")
	send(MIDI_MESSAGE_NOTE_ON,69,0)
	await process_frame
	check(k.key.color == k.start_color,"zero-velocity note-on releases highlight")
	check(voices(k) == 1,"zero velocity creates no voice")
	send(MIDI_MESSAGE_NOTE_ON,69,100)
	await process_frame
	send(MIDI_MESSAGE_NOTE_OFF,69,64)
	await process_frame
	check(k.key.color == k.start_color,"note-off releases highlight")
	var count := voices(k)
	send(MIDI_MESSAGE_NOTE_ON,20,100)
	send(MIDI_MESSAGE_NOTE_ON,109,100)
	await process_frame
	check(voices(k) == count,"out-of-range pitches ignored")
	for pitch in [21,108]:
		var edge: Node = piano.piano_key_dict[pitch]
		send(MIDI_MESSAGE_NOTE_ON,pitch,127)
		await process_frame
		check(edge.key.color != edge.start_color and voices(edge) == 1,"range boundary activates " + str(pitch))
		send(0xB,pitch,0) # Constructed controller event must not release notes.
		await process_frame
		check(edge.key.color != edge.start_color,"controller ignored " + str(pitch))
		send(MIDI_MESSAGE_NOTE_OFF,pitch,0)
		await process_frame
		check(edge.key.color == edge.start_color,"range boundary releases " + str(pitch))
	await create_timer(8.3).timeout
	check(voices(k) == 0,"all created voices cleaned up")
	piano.queue_free()
	OS.close_midi_inputs()
	await process_frame
	print("RESULT ",checks," checks; ",failures," failures")
	quit(1 if failures else 0)
