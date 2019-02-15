#version 330
/*
Any copyright is dedicated to the Public Domain.
http://creativecommons.org/publicdomain/zero/1.0/
Author: Sascha Brandt <sascha@brandt.graphics>
*/

//-------------
// Fragment shader input
in VertexData {
	vec4 position_cs;
	vec3 normal_cs;
	vec4 color;
	vec2 texCoord;
} fsIn;

//-------------
// Custom uniforms

uniform vec4 colorOverride;

//-------------
// Predefines uniforms

/*
// matrices
uniform mat4 sg_matrix_modelToClipping;		// model space to screen space
uniform mat4 sg_matrix_modelToCamera;			// model space to camera space
uniform mat4 sg_matrix_cameraToClipping;	// camera space to screen space
uniform mat4 sg_matrix_worldToCamera;			// world space to camera space
uniform mat4 sg_matrix_cameraToWorld;			// camera space to world space
uniform mat4 sg_matrix_clippingToCamera;	// screen space to camera space

// viewport
uniform int[4] sg_viewport; // the current viewport (x,y,width,height)

// point size
uniform float sg_pointSize; // point size used for drawing point meshes

// lighting
const int DIRECTIONAL = 1;
const int POINT = 2;
const int SPOT = 3;
struct sg_LightSourceParameters {
	int type;														// has to be DIRECTIONAL, POINT or SPOT
	vec3 position; 											// position of the light
	vec3 direction; 										// direction of the light, has to be normalized
	vec4 ambient, diffuse, specular;		// light colors for all lights
	float constant, linear, quadratic;	// attenuations for point & spot lights
	float exponent, cosCutoff;					// spot light parameters
};
uniform sg_LightSourceParameters sg_LightSource[8]; // array of light parameters
uniform int sg_lightCount; // number of active light nodes

// materials
struct sg_MaterialParameters {
	vec4 ambient, diffuse, specular, emission;	// material colors
	float shininess;														// shininess
};
uniform sg_MaterialParameters	sg_Material; // active material
uniform bool sg_useMaterials; // true if materials are used

// textures
uniform sampler2D sg_texture0;			// texture unit 0
//uniform sampler2D sg_texture1-8;	// texture units 1-8
uniform bool sg_textureEnabled[8];	// boolean array to check if a texture unit is used
*/

// Fragment shader output
out vec4 fsOutColor;

//-------------

void main() {
	// get parameters from previous shader stage (e.g., vertex shader)
	vec3 position = fsIn.position_cs.xyz / fsIn.position_cs.w; // need to devide by w to deal with homogeneous coordinates
	vec3 normal = normalize(fsIn.normal_cs);
	vec4 color = fsIn.color;
	vec2 texCoord = fsIn.texCoord;
	
	// Do something with the parameters here
	
	fsOutColor = colorOverride;
}
