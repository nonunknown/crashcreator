shader_type spatial;
render_mode skip_vertex_transform, unshaded;

//Albedo texture
uniform sampler2D albedoTex : hint_albedo;

//Geometric resolution for vert sna[
uniform float snapRes = 15.0;

//vec4 for UV recalculation
varying vec4 vertCoord;

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.xyz = floor(VERTEX.xyz * snapRes) / snapRes;
	vertCoord = vec4(UV * VERTEX.z, VERTEX.z, 0);
}

void fragment() {
	ALBEDO = texture(albedoTex, vertCoord.xy / vertCoord.z).rgb;
}