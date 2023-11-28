Shader "Unlit/BackgroundSetup"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	_SurfaceColor ("Surface Color", Color) = (1., 1., 1., 1.)
	_LineColor ("Line Color", Color) = (1., 1., 1., 1.)
	_DarknnesFactor ("DarknnesFactor", Float) = 1.
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
	Cull Front

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
		float3 normals : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
		float3 normals : NORMAL;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST, _SurfaceColor, _LineColor;
	    float _DarknnesFactor;

            v2f vert (appdata v)
            {
                v2f o;
		o.normals = v.normals;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
		i.uv *= float2(4, 8);
		i.uv = frac(i.uv);
		i.uv -= .5;

		fixed c = 0;
		c = step(.01, abs(i.uv.x));
		c *= step(.01, abs(i.uv.y));
		//c = clamp(c, 0, 1);
		//return (c);
		return (_SurfaceColor * c + _LineColor * (1 - c)) * max(_DarknnesFactor, abs(i.normals.x));
		return fixed4(abs(i.normals), 1.);
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
