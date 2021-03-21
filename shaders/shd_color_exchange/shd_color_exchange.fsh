//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 oldcol[30];
uniform vec4 newcol[30];

void main()
{
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
	for(int i=0;i<30;i++) {
		vec4 oc=oldcol[i];
		vec4 nc=newcol[i];
		if(oc.a != 0.0 && nc.a != 0.0
		&& col.rgb == oc.rgb) 
		{
			col.rgb = oc.rgb;
		}
	}
	gl_FragColor = v_vColour * col;
}
