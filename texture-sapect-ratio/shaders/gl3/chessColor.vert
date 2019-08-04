#version 150 core

in vec3 vertexPosition;
in vec3 vertexNormal;
in vec4 vertexTangent;
in vec2 vertexTexCoord;

out vec3 worldPosition;
out vec3 worldNormal;
out vec4 worldTangent;
out vec2 texCoord;
varying highp vec3 pos;
uniform mat4 modelMatrix;
uniform mat3 modelNormalMatrix;
uniform mat4 modelViewProjection;
uniform mat4 mvp;

uniform float texCoordScale;

void main() {
	//Transform position, normal, and tangent to world coords
	worldPosition = vec3(modelMatrix * vec4(vertexPosition, 1.0));

	// Calculate vertex position in clip coordinates
	gl_Position = mvp * vec4(worldPosition, 1.0);
	pos = vertexPosition;

	// Pass through scaled texture coordinates
	texCoord = vertexTexCoord * texCoordScale;

	// Transform position, normal, and tangent to world space
	worldPosition = vec3(modelMatrix * vec4(vertexPosition, 1.0));
	worldNormal = normalize(modelNormalMatrix * vertexNormal);
	worldTangent.xyz = normalize(vec3(modelMatrix * vec4(vertexTangent.xyz, 0.0)));
	worldTangent.w = vertexTangent.w;

	// Calculate vertex position in clip coordinates
	gl_Position = modelViewProjection * vec4(vertexPosition, 1.0);
}
