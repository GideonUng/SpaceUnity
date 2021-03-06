// Shader created with Shader Forge v1.17 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.17;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:1,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:2865,x:32715,y:32672,varname:node_2865,prsc:2|diff-7736-RGB,spec-5120-R,gloss-5120-A,normal-5964-RGB,emission-1813-OUT;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31921,y:32620,ptovrint:True,ptlb:Base Color,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bb27fd9a9246c6f46a35c3b46715abb8,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5964,x:32407,y:32978,ptovrint:True,ptlb:Normal Map,ptin:_BumpMap,varname:_BumpMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:5dd7b19eaead1b6499caff491b9f9b95,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Slider,id:1813,x:32250,y:32882,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:_Gloss,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:5120,x:31921,y:32820,ptovrint:False,ptlb:node_5120,ptin:_node_5120,varname:node_5120,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:84d9a2ef484ab1b47862d1c493933d0b,ntxv:0,isnm:False;proporder:5964-7736-1813-5120;pass:END;sub:END;*/

Shader "Shader Forge/NewShader" {
    Properties {
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _MainTex ("Base Color", 2D) = "white" {}
        _Gloss ("Gloss", Range(0, 1)) = 0
        _node_5120 ("node_5120", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _Gloss;
            uniform sampler2D _node_5120; uniform float4 _node_5120_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
            #endif
            #ifdef DYNAMICLIGHTMAP_ON
                o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
            #endif
            o.normalDir = UnityObjectToWorldNormal(v.normal);
            o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
            o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
            o.posWorld = mul(_Object2World, v.vertex);
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            return o;
        }
        void frag(
            VertexOutput i,
            out half4 outDiffuse : SV_Target0,
            out half4 outSpecSmoothness : SV_Target1,
            out half4 outNormal : SV_Target2,
            out half4 outEmission : SV_Target3 )
        {
            i.normalDir = normalize(i.normalDir);
            float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
/// Vectors:
            float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
            float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
            float3 normalLocal = _BumpMap_var.rgb;
            float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
            float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
// Lighting:
            float Pi = 3.141592654;
            float InvPi = 0.31830988618;
///// Gloss:
            float4 _node_5120_var = tex2D(_node_5120,TRANSFORM_TEX(i.uv0, _node_5120));
            float gloss = _node_5120_var.a;
/// GI Data:
            UnityLight light; // Dummy light
            light.color = 0;
            light.dir = half3(0,1,0);
            light.ndotl = max(0,dot(normalDirection,light.dir));
            UnityGIInput d;
            d.light = light;
            d.worldPos = i.posWorld.xyz;
            d.worldViewDir = viewDirection;
            d.atten = 1;
            #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                d.ambient = 0;
                d.lightmapUV = i.ambientOrLightmapUV;
            #else
                d.ambient = i.ambientOrLightmapUV;
            #endif
            d.boxMax[0] = unity_SpecCube0_BoxMax;
            d.boxMin[0] = unity_SpecCube0_BoxMin;
            d.probePosition[0] = unity_SpecCube0_ProbePosition;
            d.probeHDR[0] = unity_SpecCube0_HDR;
            d.boxMax[1] = unity_SpecCube1_BoxMax;
            d.boxMin[1] = unity_SpecCube1_BoxMin;
            d.probePosition[1] = unity_SpecCube1_ProbePosition;
            d.probeHDR[1] = unity_SpecCube1_HDR;
            UnityGI gi = UnityGlobalIllumination (d, 1, gloss, normalDirection);
// Specular:
            float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
            float3 diffuseColor = _MainTex_var.rgb; // Need this for specular when using metallic
            float specularMonochrome;
            float3 specularColor;
            diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _node_5120_var.r, specularColor, specularMonochrome );
            specularMonochrome = 1-specularMonochrome;
            float NdotV = max(0.0,dot( normalDirection, viewDirection ));
            half grazingTerm = saturate( gloss + specularMonochrome );
            float3 indirectSpecular = (gi.indirect.specular);
            indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/// Diffuse:
            float3 indirectDiffuse = float3(0,0,0);
            indirectDiffuse += gi.indirect.diffuse;
// Emissive:
            float3 emissive = float3(_Gloss,_Gloss,_Gloss);
// Final Color:
            outDiffuse = half4( diffuseColor, 1 );
            outSpecSmoothness = half4( specularColor, gloss );
            outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
            outEmission = half4( float3(_Gloss,_Gloss,_Gloss), 1 );
            outEmission.rgb += indirectSpecular * 1;
            outEmission.rgb += indirectDiffuse * diffuseColor;
            #ifndef UNITY_HDR_ON
                outEmission.rgb = exp2(-outEmission.rgb);
            #endif
        }
        ENDCG
    }
    Pass {
        Name "FORWARD"
        Tags {
            "LightMode"="ForwardBase"
        }
        
        
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #define UNITY_PASS_FORWARDBASE
        #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
        #define _GLOSSYENV 1
        #include "UnityCG.cginc"
        #include "AutoLight.cginc"
        #include "Lighting.cginc"
        #include "UnityPBSLighting.cginc"
        #include "UnityStandardBRDF.cginc"
        #pragma multi_compile_fwdbase_fullshadows
        #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
        #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
        #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
        #pragma multi_compile_fog
        #pragma exclude_renderers metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
        #pragma target 3.0
        uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
        uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
        uniform float _Gloss;
        uniform sampler2D _node_5120; uniform float4 _node_5120_ST;
        struct VertexInput {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 tangent : TANGENT;
            float2 texcoord0 : TEXCOORD0;
            float2 texcoord1 : TEXCOORD1;
            float2 texcoord2 : TEXCOORD2;
        };
        struct VertexOutput {
            float4 pos : SV_POSITION;
            float2 uv0 : TEXCOORD0;
            float2 uv1 : TEXCOORD1;
            float2 uv2 : TEXCOORD2;
            float4 posWorld : TEXCOORD3;
            float3 normalDir : TEXCOORD4;
            float3 tangentDir : TEXCOORD5;
            float3 bitangentDir : TEXCOORD6;
            LIGHTING_COORDS(7,8)
            UNITY_FOG_COORDS(9)
            #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                float4 ambientOrLightmapUV : TEXCOORD10;
            #endif
        };
        VertexOutput vert (VertexInput v) {
            VertexOutput o = (VertexOutput)0;
            o.uv0 = v.texcoord0;
            o.uv1 = v.texcoord1;
            o.uv2 = v.texcoord2;
            #ifdef LIGHTMAP_ON
                o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                o.ambientOrLightmapUV.zw = 0;
            #elif UNITY_SHOULD_SAMPLE_SH
        #endif
        #ifdef DYNAMICLIGHTMAP_ON
            o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
        #endif
        o.normalDir = UnityObjectToWorldNormal(v.normal);
        o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
        o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
        o.posWorld = mul(_Object2World, v.vertex);
        float3 lightColor = _LightColor0.rgb;
        o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
        UNITY_TRANSFER_FOG(o,o.pos);
        TRANSFER_VERTEX_TO_FRAGMENT(o)
        return o;
    }
    float4 frag(VertexOutput i) : COLOR {
        i.normalDir = normalize(i.normalDir);
        float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
// Vectors:
        float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
        float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
        float3 normalLocal = _BumpMap_var.rgb;
        float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
        float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
        float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
        float3 lightColor = _LightColor0.rgb;
        float3 halfDirection = normalize(viewDirection+lightDirection);
// Lighting:
        float attenuation = LIGHT_ATTENUATION(i);
        float3 attenColor = attenuation * _LightColor0.xyz;
        float Pi = 3.141592654;
        float InvPi = 0.31830988618;
// Gloss:
        float4 _node_5120_var = tex2D(_node_5120,TRANSFORM_TEX(i.uv0, _node_5120));
        float gloss = _node_5120_var.a;
        float specPow = exp2( gloss * 10.0+1.0);
// GI Data:
        UnityLight light;
        #ifdef LIGHTMAP_OFF
            light.color = lightColor;
            light.dir = lightDirection;
            light.ndotl = LambertTerm (normalDirection, light.dir);
        #else
            light.color = half3(0.f, 0.f, 0.f);
            light.ndotl = 0.0f;
            light.dir = half3(0.f, 0.f, 0.f);
        #endif
        UnityGIInput d;
        d.light = light;
        d.worldPos = i.posWorld.xyz;
        d.worldViewDir = viewDirection;
        d.atten = attenuation;
        #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
            d.ambient = 0;
            d.lightmapUV = i.ambientOrLightmapUV;
        #else
            d.ambient = i.ambientOrLightmapUV;
        #endif
        d.boxMax[0] = unity_SpecCube0_BoxMax;
        d.boxMin[0] = unity_SpecCube0_BoxMin;
        d.probePosition[0] = unity_SpecCube0_ProbePosition;
        d.probeHDR[0] = unity_SpecCube0_HDR;
        d.boxMax[1] = unity_SpecCube1_BoxMax;
        d.boxMin[1] = unity_SpecCube1_BoxMin;
        d.probePosition[1] = unity_SpecCube1_ProbePosition;
        d.probeHDR[1] = unity_SpecCube1_HDR;
        UnityGI gi = UnityGlobalIllumination (d, 1, gloss, normalDirection);
        lightDirection = gi.light.dir;
        lightColor = gi.light.color;
// Specular:
        float NdotL = max(0, dot( normalDirection, lightDirection ));
        float LdotH = max(0.0,dot(lightDirection, halfDirection));
        float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
        float3 diffuseColor = _MainTex_var.rgb; // Need this for specular when using metallic
        float specularMonochrome;
        float3 specularColor;
        diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _node_5120_var.r, specularColor, specularMonochrome );
        specularMonochrome = 1-specularMonochrome;
        float NdotV = max(0.0,dot( normalDirection, viewDirection ));
        float NdotH = max(0.0,dot( normalDirection, halfDirection ));
        float VdotH = max(0.0,dot( viewDirection, halfDirection ));
        float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
        float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
        float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
        float3 directSpecular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
        half grazingTerm = saturate( gloss + specularMonochrome );
        float3 indirectSpecular = (gi.indirect.specular);
        indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
        float3 specular = (directSpecular + indirectSpecular);
// Diffuse:
        NdotL = max(0.0,dot( normalDirection, lightDirection ));
        half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
        float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
        float3 indirectDiffuse = float3(0,0,0);
        indirectDiffuse += gi.indirect.diffuse;
        float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
// Emissive:
        float3 emissive = float3(_Gloss,_Gloss,_Gloss);
// Final Color:
        float3 finalColor = diffuse + specular + emissive;
        fixed4 finalRGBA = fixed4(finalColor,1);
        UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
        return finalRGBA;
    }
    ENDCG
}
Pass {
    Name "FORWARD_DELTA"
    Tags {
        "LightMode"="ForwardAdd"
    }
    Blend One One
    
    
    CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag
    #define UNITY_PASS_FORWARDADD
    #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
    #define _GLOSSYENV 1
    #include "UnityCG.cginc"
    #include "AutoLight.cginc"
    #include "Lighting.cginc"
    #include "UnityPBSLighting.cginc"
    #include "UnityStandardBRDF.cginc"
    #pragma multi_compile_fwdadd_fullshadows
    #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
    #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
    #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
    #pragma multi_compile_fog
    #pragma exclude_renderers metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
    #pragma target 3.0
    uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
    uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
    uniform float _Gloss;
    uniform sampler2D _node_5120; uniform float4 _node_5120_ST;
    struct VertexInput {
        float4 vertex : POSITION;
        float3 normal : NORMAL;
        float4 tangent : TANGENT;
        float2 texcoord0 : TEXCOORD0;
        float2 texcoord1 : TEXCOORD1;
        float2 texcoord2 : TEXCOORD2;
    };
    struct VertexOutput {
        float4 pos : SV_POSITION;
        float2 uv0 : TEXCOORD0;
        float2 uv1 : TEXCOORD1;
        float2 uv2 : TEXCOORD2;
        float4 posWorld : TEXCOORD3;
        float3 normalDir : TEXCOORD4;
        float3 tangentDir : TEXCOORD5;
        float3 bitangentDir : TEXCOORD6;
        LIGHTING_COORDS(7,8)
    };
    VertexOutput vert (VertexInput v) {
        VertexOutput o = (VertexOutput)0;
        o.uv0 = v.texcoord0;
        o.uv1 = v.texcoord1;
        o.uv2 = v.texcoord2;
        o.normalDir = UnityObjectToWorldNormal(v.normal);
        o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
        o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
        o.posWorld = mul(_Object2World, v.vertex);
        float3 lightColor = _LightColor0.rgb;
        o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
        TRANSFER_VERTEX_TO_FRAGMENT(o)
        return o;
    }
    float4 frag(VertexOutput i) : COLOR {
        i.normalDir = normalize(i.normalDir);
        float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
// Vectors:
        float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
        float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
        float3 normalLocal = _BumpMap_var.rgb;
        float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
        float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
        float3 lightColor = _LightColor0.rgb;
        float3 halfDirection = normalize(viewDirection+lightDirection);
// Lighting:
        float attenuation = LIGHT_ATTENUATION(i);
        float3 attenColor = attenuation * _LightColor0.xyz;
        float Pi = 3.141592654;
        float InvPi = 0.31830988618;
// Gloss:
        float4 _node_5120_var = tex2D(_node_5120,TRANSFORM_TEX(i.uv0, _node_5120));
        float gloss = _node_5120_var.a;
        float specPow = exp2( gloss * 10.0+1.0);
// Specular:
        float NdotL = max(0, dot( normalDirection, lightDirection ));
        float LdotH = max(0.0,dot(lightDirection, halfDirection));
        float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
        float3 diffuseColor = _MainTex_var.rgb; // Need this for specular when using metallic
        float specularMonochrome;
        float3 specularColor;
        diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _node_5120_var.r, specularColor, specularMonochrome );
        specularMonochrome = 1-specularMonochrome;
        float NdotV = max(0.0,dot( normalDirection, viewDirection ));
        float NdotH = max(0.0,dot( normalDirection, halfDirection ));
        float VdotH = max(0.0,dot( viewDirection, halfDirection ));
        float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
        float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
        float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
        float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
        float3 specular = directSpecular;
// Diffuse:
        NdotL = max(0.0,dot( normalDirection, lightDirection ));
        half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
        float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
        float3 diffuse = directDiffuse * diffuseColor;
// Final Color:
        float3 finalColor = diffuse + specular;
        return fixed4(finalColor * 1,0);
    }
    ENDCG
}
Pass {
    Name "Meta"
    Tags {
        "LightMode"="Meta"
    }
    Cull Off
    
    CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag
    #define UNITY_PASS_META 1
    #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
    #define _GLOSSYENV 1
    #include "UnityCG.cginc"
    #include "Lighting.cginc"
    #include "UnityPBSLighting.cginc"
    #include "UnityStandardBRDF.cginc"
    #include "UnityMetaPass.cginc"
    #pragma fragmentoption ARB_precision_hint_fastest
    #pragma multi_compile_shadowcaster
    #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
    #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
    #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
    #pragma multi_compile_fog
    #pragma exclude_renderers metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
    #pragma target 3.0
    uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
    uniform float _Gloss;
    uniform sampler2D _node_5120; uniform float4 _node_5120_ST;
    struct VertexInput {
        float4 vertex : POSITION;
        float2 texcoord0 : TEXCOORD0;
        float2 texcoord1 : TEXCOORD1;
        float2 texcoord2 : TEXCOORD2;
    };
    struct VertexOutput {
        float4 pos : SV_POSITION;
        float2 uv0 : TEXCOORD0;
        float2 uv1 : TEXCOORD1;
        float2 uv2 : TEXCOORD2;
        float4 posWorld : TEXCOORD3;
    };
    VertexOutput vert (VertexInput v) {
        VertexOutput o = (VertexOutput)0;
        o.uv0 = v.texcoord0;
        o.uv1 = v.texcoord1;
        o.uv2 = v.texcoord2;
        o.posWorld = mul(_Object2World, v.vertex);
        o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
        return o;
    }
    float4 frag(VertexOutput i) : SV_Target {
// Vectors:
        float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
        UnityMetaInput o;
        UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
        
        o.Emission = float3(_Gloss,_Gloss,_Gloss);
        
        float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
        float3 diffColor = _MainTex_var.rgb;
        float specularMonochrome;
        float3 specColor;
        float4 _node_5120_var = tex2D(_node_5120,TRANSFORM_TEX(i.uv0, _node_5120));
        diffColor = DiffuseAndSpecularFromMetallic( diffColor, _node_5120_var.r, specColor, specularMonochrome );
        float roughness = 1.0 - _node_5120_var.a;
        o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
        
        return UnityMetaFragment( o );
    }
    ENDCG
}
}
FallBack "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}
