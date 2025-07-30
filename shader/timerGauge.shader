Shader "Unlit/timerGauge"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SubTex ("Texture", 2D) = "white" {}
        _Theta ("Theta", Range(0.01,100.0)) = 0.01
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
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _SubTex;
            float4 _MainTex_ST;
            float _Theta;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 c1 = tex2D(_MainTex, i.uv);
                fixed4 c2 = tex2D(_SubTex, i.uv);
                float2 uv = i.uv - 0.5;
                uv = float2(-uv.y, -uv.x);
                float angle = atan2(uv.y,uv.x)*50/3.1415+50;
                if(angle > _Theta) {
                    return c1;
                }
                return c2;
            }
            ENDCG
        }
    }
}
