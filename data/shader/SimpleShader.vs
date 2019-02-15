#version 330
/*
Any copyright is dedicated to the Public Domain.
http://creativecommons.org/publicdomain/zero/1.0/
Author: Sascha Brandt <sascha@brandt.graphics>
*/

//-------------
// Predefined vertex attributes:
// You need to specify them in Mesh using a VertexDescription to make them available

in vec3 sg_Position; // 3d position
in vec3 sg_Normal; // normal
in vec3 sg_Tangent; // tangent (rarely used)
in vec4 sg_Color; // color
in vec2 sg_TexCoord0; // texture coordinate 0
//in vec2 sg_TexCoord1-8; // texture coordinate 1-8

//-------------
// Predefines uniforms

uniform mat4 sg_matrix_modelToClipping;		// model space to screen space
uniform mat4 sg_matrix_modelToCamera;			// model space to camera space

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

//-------------
// Vertex shader output

out VertexData {
	vec4 position_cs;
	vec3 normal_cs;
	vec4 color;
	vec2 texCoord;
} vsOut;

//-------------

void main() {
	// pass vertex attributes to next shader stage (e.g., fragment shader)
	vsOut.position_cs = sg_matrix_modelToCamera * vec4(sg_Position, 1);
	vsOut.normal_cs = (sg_matrix_modelToCamera * vec4(sg_Normal, 0)).xyz;
	vsOut.color = sg_Color;
	vsOut.texCoord = sg_TexCoord0;
	
	// Do something with the parameters here
	
	// transform the vertex to screen space
	gl_Position = sg_matrix_modelToClipping * vec4(sg_Position, 1);
}
