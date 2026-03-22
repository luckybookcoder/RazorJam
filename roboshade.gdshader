shader_type canvas_item;
uniform vec4 rand;
uniform bool highlight;
void fragment(){
	vec4 col = texture(TEXTURE,UV).rgba;
	if (abs(col.r - .21) < .01  && abs(col.g - .23) < .01  &&  abs(col.b - .32) < .01 ) {
		col = rand;
	}
	if (highlight){
		col.r += .2;
		col.b += .2;
		col.g += .2;
	}
	COLOR=col;
}
