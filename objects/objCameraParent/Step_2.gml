if (do_follow && instance_exists(target)) {
	target_x = target.x + (mouse_x - target.x) * mouse_track_strength;
	target_y = target.y + (mouse_y - target.y) * mouse_track_strength * 1.5;
}

if ((abs(target_x - true_x) > 1 || abs(target_y - true_y) > 1)) {
	true_x += (target_x - true_x) * 1 / smooth_travel * GetDeltaTimeSeconds();
	true_y += (target_y - true_y) * 1 / smooth_travel * GetDeltaTimeSeconds();
}
	
if (do_camera_shake) {
	camera_shake_counter += GetDeltaTimeSeconds() * camera_shake_speed;
	x = true_x + camera_shake_intensity * dcos(camera_shake_counter);
	y = true_y + camera_shake_intensity * dsin(camera_shake_counter + camera_shake_y_counter_offset);
}
else {
	x = true_x;
	y = true_y;
}
	
var _viewmat = matrix_build_lookat(x + cam_offset_x * zoom, y + cam_offset_y * zoom, -100, x + cam_offset_x * zoom, y + cam_offset_y * zoom, 0, 0, 1, 0);
camera_set_view_mat(camera, _viewmat);

if (old_zoom != zoom) {
	old_zoom = zoom;
	var _projmat = matrix_build_projection_ortho(resolution_width * zoom, resolution_height * zoom, -2000, 32000.0);	
	camera_set_proj_mat(camera, _projmat);
}