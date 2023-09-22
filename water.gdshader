shader_type spatial;
uniform sampler2D heightMap;
uniform float heightScale  : hint_range(0.0, 1.0, 0.1);
uniform sampler2D normalMap;
varying float x_off;
varying float z_off;
uniform float speed = 20.0;
uniform float turbulence : hint_range(0.0, 1.0, 0.1);

void vertex() {
	x_off = speed*TIME/2.0;
	z_off = (texture(heightMap, UV*5.0+TIME/10.0).r)*(texture(heightMap, UV+TIME/20.0).r);
	float height = texture(heightMap, UV*5.0+vec2(x_off, z_off/30.0)).r;
	VERTEX.y = height*heightScale;
}

void fragment(){
	NORMAL_MAP = texture(normalMap, UV*5.0+vec2(x_off, z_off/10.0)).rgb;
	RIM = 0.0;
	SPECULAR = 0.3;
	METALLIC = 0.1;
	ROUGHNESS = 0.01;
	ALBEDO = vec3(0.01, 0.02, 0.04);
}