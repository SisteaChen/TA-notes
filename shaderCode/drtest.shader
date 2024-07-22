Shader "Unlit/drtest"
{
    Properties
    {
        _Float("Float",Float) = 0.0
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color) = (0.5,0.5,0.5,0.5)
    }
    SubShader
    {
      

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_dr
            #pragma fragment frag_dr
            // make fog work
           #include "UnityCG.cginc"

           struct appdata
           {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
           };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;

            };

            float4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert_dr(appdata v)
            {
                v2f o;
                float4 pos_world = mul(unity_ObjectToWorld, v.vertex);
                float4 pos_view = mul(UNITY_MATRIX_V, pos_world);
                float4 pos_clip = mul(UNITY_MATRIX_P, pos_view);
                o.pos = pos_clip;
                o.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;

            }

            float4 frag_dr(v2f i) : SV_Target
            {
                float4 col = tex2D(_MainTex, i.uv);
                return col;
                
            }

            ENDCG
        }
    }
}
