#version 150 core

uniform vec3 firstColor;
uniform vec3 secondColor;
uniform vec3 boxSize;
out vec4 fragColor;
varying highp vec3 pos;

void drawChessCells(int blockX, int blockY) {
	if((blockX + blockY) % 2 == 0) {
		fragColor = vec4(firstColor, 1);
	} else {
		fragColor = vec4(secondColor, 1);
	}
}
void drawGradient() {
	float r = 0;
	float g = 0;
	float b = 0;
	float v = pos.x;
	if(v<0)
		b = -v;
	else if(v>1)
		r = v / 10;
	else
		g = v;

	fragColor = vec4(r, g, b, 1.0);
}
void main() {
	float x = pos.x;
	float y = pos.y;
	float z = pos.z;

	// depending on side (roof/bottom), set x and y to be what is needed
	bool side = false;
	if(x==-boxSize.x/2 || x==boxSize.x/2) {
		x = z;
		side = true;
	} else if(y==-boxSize.y/2 || y==boxSize.y/2) {
		y = z;
	}

	// mesh if from -d to +d, make it positive
	x += boxSize.x;
	y += boxSize.y;
	// b == block number
	vec2 cellSize = vec2(1./4, 1./4);
	const int nbx = int(x/cellSize.x);
	const int nby = int(y/cellSize.y);
	drawChessCells(nbx, nby);

	//i case you need coordinates in this block number
	float bx = x - nbx * cellSize.x;
	float by = y - nby * cellSize.y;

	//drawGradient();
}

