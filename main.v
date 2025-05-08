module main

import raylib as r

const screen_width = 800
const screen_height = 450
const max_columns = 20

fn main() {
	r.init_window(screen_width, screen_height, 'Test')

	mut camera := r.Camera{}
	camera.position = r.Vector3{f32(0.0), f32(2.0), f32(4.0)}
	camera.target = r.Vector3{f32(0.0), f32(2.0), f32(0.0)}
	camera.up = r.Vector3{f32(0.0), f32(1.0), f32(0.0)}
	camera.fovy = f32(60.0)
	camera.projection = int(r.CameraProjection.camera_perspective)

	// Animations
	filepath :="assets/Rogue.gltf"
	model := r.load_model(filepath)
	// mut anims := &r.ModelAnimation{};
	// anim_count := 0;
	// anims = r.load_model_animations(filepath, &anim_count);
	// mut current_frame := 0;
	//

	mut camera_mode := r.CameraMode.camera_first_person

	mut heights := [max_columns]f32{}
	mut positions := [max_columns]r.Vector3{}
	mut colors := [max_columns]r.Color{}

	mut i := 0
	for i < max_columns {
		heights[i] = f32(r.get_random_value(1, 12))
		positions[i] = r.Vector3{f32(r.get_random_value(-15, 15)), heights[i] / 2.0, f32(r.get_random_value(-15,
			15))}
		colors[i] = r.Color{u8(r.get_random_value(20, 255)), u8(r.get_random_value(10,
			255)), 30, 255}

		i++
	}

	// TODO disable this on prod
	r.enable_cursor()
	r.set_target_fps(60)

	for (!r.window_should_close()) {
		if r.is_key_pressed(int(r.KeyboardKey.key_two)) {
			camera_mode = r.CameraMode.camera_first_person
			camera.up = r.Vector3{f32(0.0), f32(1.0), f32(0.0)}
		}

		if r.is_key_pressed(int(r.KeyboardKey.key_three)) {
			camera_mode = r.CameraMode.camera_third_person
			camera.up = r.Vector3{f32(0.0), f32(1.0), f32(0.0)}
		}

			 // if r.is_key_pressed(int(r.KeyboardKey.key_space))
			 //     {
			 //         current_frame++;
			 //         unsafe {
			 // 			r.update_model_animation(model, anims[0], current_frame)
			 // 			if current_frame >= anims[0].frame_count {
			 // 				current_frame = 0
			 // 			}
			 // 		}
			 //     }

		r.update_camera(&camera, int(camera_mode))

		r.begin_drawing()
		r.clear_background(r.raywhite)

		r.begin_mode_3d(camera)
		r.draw_plane(r.Vector3{f32(0.0), f32(0.0), f32(0.0)}, r.Vector2{f32(32.0), f32(32.0)},
			r.lightgray)
		r.draw_cube(r.Vector3{f32(-16.0), f32(2.5), f32(0.0)}, f32(1.0), f32(5.0), f32(32.0),
			r.blue)
		r.draw_cube(r.Vector3{f32(16.0), f32(2.5), f32(0.0)}, f32(1.0), f32(5.0), f32(32.0),
			r.lime)
		r.draw_cube(r.Vector3{f32(0.0), f32(2.5), f32(16.0)}, f32(32.0), f32(5.0), f32(1),
			r.gold)

		i = 0
		for i < max_columns {
			r.draw_cube(positions[i], f32(2.0), heights[i], f32(2.0), colors[i])
			r.draw_cube_wires(positions[i], f32(2.0), heights[i], f32(2.0), r.maroon)

			i++
		}

		// Draw player cube
		if camera_mode == r.CameraMode.camera_third_person {
			r.draw_cube(camera.target, f32(0.5), f32(0.5), f32(0.5), r.purple)
			r.draw_cube_wires(camera.target, f32(0.5), f32(0.5), f32(0.5), r.darkpurple)
		}

			r.draw_model(
				model,
				r.Vector3{f32(0.0), f32(0), f32(0.0)},
				f32(1),
				r.white
			)

		r.end_mode_3d()

		// r.draw_text("Haha!", 190, 200, 20, r.lightgray)

		r.end_drawing()
	}

	r.unload_model(model)
	// r.unload_model_animations(anims, anim_count)
	r.close_window()
}
