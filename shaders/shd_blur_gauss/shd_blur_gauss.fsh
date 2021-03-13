//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec2 iResolution = vec2(375., 667.);
 
    float offset[4];
    offset[1] = 0.; offset[2] = 1.3846153846; offset[3] = 3.2307692308;
 
    float weight[4];
    weight[1] = 0.2270270270; weight[2] = 0.3162162162; weight[3] = 0.0702702703;
 
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord/iResolution) * weight[0];
 
    // 垂直
    for (int i=1; i<=3; i++) {
        color +=
            texture2D(gm_BaseTexture, (v_vTexcoord+vec2(0.0, offset[i]))/iResolution)
                * weight[i];
        color +=
            texture2D(gm_BaseTexture, (v_vTexcoord-vec2(0.0, offset[i]))/iResolution)
                * weight[i];
    }
 
    vec4 color2 = texture2D(gm_BaseTexture, v_vTexcoord/iResolution) * weight[0];
 
    // 水平
    for (int i=1; i<=3; i++) {
        color2 +=
            texture2D(gm_BaseTexture, (v_vTexcoord+vec2(offset[i], 0.0))/iResolution)
                * weight[i];
        color2 +=
            texture2D(gm_BaseTexture, (v_vTexcoord-vec2(offset[i], 0.0))/iResolution)
                * weight[i];
    }
 
    gl_FragColor = mix(color, color2, .5);
	//gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
