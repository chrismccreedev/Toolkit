// Unlit shader. Simplest possible colored shader.
// - no lighting
// - no lightmap support
// - no texture

Shader "Custom/Unlit/Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "" { }
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };
            
            struct v2f
            {
                float4 vertex: SV_POSITION;
                float2 uv: TEXCOORD0;
            };
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // Equivalent to:
                // o.uv = _MainTex_ST.xy * v.uv.xy + _MainTex_ST.zw;
                
                return o;
            }
            
            fixed4 frag(v2f i): SV_TARGET
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}