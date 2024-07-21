project "mimalloc"
    kind "SharedLib"
    language "C"
    staticruntime "off"
    warnings "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "external/mimalloc/include/mimalloc.h",
        "external/mimalloc/include/mimalloc-override.h",
        "external/mimalloc/src/static.c",
        "external/mimalloc/src/alloc.c",
        "external/mimalloc/src/arena.c",
        "external/mimalloc/src/free.c",
        "external/mimalloc/src/options.c",
        "external/mimalloc/src/page.c",
        "external/mimalloc/src/region.c",
        "external/mimalloc/src/segment.c",
        "external/mimalloc/src/stats.c",
        "external/mimalloc/src/init.c",
        "external/mimalloc/src/random.c"
    }

    filter "system:linux"
        pic "On"

        systemversion "latest"
        
        files
        {
            "external/mimalloc/src/os.c",
            "external/mimalloc/src/alloc-override.c",
            "external/mimalloc/src/prim/os.c",
            "external/mimalloc/src/prim/random.c"
        }

        defines
        {
            "MI_USE_LINUX"
        }

    filter "system:macosx"
        pic "On"

        files
        {
            "external/mimalloc/src/os.c",
            "external/mimalloc/src/alloc-override.c",
            "external/mimalloc/src/prim/os.c",
            "external/mimalloc/src/prim/random.c"
        }

        defines
        {
            "MI_USE_OSX"
        }

    filter "system:windows"
        systemversion "latest"

        files
        {
            "external/mimalloc/src/os.c",
            "external/mimalloc/src/alloc-override.c",
            "external/mimalloc/src/prim/os.c",
            "external/mimalloc/src/prim/random.c"
        }

        defines 
        { 
            "MI_USE_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        buildoptions { "/MD" }
        runtime "Release"
        optimize "speed"

    filter "configurations:Distribution"
        buildoptions { "/MD" }
        runtime "Release"
        optimize "speed"
        symbols "off"