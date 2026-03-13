shader_type canvas_item;

uniform float scale = 5;
uniform float width_multiplier = 2.6;
uniform float threshold = 0.8;

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 cUV = (UV - vec2(1, 1) * 0.5);
	float d = ((cUV.x * cUV.x) * width_multiplier + (cUV.y * cUV.y)) * scale;
	
	float baseline = (1.0 - d > threshold) ? 1.0 : 0.0;
	float falloff = ((1.0 - d) - threshold)*4.0;
	COLOR = vec4(falloff, falloff, falloff, falloff);
}
