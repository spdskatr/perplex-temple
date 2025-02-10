shader_type canvas_item;
render_mode unshaded;

uniform float limit: hint_range(0.0,0.5) = 0.2;
uniform float blur: hint_range(0.0,5.0) = 1.0;
uniform float intensity: hint_range(0.0, 0.5) = 0.15;
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest_mipmap;
uniform bool is_debug = false;

// NOTE: This hardcodes the resolution of the window.
const float xs = 1200., ys = 675.;
const int r = 4;

void vertex() {
}

void fragment() {
    vec3 color = vec3(0.);
    float w = 0.378 / pow(float(r), 1.975) ;
    for (int x = -r; x <= r; x += 1)
		for (int y = -r; y <= r; y += 1)
			if (x * x + y * y <= r * r)
				color += textureLod(screen_texture, SCREEN_UV + vec2(float(x) / xs, float(y) / ys), 0.).rgb * w * exp(-0.5 * float(x * x + y * y) / float(r * r));

	if (UV.y < limit) {
		float _step = smoothstep(UV.y, limit, intensity);
		if (is_debug) {
			COLOR.rgb = vec3(_step);
		} else {
			COLOR = vec4(color, _step);
		}
	} else if (UV.y > 1. - limit) {
		float _step = smoothstep(UV.y, 1. - limit, 1. - intensity);
		if (is_debug) {
			COLOR.rgb = vec3(_step);
		} else {
			COLOR = vec4(color, _step);
		}
	} else {
		COLOR.a = 0.;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
