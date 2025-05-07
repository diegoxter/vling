module main

import raylib as r

const screen_width = 800
const screen_height = 450

fn main() {
	r.init_window(screen_width, screen_height, 'Test')

	r.set_target_fps(60)

	for (!r.window_should_close()) {
		r.begin_drawing()

		r.clear_background(r.raywhite)
		r.draw_text("Haha!", 190, 200, 20, r.lightgray)

		r.end_drawing()
	}

		r.close_window()
}
