#define MAX_LIGHTS 8

/* Attributes */

attribute vec3 inVertexPosition;
attribute vec3 inVertexNormal;
attribute vec4 inVertexColor;
attribute vec2 inTexCoord0;
attribute vec2 inTexCoord1;

/* Uniforms */

uniform mat4 uWVPMatrix;
uniform mat4 uWVMatrix;
uniform mat4 uNMatrix;

uniform vec4 uGlobalAmbient;
uniform vec4 uMaterialAmbient;
uniform vec4 uMaterialDiffuse;
uniform vec4 uMaterialEmissive;
uniform vec4 uMaterialSpecular;
uniform float uMaterialShininess;

uniform int uLightCount;
uniform int uLightType[MAX_LIGHTS];
uniform vec3 uLightPosition[MAX_LIGHTS];
uniform vec3 uLightDirection[MAX_LIGHTS];
uniform vec3 uLightAttenuation[MAX_LIGHTS];
uniform vec4 uLightAmbient[MAX_LIGHTS];
uniform vec4 uLightDiffuse[MAX_LIGHTS];
uniform vec4 uLightSpecular[MAX_LIGHTS];

uniform float uThickness;

/* Varyings */

varying vec2 vTextureCoord0;
varying vec4 vVertexColor;
varying vec4 vSpecularColor;
varying float vFogCoord;

vec3 getLightDirection(int index)
{
	vec3 LightDirection;
	if (index == 0) LightDirection = uLightDirection[0];
	else if (index == 1) LightDirection = uLightDirection[1];
	else if (index == 2) LightDirection = uLightDirection[2];
	else if (index == 3) LightDirection = uLightDirection[3];
	else if (index == 4) LightDirection = uLightDirection[4];
	else if (index == 5) LightDirection = uLightDirection[5];
	else if (index == 6) LightDirection = uLightDirection[6];
	else if (index == 7) LightDirection = uLightDirection[7];
	
	return LightDirection;
}

vec4 getLightAmbient(int index)
{
	vec4 LightAmbient;
	if (index == 0) LightAmbient = uLightAmbient[0];
	else if (index == 1) LightAmbient = uLightAmbient[1];
	else if (index == 2) LightAmbient = uLightAmbient[2];
	else if (index == 3) LightAmbient = uLightAmbient[3];
	else if (index == 4) LightAmbient = uLightAmbient[4];
	else if (index == 5) LightAmbient = uLightAmbient[5];
	else if (index == 6) LightAmbient = uLightAmbient[6];
	else if (index == 7) LightAmbient = uLightAmbient[7];
	
	return LightAmbient;
}

vec4 getLightDiffuse(int index)
{
	vec4 LightDiffuse;
	if (index == 0) LightDiffuse = uLightDiffuse[0];
	else if (index == 1) LightDiffuse = uLightDiffuse[1];
	else if (index == 2) LightDiffuse = uLightDiffuse[2];
	else if (index == 3) LightDiffuse = uLightDiffuse[3];
	else if (index == 4) LightDiffuse = uLightDiffuse[4];
	else if (index == 5) LightDiffuse = uLightDiffuse[5];
	else if (index == 6) LightDiffuse = uLightDiffuse[6];
	else if (index == 7) LightDiffuse = uLightDiffuse[7];
	
	return LightDiffuse;
}

vec4 getLightSpecular(int index)
{
	vec4 LightSpecular;
	if (index == 0) LightSpecular = uLightSpecular[0];
	else if (index == 1) LightSpecular = uLightSpecular[1];
	else if (index == 2) LightSpecular = uLightSpecular[2];
	else if (index == 3) LightSpecular = uLightSpecular[3];
	else if (index == 4) LightSpecular = uLightSpecular[4];
	else if (index == 5) LightSpecular = uLightSpecular[5];
	else if (index == 6) LightSpecular = uLightSpecular[6];
	else if (index == 7) LightSpecular = uLightSpecular[7];
	
	return LightSpecular;
}

vec3 getLightAttenuation(int index)
{
	vec3 LightAttenuation;
	if (index == 0) LightAttenuation = uLightAttenuation[0];
	else if (index == 1) LightAttenuation = uLightAttenuation[1];
	else if (index == 2) LightAttenuation = uLightAttenuation[2];
	else if (index == 3) LightAttenuation = uLightAttenuation[3];
	else if (index == 4) LightAttenuation = uLightAttenuation[4];
	else if (index == 5) LightAttenuation = uLightAttenuation[5];
	else if (index == 6) LightAttenuation = uLightAttenuation[6];
	else if (index == 7) LightAttenuation = uLightAttenuation[7];
	
	return LightAttenuation;
}

bool checkLightType(int i, int lightType)
{
	bool test = false;

	if (i == 0 && uLightType[0] == lightType) test = true;
	else if (i == 1 && uLightType[1] == lightType) test = true;
	else if (i == 2 && uLightType[2] == lightType) test = true;
	else if (i == 3 && uLightType[3] == lightType) test = true;
	else if (i == 4 && uLightType[4] == lightType) test = true;
	else if (i == 5 && uLightType[5] == lightType) test = true;
	else if (i == 6 && uLightType[6] == lightType) test = true;
	else if (i == 7 && uLightType[7] == lightType) test = true;
	
	return test;
}

void dirLight2(in vec3 position, in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	vec3 L = normalize(-(uNMatrix * vec4(uLightDirection[0], 0.0)).xyz);
	
	ambient += uLightAmbient[0];

	float NdotL = dot(normal, L);

	if (NdotL > 0.0)
	{		
		diffuse += uLightDiffuse[0] * NdotL;

		vec3 E = normalize(-position); 
		vec3 HalfVector = normalize(L + E);
		float NdotH = max(0.0, dot(normal, HalfVector));

		float SpecularFactor = pow(NdotH, uMaterialShininess);
		
		specular += uLightSpecular[0] * SpecularFactor;
	}
}

void dirLight(in int index, in vec3 position, in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	vec3 L = normalize(-(uNMatrix * vec4(getLightDirection(index), 0.0)).xyz);

	ambient += getLightAmbient(index);

	float NdotL = dot(normal, L);

	if (NdotL > 0.0)
	{
		diffuse += getLightDiffuse(index) * NdotL;

		vec3 E = normalize(-position); 
		vec3 HalfVector = normalize(L + E);
		float NdotH = max(0.0, dot(normal, HalfVector));

		float SpecularFactor = pow(NdotH, uMaterialShininess);
		specular += getLightSpecular(index) * SpecularFactor;
	}
}

void pointLight(in int index, in vec3 position, in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	vec3 L = uLightPosition[index] - position;
	float D = length(L);
	L = normalize(L);

	vec3 LightAttenuation = getLightAttenuation(index);
	
	float Attenuation = 1.0 / (LightAttenuation.x + LightAttenuation.y * D +
		LightAttenuation.z * D * D);

	ambient += getLightAmbient(index) * Attenuation;

	float NdotL = dot(normal, L);

	if (NdotL > 0.0)
	{
		diffuse += getLightDiffuse(index) * NdotL * Attenuation;

		vec3 E = normalize(-position); 
		vec3 HalfVector = normalize(L + E);
		float NdotH = max(0.0, dot(normal, HalfVector));

		float SpecularFactor = pow(NdotH, uMaterialShininess);
		specular += getLightSpecular(index) * SpecularFactor * Attenuation;
	}
}

void spotLight(in int index, in vec3 position, in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	// TO-DO
}

void main()
{
	gl_Position = uWVPMatrix * vec4(inVertexPosition, 1.0);
	gl_PointSize = uThickness;

	vec3 Position = (uWVMatrix * vec4(inVertexPosition, 1.0)).xyz;
	vec3 P = normalize(Position);
	vec3 N = normalize(vec4(uNMatrix * vec4(inVertexNormal, 0.0)).xyz);
	vec3 R = reflect(P, N);

	float V = 2.0 * sqrt(R.x*R.x + R.y*R.y + (R.z+1.0)*(R.z+1.0));
	vTextureCoord0 = vec2(R.x/V + 0.5, R.y/V + 0.5);

	vVertexColor = inVertexColor.bgra;
	vSpecularColor = vec4(0.0, 0.0, 0.0, 0.0);

	if (uLightCount > 0)
	{
		vec3 Normal = normalize((uNMatrix * vec4(inVertexNormal, 0.0)).xyz);

		vec4 Ambient = vec4(0.0, 0.0, 0.0, 0.0);
		vec4 Diffuse = vec4(0.0, 0.0, 0.0, 0.0);
		
		if (uLightType[0] == 2)
			dirLight2(Position, Normal, Ambient, Diffuse, vSpecularColor);

		/*for (int i = 0; i < MAX_LIGHTS; i++)
		{
			if (i > uLightCount)
				break;
				
			if (checkLightType(i, 0))
				pointLight(i, Position, Normal, Ambient, Diffuse, vSpecularColor);
		}

		for (int i = 0; i < MAX_LIGHTS; i++)
		{
			if (i > uLightCount)
				break;
				
			if (checkLightType(i, 1))
				spotLight(i, Position, Normal, Ambient, Diffuse, vSpecularColor);
		}

		for (int i = 0; i < MAX_LIGHTS; i++)
		{
			if (i > uLightCount)
				break;
				
			if (checkLightType(i, 2))
				dirLight(i, Position, Normal, Ambient, Diffuse, vSpecularColor);
		}*/

		vec4 LightColor = Ambient * uMaterialAmbient + Diffuse * uMaterialDiffuse;
		LightColor = clamp(LightColor, 0.0, 1.0);
		LightColor.w = 1.0;

		vVertexColor *= LightColor;
		vVertexColor += uMaterialEmissive;
		vVertexColor += uGlobalAmbient * uMaterialAmbient;
		vVertexColor = clamp(vVertexColor, 0.0, 1.0);
		
		vSpecularColor *= uMaterialSpecular;
	}

	vFogCoord = length(Position);
}
