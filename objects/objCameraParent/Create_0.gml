camera = camera_create();

view_enabled = true;
view_visible[0] = true;
view_camera[0] = camera;

//view_wport[0] = 1280;
//view_hport[0] = 720;
window_set_size(1280, 720);

target_x = x;
target_y = y;
true_x = x;
true_y = y;

if (instance_exists(target))
{
	true_x = target.x;
	true_y = target.y;
}


old_zoom = 1;

cam_origin_x = 0;
cam_origin_y = 0;

cam_offset_x = resolution_width * camera_offset;
cam_offset_y = resolution_height * camera_offset;

do_camera_shake = 0;
camera_shake_intensity = 0;
camera_shake_counter = 0;
camera_shake_speed = 720;
camera_shake_y_counter_offset = 0;

function LocalCameraShake(_strength, _revolutions_per_second,  _duration, _off_camera_shake, _x, _y) {
	if (!_off_camera_shake) {
		if (abs(x - _x) > resolution_width / 2 || abs(y - _y) > resolution_height / 2) return;
	}
	do_camera_shake = true;
	camera_shake_counter = random(360);
	camera_shake_y_counter_offset = random(360);
	camera_shake_intensity = _strength;
	camera_shake_speed = _revolutions_per_second * 360;
	
	SetAlarmDelta(_duration, function(){do_camera_shake = false;true_x = x; true_y = y;});
}

function getCameraShakePosition(_x_to_set, _y_to_set, _counter) {
	_x_to_set = camera_shake_intensity * dcos(_counter);
	_y_to_set = camera_shake_intensity * dsin(_counter);
}

function cameraShakeOff() {
	do_camera_shake = false;
	getCameraShakePosition(true_x, true_y, camera_shake_counter);
}

var _viewmat = matrix_build_lookat(x + cam_offset_x * zoom, y + cam_offset_y * zoom, -100, x + cam_offset_x * zoom, y + cam_offset_y * zoom, 0, 0, 1, 0);
var _projmat = matrix_build_projection_ortho(resolution_width, resolution_height, -2000, 32000.0);

camera_set_view_mat(camera, _viewmat);
camera_set_proj_mat(camera, _projmat);