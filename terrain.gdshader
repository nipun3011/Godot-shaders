shader_type spatial;
uniform sampler2D snow_albedo : source_color;
uniform sampler2D snow_normal : hint_normal;
uniform sampler2D snow_roughness;
uniform sampler2D dirt_albedo : source_color;
uniform sampler2D dirt_normal : hint_normal;
uniform sampler2D dirt_roughness;
uniform sampler2D noise;
uniform float scale_factor = 1.;
uniform float snow_height : hint_range(0.0, 1.0, 0.1);

float overlay(float a, float b){
	if(a+b<0.5){
		return a+a*b;
	}
	else{
		return a;
	}
}

void fragment() {
	float snow_mask = COLOR.r;
	vec2 uv = UV*scale_factor;
	float noise_overlay = texture(noise, uv).r;
	vec3 snow_a = texture(snow_albedo, uv).rgb;
	vec3 snow_n = texture(snow_normal, uv).rgb;
	float snow_r = texture(snow_roughness, uv).r;
	vec3 dirt_a = texture(dirt_albedo, uv).rgb;
	vec3 dirt_n = texture(dirt_normal, uv).rgb;
	float dirt_r = texture(dirt_roughness, uv).r;
	ALBEDO = mix(dirt_a, snow_a, overlay(snow_mask, noise_overlay));
	NORMAL_MAP = mix(dirt_n, snow_n, snow_mask);
	ROUGHNESS = mix(dirt_r, snow_r, overlay(snow_mask, noise_overlay));
	METALLIC = 0.0;
	
}
void vertex(){
	vec2 uv = UV*scale_factor;
	float noise_overlay = texture(noise, uv).r;
	float snow_mask = COLOR.r;
	VERTEX.y += overlay(snow_mask, noise_overlay)*snow_height;
}
