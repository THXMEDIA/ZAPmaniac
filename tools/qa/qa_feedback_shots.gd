# QA-Screenshots zum Tester-Feedback vom 16.10.: Kamerahöhe (F6), Schwung (F7),
# Lautstärkeregler. Aufruf aus dem Repo-Wurzelverzeichnis:
#   cp tools/qa/qa_feedback_shots.gd godot/qa_feedback_shots.gd
#   SHOT_DIR=/pfad xvfb-run -a -s "-screen 0 1280x720x24" \
#     godot --rendering-driver opengl3 --path godot --resolution 1280x720 \
#     --script res://qa_feedback_shots.gd
#   rm godot/qa_feedback_shots.gd
# Erzeugt: f1_start (Regler im Startbildschirm), f2_geist_bisher (Kamera 2,5 m,
# Geist vor dem Spieler), f3_geist_geplant (1,25 m, gleiche Stelle),
# f4_schwung (Schwung an, Anzeige), f5_pause (Regler im Pausemenü).
extends SceneTree

var main: Node
var out_dir := ""


func _initialize() -> void:
	out_dir = OS.get_environment("SHOT_DIR")
	if out_dir == "":
		out_dir = "user://qa_shots"
	DirAccess.make_dir_recursive_absolute(out_dir)
	main = load("res://scenes/Main.tscn").instantiate()
	root.add_child(main)
	_run()


func _frames(n: int) -> void:
	for i in n:
		await process_frame


func _shot(name: String) -> void:
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(out_dir.path_join(name + ".png"))
	print("QA_SHOT ", name)


## A ghost stands still 3 m in front of the player.
func _ghost_ahead() -> void:
	var pl = main.player
	var e = main.enemies[0]
	var fwd := Vector3(-sin(pl.yaw), 0, -cos(pl.yaw))
	var p: Vector3 = pl.global_position + fwd * 3.0
	e.mode = "chase"
	e.release_at = 1e9
	e.set_process(false)
	e.position = Vector3(p.x, 0.5, p.z)
	e.rotation.y = pl.yaw


func _run() -> void:
	await _frames(20)
	await _shot("f1_start")
	main.begin_game("klassik-1")
	main.skip_intro()
	await _frames(10)
	main.invuln_until = 1e9
	main.paused = true # world frozen, the ghost stays where it is placed
	for e in main.enemies:
		e.release_at = 1e9
	_ghost_ahead()
	main.hud.hide_hint()
	await _frames(5)
	await _shot("f2_geist_bisher")
	main.toggle_camera_height_test()
	main.hud.hide_hint()
	await _frames(5)
	await _shot("f3_geist_geplant")
	main.toggle_camera_height_test()
	main.paused = false
	main.toggle_flow_spike()
	for i in 6:
		main.player.on_pellet()
	main._process(0.016)
	await _frames(5)
	await _shot("f4_schwung")
	main.toggle_pause()
	await _frames(10)
	await _shot("f5_pause")
	quit()
