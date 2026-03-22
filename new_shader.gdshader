shader_type canvas_item;
uniform float max_col_b = 0.22;
void fragment(){
	vec4 col = texture(TEXTURE,UV).rgba;
	if (col.r >=1.0 && col.g>=1.0 &&  col.b >= max_col_b) {
		col.a = 0.0;
	}
	COLOR=col;
}