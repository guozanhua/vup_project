//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float fstep;

//precision lowp float;
//uniform sampler2D m_texture;

void main()
{
	vec4 sample0,sample1,sample2,sample3;
	sample0=texture2D(gm_BaseTexture,vec2(v_vTexcoord.x-fstep,v_vTexcoord.y-fstep));
	sample1=texture2D(gm_BaseTexture,vec2(v_vTexcoord.x+fstep,v_vTexcoord.y-fstep));
	sample2=texture2D(gm_BaseTexture,vec2(v_vTexcoord.x+fstep,v_vTexcoord.y+fstep));
	sample3=texture2D(gm_BaseTexture,vec2(v_vTexcoord.x-fstep,v_vTexcoord.y+fstep));
	vec4 color=(sample0+sample1+sample2+sample3) / 4.0;
	gl_FragColor=color*v_vColour;
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
