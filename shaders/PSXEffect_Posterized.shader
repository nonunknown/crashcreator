shader_type spatial;
render_mode skip_vertex_transform, unshaded;

//Albedo texture
uniform sampler2D albedoTex : hint_albedo;

//Geometric resolution for vert snap
uniform float snapRes = 15.0;

//Gamma
uniform float gamma = 0.6;

//Number of colors for posterization
uniform float numColors = 8.0;

//vec4 for UV recalculation
varying vec4 vertCoord;

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xyz = floor(VERTEX.xyz * snapRes) / snapRes;
	vertCoord = vec4(UV * VERTEX.z, VERTEX.z, 0);
	NORMAL = (MODELVIEW_MATRIX * vec4(VERTEX, 0.0)).xyz;
}

void fragment() {
	vec3 c = texture(albedoTex, vertCoord.xy / vertCoord.z).rgb;
	c = pow(c, vec3(gamma, gamma, gamma));
	c = c * numColors;
	c = floor(c);
	c = c / numColors;
	c = pow(c, vec3(1.0/gamma));
	ALBEDO = c;
}