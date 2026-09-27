extends SceneTree
var checks := 0
var failures := 0
func _initialize():
	call_deferred("run")
func check(ok: bool, label: String):
	checks += 1
	if not ok: failures += 1
	print("PASS " if ok else "FAIL ",label)
func run():
	root.size = Vector2i(1280,200)
	var piano: Node = load("res://piano.tscn").instantiate()
	root.add_child(piano)
	await create_timer(0.1).timeout
	print("DIAG MIDI inputs ",OS.get_connected_midi_inputs())
	check(piano.piano_key_dict.size() == 88,"88 keys")
	check(piano.get_node("WhiteKeys").get_child_count() == 52,"52 white keys")
	var a: Node = piano.piano_key_dict[69]
	check(is_equal_approx(a.pitch_scale,1),"A440 ratio1")
	check(is_equal_approx(piano.piano_key_dict[81].pitch_scale,2),"A880 ratio2")
	check(is_equal_approx(piano.piano_key_dict[57].pitch_scale,0.5),"A220 ratio0.5")
	for pitch in [69,70]:
		var k: Node = piano.piano_key_dict[pitch]
		var rect: Rect2 = k.key.get_global_rect()
		var point := rect.position + rect.size * Vector2(0.5,0.8)
		var e := InputEventMouseButton.new()
		e.button_index = MOUSE_BUTTON_LEFT
		e.position = point
		e.pressed = true
		root.push_input(e,true)
		await process_frame
		e = InputEventMouseButton.new()
		e.button_index = MOUSE_BUTTON_LEFT
		e.position = point
		root.push_input(e,true)
		check(k.key.color != k.start_color,"mouse highlights " + str(pitch))
		check(k.get_children().filter(func(n): return n is AudioStreamPlayer).size() == 1,"mouse starts audio node " + str(pitch))
	await create_timer(1.2).timeout
	check(a.key.color == a.start_color,"timer restores color")
	await create_timer(7.2).timeout
	for pitch in [69,70]:
		check(piano.piano_key_dict[pitch].get_children().filter(func(n): return n is AudioStreamPlayer).is_empty(),"audio node cleanup " + str(pitch))
	piano.queue_free()
	OS.close_midi_inputs()
	await process_frame
	print("RESULT ",checks," checks; ",failures," failures")
	quit(1 if failures else 0)
