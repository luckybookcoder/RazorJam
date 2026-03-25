shader_type canvas_item;
uniform vec4 rand;
uniform bool highlight;
void fragment(){
	vec4 col = texture(TEXTURE,UV).rgba;
	if (abs(col.r - 1.0) < .6  && abs(col.g - 0.0) < .6  &&  abs(col.b - 0.0) < .6 &&  abs(col.a) > .99999){
		col = rand;
	}
	if (highlight){
		col.r += .2;
		col.b += .2;
		col.g += .2;
	}
	COLOR=col;
}
