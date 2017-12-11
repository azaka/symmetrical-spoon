precision mediump float;

/* Uniforms */

uniform int uTextureUsage;
uniform sampler2D uTextureUnit;

/* Varyings */

varying vec2 vTextureCoord;
varying vec4 vVertexColor;

void main()
{
	vec4 Color = vVertexColor;

	if (uTextureUsage == 1)
		Color *= texture2D(uTextureUnit, vTextureCoord);

	gl_FragColor = Color;
}
