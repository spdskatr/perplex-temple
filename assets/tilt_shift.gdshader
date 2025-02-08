shader_type canvas_item;

uniform float limit: hint_range(0.0,0.5) = 0.2;
uniform float blur: hint_range(0.0,5.0) = 1.0;
uniform float intensity: hint_range(0.0, 0.5) = 0.15;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform bool is_debug = false;

void vertex() {
}

void fragment() {
	if (UV.y < limit) {
		float _step = smoothstep(UV.y, limit, intensity);
		vec4 color = textureLod(screen_texture, SCREEN_UV, blur);
		if (is_debug) {
			COLOR.rgb = vec3(_step);
		} else {
			COLOR = color;
			COLOR.a = _step;
		}
	} else if (UV.y > 1. - limit) {
		float _step = smoothstep(UV.y, 1. - limit, 1. - intensity);
		vec4 color = textureLod(screen_texture, SCREEN_UV, blur);
		if (is_debug) {
			COLOR.rgb = vec3(_step);
		} else {
			COLOR = color;
			COLOR.a = _step;
		}
	} else {
		COLOR.a = 0.;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
