﻿Shader "Dirty/Perlin2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _TextureScalar ("texture scalar", Float) = 1
        _WooblyFactor ("Woobly", Float) = 1
        _Speed ("Speed", Float) = 1
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
            #include "PerlinNoise.cginc"
 
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
            float4 _MainTex_ST;
 
            float _TextureScalar;
            float _WooblyFactor;
            float _Speed;
 
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
 
            fixed4 frag (v2f i) : SV_Target
            {
                i.uv.x += _Time * _Speed;
                i.uv *= _TextureScalar;
                float _p = perlinNoise(float3(i.uv.x, i.uv.y,_Time.x*_WooblyFactor));
                return float4(_p,_p,_p,1);
            }
            ENDCG
        }
    }
}