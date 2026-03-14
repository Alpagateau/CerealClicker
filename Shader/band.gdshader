shader_type canvas_item;
uniform float center_height : hint_range(0, 1) = 0.3;
uniform vec4 albedo : source_color;

float lerp(float a, float b, float t)
{
	return a + (b - a) * t;
}

void fragment() {
	vec2 cUV = (UV - vec2(0.5, 0.5)) * 2.0;
	float alpha = (abs(cUV.y) > lerp(center_height,1,abs(cUV.x))) ? 0.0 : 1.0;
	COLOR = vec4(albedo.r, albedo.g, albedo.b, alpha * albedo.a);
}

