shader_type canvas_item;
uniform bool hidden = false;


void fragment() {
	vec4 c = texture(TEXTURE, UV);
	if(hidden)
	{
		COLOR = vec4(0, 0, 0, c.a);
	}
	else
	{
		COLOR = c;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
