Shader "Unlit/PostProcessing"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	_Factor ("Factor", Float) = .1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
	    float _Factor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
		fixed b = .7;
		fixed a = (1 - b) / .25;
		i.uv.x -= .5;
		i.uv.x *= (b + a * pow(i.uv.y - .5, 2));
		i.uv.x += .5;

		fixed yd = .1;
		fixed yu = 1 - yd;

		fixed defdown = (i.uv.x * (1 + yd - i.uv.y) + (-yd + i.uv.y) / 2);
		fixed stdown = step(i.uv.y, yd);

		fixed defup = (i.uv.x * (1 + yd - (1 - i.uv.y)) + (-yd + (1 - i.uv.y)) / 2);
		fixed stup = step(yu, i.uv.y);


		i.uv.x = defdown * stdown + ( 1 - stup) * (1 - stdown) * i.uv.x + defup * stup;
		
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
